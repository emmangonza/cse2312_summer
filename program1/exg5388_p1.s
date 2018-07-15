@Emmanuel Gonzalez

.global main
.func main

main:
   BL _scanf
   MOV R1, R0
   BL _

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
   


.data
format_str:   .asciz   "%d"