@Emmanuel Gonzalez

.global main
.func main

main:
   BL _seedrand
   MOV R0, #0              @initial loop counter

_occupyarray:
   CMP R0, #10
   BEQ _occupydone

   LDR R1, =a
   LSL R2, R0, #2
   ADD R2, R2, R1

   PUSH {R0}
   PUSH {R1}
   PUSH {R2}

   BL _getrand
   MOV R1, R0              @random number to be modded
   LDR R2, =0x3e7          @equivalent to the value 999
   BL _mod_unsigned        @computes random numer mod 999
   MOV R3, R0

   POP {R2}
   POP {R1}
   POP {R0}

   STR R3, [R2]            @stores random number in array
   ADD R0, R0, #1

   B _occupyarray

_occupydone:
   MOV R0, #0              @reset loop counter

_printloop:                @readloop procedure from array.s
   CMP R0, #10
   BEQ _printdone
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
   B _printloop

_printdone:
   MOV R0, #0              @reset loop counter
   MOV R3, #1000           @setup for find min (initial min)

_findmin:
   CMP R0, #10             @loop counter (i)
   BEQ _mindone
   LDR R1, =a              @address of array
   LSL R2, R0, #2
   ADD R2, R1, R2
   LDR R1, [R2]            @value at a[i]
   CMP R1, R3              @R3 keeps track of the minimum value
   MOVLT R3, R1            @update R3 if current value if smaller
   ADD R0, R0, #1
   B _findmin

_mindone:
   MOV R1, R3              @move min value into R1 for printing
   BL _printmin
   MOV R0, #0              @reset loop counter
   MOV R3, #0              @setup for find max (initial max)

_findmax:
   CMP R0, #10             @loop counter (i)
   BEQ _maxdone
   LDR R1, =a              @address of array
   LSL R2, R0, #2
   ADD R2, R1, R2
   LDR R1, [R2]            @value at a[i]
   CMP R1, R3              @R3 keeps track of the maximum value
   MOVGT R3, R1            @update R3 if current value if larger
   ADD R0, R0, #1
   B _findmax

_maxdone:
   MOV R1, R3              @move max value into R1 for printing
   BL _printmax
   B _exit

_exit:
   MOV R7, #1
   SWI 0

_seedrand:                 @seedrand procedure from rand.s
   PUSH {LR}
   MOV R0, #0
   BL time
   MOV R1, R0
   BL srand
   POP {PC}

_getrand:                  @getrand procedure from rand.s
   PUSH {LR}
   BL rand
   POP {PC}

_mod_unsigned:             @mod procedure from mod.s
   cmp R2, R1
   MOVHS R0, R1
   MOVHS R1, R2
   MOVHS R2, R0
   MOV R0, #0
   B _modloopcheck
   _modloop:
      ADD R0, R0, #1
      SUB R1, R1, R2
   _modloopcheck:
      CMP R1, R2
      BHS _modloop
   MOV R0, R1
   MOV PC, LR
 

_printf:                   @printf subroutine from printf.s
   PUSH {LR}
   LDR R0, =printf_str
   BL printf
   POP {PC}

_printmin:
   PUSH {LR}
   LDR R0, =min_str
   BL printf
   POP {PC}

_printmax:
   PUSH {LR}
   LDR R0, =max_str
   BL printf
   POP {PC}

.data

.balign 4
a:               .skip      40
printf_str:      .asciz     "a[%d] = %d\n"
min_str:         .asciz     "MINIMUM VALUE = %d\n"
max_str:         .asciz     "MAXIMUM VALUE = %d\n"
