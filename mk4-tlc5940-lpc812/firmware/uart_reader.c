/******************************************************************************

    This function returns after having successfully received a complete
    preprocessor protocol frame via the UART.

 *****************************************************************************/
#include <stdint.h>

#include <hal.h>
#include <globals.h>


#define SLAVE_MAGIC_BYTE 0x87
#define CONSECUTIVE_BYTE_COUNTS 3


typedef enum {
    STATE_WAIT_FOR_MAGIC_BYTE = 0,
    STATE_STEERING,
    STATE_THROTTLE,
    STATE_CH3
} STATE_T;


// ****************************************************************************
void init_uart_reader(void)
{
    // Nothing to do
}


// ****************************************************************************
static void normalize_channel(CHANNEL_T *c, uint8_t data)
{
    if (data > 127) {
        c->normalized = -(256 - data);
    }
    else {
        c->normalized = data;
    }

    if (c->reversed) {
        c->normalized = -c->normalized;
    }

    if (c->normalized < 0) {
        c->absolute = -c->normalized;
    }
    else {
        c->absolute = c->normalized;
    }
}


// ****************************************************************************
static void publish_channels(uint8_t channel_data[])
{
    normalize_channel(&channel[ST], channel_data[0]);
    normalize_channel(&channel[TH], channel_data[1]);

    global_flags.initializing =
        (channel_data[2] & 0x10) ? true : false;

    if (!config.flags.ch3_is_local_switch) {
        normalize_channel(&channel[CH3],
            (channel_data[2] & 0x01) ? 100 : -100);
    }

    global_flags.new_channel_data = true;
}


// ****************************************************************************
void read_preprocessor(void)
{
    static STATE_T state = STATE_WAIT_FOR_MAGIC_BYTE;
    static uint8_t channel_data[3];

    uint8_t uart_byte;


    // We let the read_preprocessor function operate even if SERVO_READER
    // is active, so that for test purpose the UART can still send us
    // servo data (e.g. via WebUSB, or a dedicated serial port).
    // It is up to the HAL to make the actual function available.

    // if (config.mode != MASTER_WITH_UART_READER) {
    //     return;
    // }

    while (HAL_getchar_pending()) {
        uart_byte = HAL_getchar();

        // The preprocessor protocol is designed such that only the first
        // byte can have the MAGIC value. This allows us to be in sync at all
        // times.
        // If we receive the MAGIC value we know it is the first byte, so we
        // can kick off the state machine.
        if (uart_byte == SLAVE_MAGIC_BYTE) {
            state = STATE_STEERING;
            return;
        }

        switch (state) {
            case STATE_WAIT_FOR_MAGIC_BYTE:
                // Nothing to do; SLAVE_MAGIC_BYTE is checked globally
                break;

            case STATE_STEERING:
                channel_data[0] = uart_byte;
                state = STATE_THROTTLE;
                break;

            case STATE_THROTTLE:
                channel_data[1] = uart_byte;
                state = STATE_CH3;
                break;

            case STATE_CH3:
                channel_data[2] = uart_byte;
                publish_channels(channel_data);
                state = STATE_WAIT_FOR_MAGIC_BYTE;
                break;

            default:
                state = STATE_WAIT_FOR_MAGIC_BYTE;
                break;
        }
    }
}

