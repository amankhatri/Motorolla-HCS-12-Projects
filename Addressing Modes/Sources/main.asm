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
Counter     ds.w 1
FiboRes     ds.w 1


; code section
MyCode:     SECTION
main:
_Startup:
Entry:
            LDS  #__SEG_END_SSTACK     ; initialize the stack pointer
            CLI                     ; enable interrupts




;******************************************************************
;* Indexed Addressing Mode: Address = Base Address + Offset       *
;* The base address is taken from base registers X,Y,SP or PC     *
;* The Offset may be a constant (5bit 9Bit or 16Bits) or the      *
;* contents of accumulator A,B,D. The sum of the Base Register &  *
;* the offeset doesnt point to the actual operand or the jump     *
;* target. Instead it points to the memory location that holds the*
;* address of the actual operand or jump target                   *
;******************************************************************

;this demonstrates indexed addressing modes with constant offsets
;ldaa 4,x loads the contens tof the memory location with the address 
;equal to the sum of 4 and x.
        LDX #$80
        LDAA #$5
        STAA $84
        LDAA #$00
        LDAA 4,x
;this demonstrates indexed addressing modes with offset in an accumulator
;STAA B,X loads the contens of accumulator A in the address pointed by  
;sum of whatever is in accumulator B and whatever is in accumulator X 
        STAA B,X
;this next instruction stores the content of memory location in accumulator
;A + PC
            
        LDAB #$1
        LDX B,PC
        END
        
