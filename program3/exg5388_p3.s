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
   MOV R5, R0
   MOV R2, R0				@R2 = m

   BL _cnt_part

   MOV R1, R0				@setup printf parameters
   MOV R2, R4
   MOV R3, R5

   BL _printf

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

   CMP R2, #0				@condition 3 (m == 0)
   MOVEQ R0, #0
   POPEQ {PC}

   PUSH {R1}				@save n and m for later
   PUSH {R2}
   
   SUB R1, R1, R2			@n = n - m
   BL _cnt_part
   MOV R6, R0				@save result

   POP {R2}					@restore n and m
   POP {R1}

   SUB R2, R2 ,#1			@m = m - 1
   BL _cnt_part
   MOV R7, R0				@save result

   ADD R0, R6, R7			@add results together
   POP {PC}


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
   MOV R2, R2
   MOV R3, R3
   BL printf
   MOV PC, R4

.data
format_str:     .asciz      "%d"
printf_str:     .asciz      "There are %d partitions of %d using integers up to %d\n"
