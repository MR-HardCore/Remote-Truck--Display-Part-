.data 

.equ ADDR_VGA, 0x08000000
BACKGOROUND: .incbin "background.bin"
FORWARD: .incbin "forward.bin"
BACKWARD: .incbin "backward.bin"
TURNLEFT: .incbin "turnleft.bin"
TURNRIGHT: .incbin "turnright.bin"
RISE: .incbin "rise.bin"
FALL: .incbin "fall.bin"
IDLE: .incbin "idle.bin"
FINISHED: .incbin "finished.bin"

.text

.global _start

_start:
	
	call Load_background
	#call Load_idle
	#call Load_forward
	#call Load_backward
	#call Load_turnleft
	#call Load_turnright
	#call Load_rise
	#call Load_fall
	#call Load_finished

done: 
	br done

Load_background:
#load background
	movia r21, BACKGOROUND
	br draw_screen

Load_idle:
#load idle
	movia r21, IDLE
	br draw_screen

Load_forward:
#load forward
	movia r21, FORWARD
	br draw_screen

Load_backward:
#load backward
	movia r21, BACKWARD
	br draw_screen
	
Load_turnleft:
#load turnleft
	movia r21, TURNLEFT
	br draw_screen
	
Load_turnright:
#load turnright
	movia r21, TURNRIGHT
	br draw_screen

Load_rise:
#load rise
	movia r21, RISE
	br draw_screen
	
Load_fall:
#load fall
	movia r21, FALL
	br draw_screen
	
Load_finished:
#load finished
	movia r21, FINISHED
	br draw_screen

draw_screen:
#saving callee-saved registers 
	subi sp, sp, 32
	stw r16, 0(sp)
	stw r17, 4(sp)
	stw r18, 8(sp)
	stw r19, 12(sp)
	stw r20, 16(sp)
	stw r21, 20(sp)
	stw r22, 24(sp)
	stw r23, 28(sp)


#set up counters and parameter for loops
	mov r16, r0
	mov r17, r0
	movi r18, 320
	movi r19, 240
	movia r20, ADDR_VGA

	addi r21, r21, 16


#plot pixles
loop:
	
	ldhio r22, 0(r21)
	sthio r22, 0(r20)
	addi r21, r21, 2
	addi r20, r20, 2
	
	addi r17,r17, 1
	bgtu r18, r17, loop

	mov r17, r0
	addi r20, r20, 384

	addi r16, r16, 1
	bgtu r19, r16, loop

exit:
#saving callee-saved registers
	ldw r16, 0(sp)
	ldw r17, 4(sp)
	ldw r18, 8(sp)
	ldw r19, 12(sp)
	ldw r20, 16(sp)
	ldw r21, 20(sp)
	ldw r22, 24(sp)
	ldw r23, 28(sp)
	addi sp, sp, 32
	ret
	
	