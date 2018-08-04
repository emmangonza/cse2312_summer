@Emmanuel Gonzalez


.global main
.func main

main:
   BL _scanf				@checks for first input, n
   CMP R0, #0
   BEQ _exit
   MOV R1, R0

   PUSH {R1}				@backup n for _divide call

   BL _scanf				@checks for second input, d
   CMP R0, #0
   BEQ _exit
   MOV R2, R0

   POP {R1}

   BL _divide

   B main

_exit:
   MOV R7, #1
   SWI 0

_divide:
   VMOV S0, R1
   VMOV S1, R2

   BL _print_int

   VCVT.F32.S32 S0, S0
   VCVT.F32.S32 S1, S1

   VDIV.F32 S2, S0, S1

   VCVT.F64.F32 D4, S2
   VMOV R1, R2, D4

   BL _print_float

   POP {PC}

_print_int:
   PUSH {LR}
   LDR R0, =result_str1
   BL printf
   POP {PC}

_print_float:
   PUSH {LR}
   LDR R0, =result_str2
   BL printf
   POP {PC}


.data
result_str1:     .asciz      "%d / %d = "
result_str2:     .asciz      "%f\n"
