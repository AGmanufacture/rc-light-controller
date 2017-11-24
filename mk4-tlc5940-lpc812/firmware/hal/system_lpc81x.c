#include <stdint.h>
#include <stdio.h>

#include <LPC8xx.h>
#include <hal.h>

#define __SYSTICK_IN_MS 20

void SysTick_handler(void);


// FIXME: make this disappear
extern volatile uint32_t systick_count;


void hal_hardware_init(bool is_servo_reader, bool has_servo_output)
{
#if __SYSTEM_CLOCK != 12000000
#error Clock initialization code expexts __SYSTEM_CLOCK to be set to 1200000
#endif

    // Turn on brown-out detection and reset
    LPC_SYSCON->BODCTRL = (1 << 4) | (1 << 2) | (3 << 0);


    // Set flash wait-states to 1 system clock
    LPC_FLASHCTRL->FLASHCFG = 0;


    // Turn on peripheral clocks for SCTimer, IOCON, SPI0
    // (GPIO, SWM alrady enabled after reset)
    LPC_SYSCON->SYSAHBCLKCTRL |= (1 << 8) | (1 << 18) | (1 << 11);


    // ------------------------
    // IO configuration

    // Enable reset, all other special functions disabled
    LPC_SWM->PINENABLE0 = 0xffffffbf;

    // Configure the UART input and output
    if (is_servo_reader) {
        // Turn the UART output on unless a servo output is requested
        if (!has_servo_output) {
            // U0_TXT_O=PIO0_12
            LPC_SWM->PINASSIGN0 = (0xff << 24) |
                                  (0xff << 16) |
                                  (0xff << 8) |
                                  (GPIO_BIT_OUT << 0);
        }
    }
    else {
        // U0_TXT_O=PIO0_4 (TH), U0_RXD_I=PIO0_0 (ST)
        LPC_SWM->PINASSIGN0 = (0xff << 24) |
                              (0xff << 16) |
                              (GPIO_BIT_ST << 8) |
                              (GPIO_BIT_TH << 0);
    }

    // Make the open drain ports PIO0_10, PIO0_11 outputs and pull to ground
    // to prevent them from floating.
    // Make the switched light output PIO0_9 an output and shut it off.
    GPIO_SWITCHED_LIGHT_OUTPUT = 0;
    LPC_GPIO_PORT->W0[10] = 0;
    LPC_GPIO_PORT->W0[11] = 0;
    LPC_GPIO_PORT->DIR0 |= (1 << 10) | (1 << 11) |
                           (1 << GPIO_BIT_SWITCHED_LIGHT_OUTPUT);


    // Enable glitch filtering on the IOs
    // GOTCHA: ICONCLKDIV0 is actually the last register in the array!
    LPC_SYSCON->IOCONCLKDIV[6] = 255;       // Glitch filter 0: Main clock divided by 255
    LPC_SYSCON->IOCONCLKDIV[5] = 1;         // Glitch filter 1: Main clock divided by 1

    // NOTE: for some reason it is absolutely necessary to enable glitch
    // filtering on the IOs used for the capture timer. One clock cytle of the
    // main clock is enough, but with none weird things happen.

    GPIO_IOCON_ST |= (1 << 5) |         // Enable Hysteresis
                     (0x1 << 13) |      // Glitch filter 1
                     (0x1 << 11);       // Reject 1 clock cycle of glitch filter

    GPIO_IOCON_TH |= (1 << 5) |         // Enable Hysteresis
                     (0x1 << 13) |      // Glitch filter 1
                     (0x1 << 11);       // Reject 1 clock cycle of glitch filter

    GPIO_IOCON_CH3 |= (1 << 5) |        // Enable Hysteresis
                      (0x1 << 13) |     // Glitch filter 1
                      (0x1 << 11);      // Reject 1 clock cycle of glitch filter


    // ------------------------
    // Configure SCTimer globally for two 16-bit counters
    LPC_SCT->CONFIG = 0;


    // ------------------------
    // SysTick configuration
    SysTick->LOAD = __SYSTEM_CLOCK * __SYSTICK_IN_MS / 1000;
    SysTick->VAL = __SYSTEM_CLOCK * __SYSTICK_IN_MS / 1000;
    SysTick->CTRL = (1 << 0) |              // Enable System Tick counter
                    (1 << 1) |              // System Tick interrupt enable
                    (1 << 2);               // Use system clock

}



// ****************************************************************************
void hal_hardware_init_final(void)
{
    // Turn off peripheral clock for IOCON and SWM to preserve power
    LPC_SYSCON->SYSAHBCLKCTRL &= ~((1 << 18) | (1 << 7));
}


// ****************************************************************************
void SysTick_handler(void)
{
    if (SysTick->CTRL & (1 << 16)) {       // Read and clear Countflag
        ++systick_count;
    }
}


// ****************************************************************************
uint32_t *hal_stack_check(void)
{
    #define CANARY 0xcafebabe

    static uint32_t *last_found = (uint32_t *)(0x10001000 - 48);
    uint32_t *now;

    if (last_found == (uint32_t *)0x10000000) {
        return NULL;
    }

    now = last_found;
    while (*now != CANARY && now > (uint32_t *)0x10000000) {
        --now;
    }

    if (now != last_found) {
        last_found = now;
        return now;
    }
    return NULL;
}
