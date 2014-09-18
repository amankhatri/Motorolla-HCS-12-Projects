;**************************************************************
;* Demo1.asm this is an awesome in class Demo by              *
;* the super huble and magnificent Marstrender                *
;* 8 Sept 2014 ak original coding                             *
;**************************************************************
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
;Counter     ds.w 1
;FiboRes     ds.w 1

; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts
;real and imaginary 1

            LDAA #$1
            STAA $1001 
            LDAB #$1
            STAB $1002
;real and imaginary 2           
            LDAA #$1
            STAA $1003 
            LDAB #$1
            STAB $1004
;real and imaginary 3           
            LDAA #$1
            STAA $1005 
            LDAB #$1
            STAB $1006
;real and imaginary 4           
            LDAA #$1
            STAA $1007 
            LDAB #$1
            STAB $1008
;real and imaginary 5     
            LDAA #$1
            STAA $1009 
            LDAB #$1
            STAB $1010  
;add real parts and store it in accumulator A
            LDAA $1001
            ADDA $1003
            ADDA $1005
            ADDA $1007
            ADDA $1009
;add imaginary parts and store it in accumulator b     
            LDAB $1002
            ADDB $1004
            ADDB $1006
            ADDB $1008
            ADDB $1010 
;peter asked me to swap the contents of accumulator A and accumulator B
            STAA $1011
            STAB $1012
            LDAA $1012
            LDAB $1011 
      
hangHereForever:
            NOP
            BRA  hangHereForever
            end 