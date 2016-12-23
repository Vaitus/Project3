################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
F95_SRCS += \
../main.f95 

OBJS += \
./main.o 


# Each subdirectory must supply rules for building sources it contributes
%.o: ../%.f95
	@echo 'Building file: $<'
	@echo 'Invoking: GNU Fortran Compiler'
	gfortran -funderscoring -O0 -g -Wall -c -fmessage-length=0 -o "$@" "$<"
	@echo 'Finished building: $<'
	@echo ' '

main.o: ../main.f95


