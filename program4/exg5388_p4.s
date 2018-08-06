@Emmanuel Gonzalez


.global main
.func main

main:
   BL _scanf				@checks for first input, n
   CMP R0, #0
   BEQ _exit

   PUSH {R0}				@backup n for _divide call

   BL _scanf				@checks for second input, d
   CMP R0, #0
   BEQ _exit
   MOV R1, R0

   POP {R0}

   BL _divide

   B main

_exit:
   MOV R7, #1
   SWI 0

_scanf:
    PUSH {LR}                @ store LR since scanf call overwrites
    SUB SP, SP, #4          @ make room on stack
    LDR R0, =format_str     @ R0 contains address of format string
    MOV R1, SP              @ move SP to R1 to store entry on stack
    BL scanf                @ call scanf
    LDR R0, [SP]            @ load value at SP into R0
    ADD SP, SP, #4          @ restore the stack pointer
    POP {PC}                 @ return

_divide:
   PUSH {LR}

   VMOV S0, R0
   VMOV S1, R1

   @BL _print_int

   VCVT.F32.U32 S0, S0
   VCVT.F32.U32 S1, S1

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
format_str:     .asciz      "%d"
result_str1:     .asciz      "%d / %d = "
result_str2:     .asciz      "%f\n"

