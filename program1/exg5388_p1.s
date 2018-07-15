@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf
   MOV R1, R0
   BL _scanf
   MOV R4, R0
   BL _scanf
   MOV R2, R0

   CMP R4, #'+'
   BEQ _sum

   CMP R4, #'-'
   BEQ _diff

   CMP R4, #'*'
   BEQ _mult


   CMP R4, #'m'
   BEQ _min

_exit:
   MOV R7, #1
   SWI 0

_scanf:
   PUSH {LR}
   SUB SP, SP, #4
   LDR RO, =format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP #4
   POP {PC}

_sum:
   MOV R0, R1
   ADD R0, R2
   MOV PC, LR

_diff:
   MOV R0, R1
   SUB R0, R2
   MOV PC, LR

_mult:
   MUL R0, R1, R2
   MOV PC, LR

_min:
   CMP R1, R2
   ...

.data
format_str:   .asciz   "%d"