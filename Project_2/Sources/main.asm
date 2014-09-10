;**************************************************************
;* Demo2.asm this is an awesome in class Demo by              *
;* the super huble and magnificent Marstrender                *
;* 10 Sept 2014 ak original coding                            *
;**************************************************************
; Include derivative-specific definitions
            INCLUDE 'derivative.inc'

; export symbols
            XDEF Entry, _Startup, main
            ; we use export 'Entry' as symbol. This allows us to
            ; reference 'Entry' either in the linker .prm file
            ; or from C/C++ later on

            XREF __SEG_END_SSTACK      ; symbol defined by the linker for the end of the stack



; nothing goes in the processor but the op codes
; variable/data section
MY_EXTENDED_RAM: SECTION
; Insert here your data definition.
;Counter     ds.w 1
;FiboRes     ds.w 1
fred        ds.b 1  ;ds.b is assembler directive. it is for code warrior saying declare fred of size 1 byte. 
george      ds.b 1  ; All of this is in ram section , the labels are not mandatory for the processor
ralph       ds.b 1

; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts

; project is fred = george + ralph
; extended addressing, I will give you every bit of address you will need
            LDAA george
            ADDA ralph 
            STAA fred  ;now if we don't stop it the processor would be keep running instruction from memory randomly
; immidiate mode of addressing, when I put # in front of an operand, the processor would just grab number 3 and add,
;no address required.           
            LDAA george
            ADDA #3
            STAA fred
            NOP         ; but i can give only so many NOP instruction so lets have a loop around nop
            
; store 0 in fred
            LDAA #0
            STAA fred 
;store 3 in george
            LDAA #3
            STAA george
loop_to_here
            LDAA george 
            ADDA #5
            STAA george
            
            LDAA fred
            ADDA #1
            STAA fred
            LDAA fred
            CMPA #3
            BLT  loop_to_here
            

hangHereForever:
            NOP       ;3)	 Inherent(inh) : in inherent mode of address we don't need to give address NOP is inh
            BRA  hangHereForever        ;bra is releative addressing mode
            end 
