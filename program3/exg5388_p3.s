@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf				@checks for first input
   CMP R0, #0
   BEQ _exit
   MOV R4, R0
   MOV R1, R0				@R1 = n

   BL _scanf				@checks for second input
   CMP R0, #0
   BEQ _exit
   MOV R4, R0
   MOV R2, R0				@R2 = m

   BL _cnt_part

   B main

_exit:
   MOV R7, #1
   SWI 0

_cnt_part:
   PUSH {LR}

   CMP R1, #0

   MOVEQ R0, #1				@condition 1 (n == 0)
   POPEQ {PC}

   MOVLT R0, #0				@condition 2 (n < 0)
   POPLT {PC}

   CMP R2, #0
   MOVEQ R0, #0
   POPEQ {PC}



    
_scanf:
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_printf:
   MOV R4, LR
   LDR R0, =printf_str
   MOV R1, R1
   BL printf
   MOV PC, R4

.data
format_str:     .asciz      "%d"
printf_str:     .asciz      "There are %d partitions of %d using integers up to %d\n"
