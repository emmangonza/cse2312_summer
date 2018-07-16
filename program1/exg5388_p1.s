@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf_num
   MOV R1, R0
   BL _scanf_char
   MOV R4, R0
   BL _scanf_num
   MOV R2, R0


   CMP R4, #'+'
   BLEQ _sum

   CMP R4, #'-'
   BLEQ _diff

   CMP R4, #'*'
   BLEQ _mult

@   CMP R4, #'m'
@   BLEQ _min

   CMP R4, #'q'
   BLEQ _exit


   MOV R1, R0
   BL _print

   B main

_exit:
   MOV R7, #1
   SWI 0

_scanf_num:
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =num_format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_scanf_char:
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =char_format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_print:
   MOV R5, LR
   LDR R0, =print_str
   MOV R1, R1
   BL printf
   MOV PC, R5

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

@_min:
@   CMP R1, R2
@   MOVLT R0, R1
@   MOVGT R0, R2
@   MOV PC, LR

.data
num_format_str:    .asciz   "%d"
char_format_str:   .asciz   "%c"
print_str:         .asciz   "%d"
