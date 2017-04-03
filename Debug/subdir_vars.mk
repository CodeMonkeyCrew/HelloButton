################################################################################
# Automatically-generated file. Do not edit!
################################################################################

SHELL = cmd.exe

# Add inputs and outputs from these tool invocations to the build variables 
CMD_SRCS += \
../OMAP3530.cmd 

ASM_SRCS += \
../boot.asm \
../intvecs.asm \
../irq_isr.asm 

C_SRCS += \
../main.c 

C_DEPS += \
./main.d 

OBJS += \
./boot.obj \
./intvecs.obj \
./irq_isr.obj \
./main.obj 

ASM_DEPS += \
./boot.d \
./intvecs.d \
./irq_isr.d 

OBJS__QUOTED += \
"boot.obj" \
"intvecs.obj" \
"irq_isr.obj" \
"main.obj" 

C_DEPS__QUOTED += \
"main.d" 

ASM_DEPS__QUOTED += \
"boot.d" \
"intvecs.d" \
"irq_isr.d" 

ASM_SRCS__QUOTED += \
"../boot.asm" \
"../intvecs.asm" \
"../irq_isr.asm" 

C_SRCS__QUOTED += \
"../main.c" 


