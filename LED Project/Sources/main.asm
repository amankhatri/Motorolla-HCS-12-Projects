;************************************************************************************************************
;* Turn on 2nd LED                                                                                          *
;*                                                                                                          *
;************************************************************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack




; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
Counter     ds.w 1
FiboRes     ds.w 1


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts

;************************************************************************************************************
;* Configuring Data Darection Register for port B. This would set bit two of data direction register to 1   *
;* which would let the data pass through port b to data direction register and the data direction register  *
;* would output the data to the processor                                                                   *
;************************************************************************************************************
    LDAA DDRB
    ORAA #$04
    STAA DDRB
;************************************************************************************************************
;* Since we have to turn on led corresponding to bit 2 (3rd) led we would set portb bit two to 1. that is   *
;* P26.                                                                                                     *
;*                                                                                                          *
;************************************************************************************************************
    LDAA PORTB
    ORAA #$04
    STAA PORTB
;************************************************************************************************************
;* Configuring Data Darection Register for port J. This would set bit one of data direction register to 1   *
;* which would let the data pass through port J to data direction register and the data direction register  *
;* would output the data to the processor                                                                   *
;************************************************************************************************************    
    LDAA DDRJ
    ORAA #$02
    STAA DDRJ
;************************************************************************************************************
;* Since we have to turn on led corresponding to bit 2 (3rd) led we would set portj bit one to 0. that is   *
;* P21. we have to make sure that current flows from portb(0,1,2,3,4,5,6,7) to portj pin 1 or pin 21 or     *
;* processor                                                                                                *
;************************************************************************************************************  
    LDAA PTJ
    ORAA #$FD
    STAA PTJ
hangInhereForever:
    nop     
    bra           hangInhereForever    