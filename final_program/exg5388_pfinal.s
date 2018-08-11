@Emmanuel Gonzalez

.global main
.func main

main:
   MOV R0, #0

writeloop:					@modified writeloop procedure from array.s
   CMP R0, #10
   BEQ writedone

   LDR R1, =a
   LSL R2, R0, #2
   ADD R2, R1, R2

   PUSH {R0}
   PUSH {R1}
   PUSH {R2}

   BL _scanf

   POP {R2}
   STR R0, [R2]

   POP {R1}
   POP {R0}

   ADD R0, R0, #1
   B   writeloop

writedone:
   MOV R0, #0

readloop:					@array printing procedure from array.s
   CMP R0, #10
   BEQ _prompt

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

_prompt:					@prompts the user for the search value
   MOV R7, #4
   MOV R0, #1
   MOV R2, #22
   LDR R1, =prompt_str
   SWI 0

   BL _scanf
   MOV R4, #0				@new loop counter for searching
   MOV R5, #0				@counter for search value matches

_search:
   CMP R4, #10
   BEQ _match_check

   LDR R1, =a
   LSL R2, R4, #2
   ADD R2, R1, R2
   LDR R1, [R2]

   CMP R0, R1
   ADDNE R4, R4, #1
   BNE _search				@loop back if the current value doesn't match
							@continue to printing the value if it does match
   PUSH {R0}
   PUSH {R1}
   PUSH {R2}

   MOV R2, R1
   MOV R1, R4
   BL  _printf

   POP {R2}
   POP {R1}
   POP {R0}

   ADD R4, R4, #1				@update loop counter
   ADD R5, R5, #1				@update match counter
   B _search

_match_check:
   CMP R5, #0				@checks how many matches were made
   BNE _exit

   MOV R7, #4				@prints the message for no matches
   MOV R0, #1
   MOV R2, #40
   LDR R1, =no_match_str
   SWI 0
    
_exit:  
   MOV R7, #1
   SWI 0
       
_scanf:						@procedure for scanning integers from scanf.s
   PUSH {LR}
   SUB SP, SP, #4
   LDR R0, =format_str
   MOV R1, SP
   BL scanf
   LDR R0, [SP]
   ADD SP, SP, #4
   POP {PC}

_printf:						@printf procedure from printf.s
   PUSH {LR}
   LDR R0, =printf_str
   BL printf
   POP {PC}
   
.data

.balign 4
a:              		.skip       	40
format_str:     	.asciz      	"%d"
printf_str:     		.asciz      	"array_a[%d] = %d\n"
prompt_str:     	.asciz      	"ENTER A SEARCH VALUE: "
no_match_str:     	.asciz      	"That value does not exist in the array!\n"

