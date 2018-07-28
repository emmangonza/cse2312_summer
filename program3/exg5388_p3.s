@Emmanuel Gonzalez

.global main
.func main

main:
   MOV R0, #5

_exit:
   MOV R7, #1
   SWI 0