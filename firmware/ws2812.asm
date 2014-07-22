;******************************************************************************
;
;   ws2812.asm
;
;******************************************************************************
;
;   Author:         Werner Lane
;   E-mail:         laneboysrc@gmail.com
;
;******************************************************************************
    TITLE       WS2812 driver
    LIST        r=dec
    RADIX       dec

    #include    hw.tmp

    EXTERN temp
    EXTERN light_data


;******************************************************************************
; Init_WS2812
;
; Initializes the operation of the WS2812 (or PL9823) LEDs and sets all LED 
; outputs to Off.
; 
; The LEDs seem to have a reset timeing themselves, so we send the commands
; repeatidely for a certain time, which was determined using experiments.
; 
; Note that the LEDs, especially the PL9823, still flash after power on, nothing 
; we can do about this.
;******************************************************************************
.ws2812_Init_WS2812 CODE
    GLOBAL Init_WS2812
Init_WS2812

;    for (i = 0; i < 10; i++) {
;        // This delay is to ensure the minimum 50us reset time of the LEDs
    movlw   10
    movwf   temp
low_loop:
    nop
    nop
    decfsz temp, f
    goto    low_loop      
    
    call    WS2812_send
    return


;******************************************************************************
; WS2812_send
;
; Sends the value in the light_data registers to the WS2812 (or PL9823) LEDs.
;
;
; According to:  
;    http://cpldcpu.wordpress.com/2014/01/14/light_ws2812-library-v2-0-part-i-understanding-the-ws2812/
;
; - A reset is issued as early as at 9 µs, contrary to the 50 µs mentioned in 
;   the data sheet. Longer delays between transmissions should be avoided.
;
; - The cycle time of a bit should be at least 1.25 µs, the value given in the 
;   data sheet, and at most ~9 µs, the shortest time for a reset.
;
; - A “0″ can be encoded with a pulse as short as 62.5 ns, but should not be 
;   longer than ~500 ns (maximum on WS2812).
;
; - A “1″ can be encoded with pulses almost as long as the total cycle time, 
;   but it should not be shorter than ~625 ns (minimum on WS2812B). 
;
; By using assembler we can get the delay between two bytes from 5us down 
; to 3us!
; 
; This means we can send data for 12 LEDs within 500us.
; 
;******************************************************************************
.ws2812_WS2812_send CODE
    GLOBAL WS2812_send
WS2812_send

#define ws2812_array_count temp+1

    movlw	LOW light_data
    movwf   FSR0L
    movlw	HIGH light_data
    movwf   FSR0H

    BANKSEL ws2812_array_count
    movlw   3 * NUMBER_OF_LEDS
    movwf   ws2812_array_count

WS2812_send_loop:
    movlw   8
    movwf   temp
    moviw   FSR0++

WS2812_send_byte_loop:    
    btfsc   WREG, 7
    goto    WS2812_send_byte_loop_high
    
WS2812_send_byte_loop_low:
    bsf     PORT_WS2812_OUT                 ; LOW: 3 cycles = 375ns
    nop
    nop
    bcf     PORT_WS2812_OUT                 
    ; The loop takes 10 cycles from here to reach the next bit, which is 1000ns. 
    ; This makes the total LOW pulse duration ~1375ns, which is fine according
    ; to the info referenced above.
    goto    WS2812_send_byte_loop_end
    
WS2812_send_byte_loop_high:
    bsf     PORT_WS2812_OUT                 ; HIGH: 6 cycles = 750ns
    nop
    nop
    nop
    nop
    nop
    bcf     PORT_WS2812_OUT
    ; From here the loop takes 7 cycles until the next bit, which is more than 
    ; needed.

WS2812_send_byte_loop_end:
    rlf     WREG, f
    decfsz  temp, f
    goto    WS2812_send_byte_loop    	

    decfsz  ws2812_array_count, f
    goto    WS2812_send_loop

    return

    END
