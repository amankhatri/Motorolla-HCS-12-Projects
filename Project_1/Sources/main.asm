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
fred        ds.b 1  ;ds.b is assembler directive. it is for code warrior saying declare fred of size 1 byte
george      ds.b 1
ralph       ds.b 1

; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts


            LDAA george
            ADDA ralph 
            STAA fred  ;now if we don't stop it the processor would be keep running instruction from memory randomly
            NOP         ; but i can give only so many NOP instruction so lets have a loop around nop
hangHereForever:
            NOP
            BRA  hangHereForever
            end 