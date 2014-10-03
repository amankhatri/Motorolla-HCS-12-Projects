;************************************************************************************************************
;* LAB 2 -Short Description: Press a switch to turn on a light                                              *
;* Aman Khatri :)                                                                                                          *
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
;* Configuring Data Direction Register for port B. This would Make 0 1 2 3   data direction register to 1   *
;* which would let the data pass through port b to data direction register and the data direction register  *
;* would output the data to the processor                                                                   *
;************************************************************************************************************
    LDAA DDRB
    ORAA #$0F
    STAA DDRB
;************************************************************************************************************
;*Make Port H an input port                                                                                 *
;************************************************************************************************************    
    LDAA DDRH
    ANDA #$F0
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
;* Since we have to turn on led corresponding to bit 0 1 2 3  led we would set portb bit two to 1.          *
;*                                                                                                          *
;*                                                                                                          *
;************************************************************************************************************
 loopForever:   
     LDAA PTIH
;SW2
     CMPA  #$FE
     BEQ   LED0 
;SW3
     CMPA  #$FD
     BEQ   LED1
;SW4
     CMPA  #$FB
     BEQ   LED2
;SW5
     CMPA  #$F7
     BEQ   LED3 
     bra         loopForever
    
LED0:
    LDAA #$00
    LDAA PORTB
    ORAA #01
    STAA PORTB 
    LDAA PTJ
    ORAA #$FD
    STAA PTJ  
    BRA  loopForever
LED1:
    LDAA #$00
    LDAA PORTB
    ORAA #02
    STAA PORTB
    LDAA PTJ
    ORAA #$FD
    STAA PTJ   
    BRA  loopForever
LED2:
    LDAA #$00
    LDAA PORTB
    ORAA #04
    STAA PORTB   
    LDAA PTJ
    ORAA #$FD
    STAA PTJ
    BRA  loopForever
LED3:
    LDAA #$00
    LDAA PORTB
    ORAA #08
    STAA PORTB
    LDAA PTJ
    ORAA #$FD
    STAA PTJ   
    BRA  loopForever
   