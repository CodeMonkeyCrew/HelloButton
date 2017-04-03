	    ; .if __TI_EABI_ASSEMBLER
	    ; .asg c_intIRQ, C_INTIRQ
	    ; .else
	    ; .asg _c_intIRQ, C_INTIRQ
	    ; .endif

	.global _c_int00
	.global _IRQ_ISR

	.sect ".intvecs"

	B _c_int00 ; reset
	.word 0 ; undefined
	.word 0 ; SWI
	.word 0 ; prefetch abort
	.word 0 ; data abort
	.word 0 ; unused
	B _IRQ_ISR ; IRQ
	.word 0 ; FIQ
