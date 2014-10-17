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
;* Configuring Data Direction Register for port B. This would Make 0 1 2 3   data direction register to 1   *
;* which would let the data pass through port b to data direction register and the data direction register  *
;* would output the data to the processor                                                                   *
;************************************************************************************************************
    LDAB #$00
    LDAA DDRB
    ORAA #$FF
    STAA DDRB
;
    
    
;************************************************************************************************************
;*Make Port H an input port                                                                                 *
;************************************************************************************************************    
    LDAA DDRH
    ANDA #$FE
    STAA DDRH
;************************************************************************************************************
;* Configuring Data Darection Register for port J. This would set bit one of data direction register to 1   *
;* which would let the data pass through port J to data direction register and the data direction register  *
;* would output the data to the processor                                                                   *
;************************************************************************************************************    
    LDAA DDRJ
    ORAA #$02
    STAA DDRJ
;************************************************************************************************************
;*LAB 3 Jmars EE 337                                                                                        *
;*                                                                                                          *
;*                                                                                                          *
;************************************************************************************************************
 loopForever:   
     LDAA PTIH
     LDX #$000F    
     LDY #$FFFF
;SW5  increment
     CMPA  #$FE
     BEQ   LED 
     
;SW6 decrement
     CMPA  #$FD
     BEQ   clearCount
     bra   loopForever
    
LED:
    LDAA #$00
    LDAA PORTB
    ADDB #$01
    STAB PORTB 
    LDAA PTJ
    ORAA #$FD
    STAA PTJ
    BRA delayLoop
    
clearCount:
    LDAB #$00
    STAB PORTB
    BRA delayLoop
delayLoop: 
    NOP
    NOP
    DEX
    BNE delayLoop2
    BRA loopForever
delayLoop2:
    NOP
    NOP
    DEY
    BNE delayLoop2
    BRA delayLoop