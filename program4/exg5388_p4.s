@Emmanuel Gonzalez


.global main
.func main

main:
   BL _scanf				@checks for first input, n
   CMP R0, #0
   BEQ _exit				@exits program if n = 0
   MOV R1, R0

   PUSH {R1}				@backup n which will be altered in _scanf

   BL _scanf				@checks for second input, d
   CMP R0, #0
   BEQ _exit				@exits program if d = 0
   MOV R2, R0

   POP {R1}				@restore n

   VMOV S0, R1			@move the numerator to floating point register
   VMOV S1, R2			@move the denominator to floating point register

   BL _print_int

   VCVT.F32.S32 S0, S0	@convert signed bit representation to single float
   VCVT.F32.S32 S1, S1	@convert signed bit representation to single float

   VDIV.F32 S2, S0, S1		@compute S2 = S0 / S1

   VCVT.F64.F32 D4, S2	@covert the result to double precision for printing
   VMOV R1, R2, D4		@split the double VFP register into two ARM registers

   BL _print_float

   B main

_exit:
   MOV R7, #1
   SWI 0

_scanf:					@procedure for scanning integers from scanf.s
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_print_int:				@prints the integers in the format "n / d = "
   PUSH {LR}
   LDR R0, =result_str1
   BL printf
   POP {PC}

_print_float:				@prints the single floating point value using R1 and R2
   PUSH {LR}
   LDR R0, =result_str2
   BL printf
   POP {PC}


.data
format_str:     .asciz      "%d"
result_str1:     .asciz      "%d / %d = "
result_str2:     .asciz      "%f\n"

