@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf				@checks for first input
   CMP R0, #0
   BEQ _exit
   MOV R4, R0
   MOV R1, R0

   BL _scanf				@checks for second input
   CMP R0, #0
   BEQ _exit
   MOV R4, R0
   MOV R2, R0

   B main

_exit:
   MOV R7, #1
   SWI 0
    
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
printf_str:     .asciz      "The number entered was: %d\n"
