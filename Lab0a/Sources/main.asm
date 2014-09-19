;**************************************************************
;* This stationery serves as the framework for a              *
;* user application. For a more comprehensive program that    *
;* demonstrates the more advanced functionality of this       *
;* processor, please see the demonstration applications       *
;* located in the examples subdirectory of the                *
;* Freescale CodeWarrior for the HC12 Program directory       *
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


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts

Init:
        ldaa #$00 ;clear accumulator A
        ldab #$00 ;clear accumulator B
Start: ;Star of your code
LoadVal: ;Intialization portion
        ldaa #$00 ;Load accum. A with a value,
;in this case we choose 0x71

CheckVal: ;Meat of the program
        cmpa #$41 ;compare to 0x41
        blt Winston ;What happend?
        cmpa #$7a
        bgt Winston ;What happend?
        ldab #$01
        bra Julia
Winston:
        ldab #$00 ;What happend?
Julia:
Over:
        nop
        nop
        bra Over ;Why?
        end

