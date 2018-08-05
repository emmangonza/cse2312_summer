@Emmanuel Gonzalez

.global main
.func main

main:
   MOV R0, #0
writeloop:
   CMP R0, #100
   BEQ writedone
   LDR R1, =a
   LSL R2, R0, #2
   ADD R2, R1, R2
   STR R2, [R2]
   ADD R0, R0, #1
   B   writeloop
writedone:
   MOV R0, #0
readloop:
   CMP R0, #100
   BEQ readdone
   LDR R1, =a
   LSL R2, R0, #2
   ADD R2, R1, R2
   LDR R1, [R2]
   PUSH {R0}
   PUSH {R1}
   PUSH {R2}
   MOV R2, R1
   MOV R1, R0
   BL  _printf
   POP {R2}
   POP {R1}
   POP {R0}
   ADD R0, R0, #1
   B   readloop
readdone:
   B _exit
    
_exit:  
   MOV R7, #1
   SWI 0
       
_printf:
   PUSH {LR}
   LDR R0, =printf_str
   BL printf
   POP {PC}
   
.data

.balign 4
a:              .skip       40
printf_str:     .asciz      "a[%d] = %d\n"
