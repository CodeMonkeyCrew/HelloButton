; INTCPS_SIR_IRQ register address
INTCPS_SIR_IRQ_ADDR .word 0x48200040
; ACTIVEIRQ bit field mask to get only the bit field
ACTIVEIRQ_MASK .equ 0x7F

_IRQ_ISR:
	; Save the critical context
   	STMFD SP!, {R0-R12, LR}			; Save working registers and the Link register
    MRS R11, SPSR                   ; Save the SPSR into R11

	; Get the number of the highest priority active IRQ
	LDR R10, INTCPS_SIR_IRQ_ADDR
	LDR R10, [R10]					; Get the INTCPS_SIR_IRQ register
	AND R10, R10, #0				; Apply the mask to get the active IRQ number

	MOV R9, #0xABCD

    ; Jump to relevant subroutine handler
	LDR PC, [PC, R10, lsl #2]       ; PC base address points this instruction + 8
	NOP                         	; To index the table by the PC

	; Table of handler start addresses
	.word IRQ0handler

; IRQ0 subroutine
IRQ0handler:
	; Save working registers
	; STMFD SP!, {R0-R1}

	; Now read-modify-write the peripheral module status register
	; to de-assert the M_IRQ_0 interrupt signal
	; De-Assert the peripheral interrupt
	; MOV R0, #0x7                    ; Mask for 3 flags
	; LDR R1, MODULE0_STATUS_REG_ADDR ; Get the address of the module Status Register
	; STR R0, [R1]                    ; Clear the 3 flags

	; Restore working registers
	; LDMFD SP!, {R0-R1}
	; Jump to the end part of the ISR
	; B IRQ_ISR_end/FIQ_ISR_end
