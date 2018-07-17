@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf_num          @scans for first parameter
   MOV R1, R0

   PUSH {R1}              @backup for first parameter

   BL _scanf_char         @scans for operation
   MOV R3, R0

   PUSH {R3}              @backup for operation

   BL _scanf_num          @scans for second parameter
   MOV R2, R0

   POP {R3}               @restores operation value
   POP {R1}               @restores first parameter value

   CMP R3, #'+'
   BLEQ _sum

   CMP R3, #'-'
   BLEQ _diff

   CMP R3, #'*'
   BLEQ _mult

   CMP R3, #'m'
   BLEQ _min

   CMP R3, #'q'           @exits loop/program if 'q' is entered as the operation
   BLEQ _exit

   MOV R1, R0             @prints the result which would be the most recent value in R0
   BL _print

   BL _print_newline      @prints a new line after the result

   B main                 @loops back

_exit:
   MOV R7, #1
   SWI 0

_scanf_num:               @scan procedure for an int from scanf.s
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =num_format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_scanf_char:              @non-scanf procedure for a char from compare_char.s
   MOV R7, #3
   MOV R0, #0
   MOV R2, #1
   LDR R1, =read_char
   SWI 0
   LDR R0, [R1]
   AND R0, #0xFF
   MOV PC, LR

_print:                   @print procedure from printf.s
   MOV R4, LR
   LDR R0, =print_str
   MOV R1, R1
   BL printf
   MOV PC, R4

_print_newline:
   MOV R4, LR
   LDR R0, =newline
   BL printf
   MOV PC, R4

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
   MOVLT R0, R1
   MOVGT R0, R2
   MOV PC, LR

.data
num_format_str:    .asciz   "%d"
read_char:         .ascii   " "
print_str:         .asciz   "%d"
newline:           .ascii   "\n"
