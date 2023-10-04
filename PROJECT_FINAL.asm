################ CSC258H1F Fall 2022 Assembly Final Project ##################
# This file contains our implementation of Breakout.
#
# Student 1: Humza Iqbal, 1008169321
# Student 2: Karanveer, 1008577161
######################## Bitmap Display Configuration ########################
# - Unit width in pixels:       8
# - Unit height in pixels:      8
# - Display width in pixels:    512
# - Display height in pixels:   256
# - Base Address for Display:   0x10008000 ($gp)
##############################################################################

    .data
##############################################################################
# Immutable Data
##############################################################################
# The address of the bitmap display. Don't forget to connect it!
ADDR_DSPL:
    .word 0x10008000
# The address of the keyboard. Don't forget to connect it!
ADDR_KBRD:
    .word 0xffff0000
BALL_START:
    .word 0x00000000
PADDLE_START:
    .word 7796
    
str2: 
    .word 10101010
    
str1: 
    .word 11111111
    
lmaroon:
    .word 0x0000ff
maroon:
    .word 0x800000
    
lred:
    .word 0x0066cc
red:
    .word 0xff0000
    
lyellow:
    .word 0xccffff
yellow:
    .word 0xffff00
    
lorange:
    .word 0x00ffff
orange:
    .word 0xffa500
    
brick1: 
	.word 1856

brick2:
	.word 2208
    
brick3:
	.word 2432
	
##############################################################################
# Mutable Data
##############################################################################

#Ball varible
ball: 
	.word 6784 #starting pos of ball


#Paddle varible
paddle: 
	.word 0

paddle1:
	.word 0
	

#The struct for the direction [verticle, horizontal], verticle takes 1 for up, 0 for down. Horizontal takes 1 for right and 0 for left. 
direction:
	.byte 0 # 0 = up, right; 1= up, left; 2 = down, right, 3 = down, left; 
	
	#.byte 0 #1 up, 0, down 
	#.byte 0 #1 right, 0 left 


##############################################################################
# Code
##############################################################################
	.text
	.globl main

	# Run the Brick Breaker game.
main:
# Initialize the game

    la $t1, ball
	li $t2, 4224
	sw $t2, 0($t1)
	
	la $t1, direction
	li $t2, 0
	sw $t2, 0($t1)
	
    # DRAW Everything
    lw $t1, red        # $t1 = red
    lw $t2, orange        # $t2 = orange
   	lw $t3, yellow        # $t3 = yellow
   	lw $t6, maroon        # $t6 = maroon

    lw $t0, ADDR_DSPL       # $t0 = base address for display
    
    addi $t8, $zero, 101102
    bne $v0, $t8, LEVELONE
    
    addi $t6, $zero, 0x0000000
    
            addi $a0, $zero, 1792   # Make blk row
    		addi $a1, $zero, 2048
    		add $a2, $zero, $t6
    		jal colour_row
    		
    		addi $a0, $zero, 2048   # Make blk row
    		addi $a1, $zero, 2304
    		add $a2, $zero, $t6
    		jal colour_row
    		
    		addi $a0, $zero, 2304   # Make blk row
    		addi $a1, $zero, 2560
   		    add $a2, $zero, $t6
   		    jal colour_row
    
    		addi $a0, $zero, 2560   # Make blk row
    		addi $a1, $zero, 2816
    		add $a2, $zero, $t6
    		jal colour_row
    
            addi $a0, $zero, 1792   # Make maroon row
    		addi $a1, $zero, 2048 
    		add $a2, $zero, $t6  
    		jal colour_row2
    
    	# Red Row
    		addi $a0, $zero, 2048   # Make red row
    		addi $a1, $zero, 2304
    		add $a2, $zero, $t1
    		jal colour_row2
    	
    	#Orange Row
    
    		addi $a0, $zero, 2304   # Make orange row
    		addi $a1, $zero, 2560
    		add $a2, $zero, $t2
   		jal colour_row2
   		 
   	#Yellow Row
    
   		addi $a0, $zero, 2560   # Make yellow row
    		addi $a1, $zero, 2816
    		add $a2, $zero, $t3
    		jal colour_row2
    		
    		
    
    j LEVEL2
    
	LEVELONE:
    	
    	# Maroon Row
    
    		addi $a0, $zero, 1792   # Make maroon row
    		addi $a1, $zero, 2048 
    		add $a2, $zero, $t6  
    		jal colour_row
    
    	# Red Row
    		addi $a0, $zero, 2048   # Make red row
    		addi $a1, $zero, 2304
    		add $a2, $zero, $t1
    		jal colour_row
    	
    	#Orange Row
    
    		addi $a0, $zero, 2304   # Make orange row
    		addi $a1, $zero, 2560
    		add $a2, $zero, $t2
   		jal colour_row
   		 
   	#Yellow Row
    
   		addi $a0, $zero, 2560   # Make yellow row
    		addi $a1, $zero, 2816
    		add $a2, $zero, $t3
    		jal colour_row
    		
    		li $a2, 0xbfbfbf #lime 
		la $t3, brick1
		lw $t9, 0($t3)
		jal colour_brick
		
		li $a2, 0xbfbfbf #lime 
		la $t3, brick2
		lw $t9, 0($t3)
		jal colour_brick
		
		li $a2, 0xbfbfbf #lime 
		la $t3, brick3
		lw $t9, 0($t3)
		jal colour_brick
    		
    		
    		    LEVEL2:
    		
    	#Creating Grey Borders 
    	
    		#Cols.
    
    		li $t6, 0xbfbfbf        # $t6 = gray   
    		addi $a0, $zero, 0   # Make 4 gray columns left
    		addi $a1, $zero, 8192
    		add $a2, $zero, $t6
    		jal colour_column
    		addi $a0, $zero, 240   # Make 4 gray columns right
    		addi $a1, $zero, 8192
    		add $a2, $zero, $t6
   		jal colour_column
    		
    		#Rows.
    		
    		addi $a0, $zero, 0   # Make gray row
    		addi $a1, $zero, 256
    		add $a2, $zero, $t6
    		jal colour_row
    		
    		addi $a0, $zero, 256   # Make gray row
    		addi $a1, $zero, 512
    		add $a2, $zero, $t6
    		jal colour_row
    		
    		#FOR DEMO!!
    		addi $a0, $zero, 4864   # Make gray row
    		addi $a1, $zero, 5120
    		add $a2, $zero, $t6
    		jal colour_row
    		
    		addi $a0, $zero, 512   # Make gray row
    		addi $a1, $zero, 768
   		    add $a2, $zero, $t6
   		    jal colour_row
    
    		addi $a0, $zero, 768   # Make gray row
    		addi $a1, $zero, 1024
    		add $a2, $zero, $t6
    		jal colour_row
  
    #Drawing and initialising Movable objectes (Paddle and Ball)  
    
    # Initialising  Paddle
    
    	la $s1, paddle #this should start with zero
    	la $s0, PADDLE_START
    	lw $t3, 0($s0)

    	add $t6, $zero, $t3 #load paddle start pos into t6
    
    	#lw $s0, PADDEL_START
    	#addi $t3, $zero, $s0 # load the paddle start into t3
    
    	sw $t6, 0($s1) # store the start loaction of the paddle into the " paddle" struct.

		
		
		addi $t6, $t6, -256
		la $s1, paddle1
		sw $t6, 0($s1)

 
    
    
    #drawing the paddle
   
    	#lw $s0, PADDLE_START 
    	add $a0, $zero, $s0   # Make padle start i at 120, so a0 = s0 = paddle start = 120
    	li $t6, 0xbfbfbf      # $t6 = gray  
    	add $a2, $zero, $t6   # a2 = t6 = purple color 
    	#addi $t9, $a0, 7676      
   		#addi $t9, $zero, 7796 
    	la $t3 paddle
    	lw $t9, 0($t3) # start drawing paddle at (i) starts from this unit 
    	
    	#lw $t9 PADDLE_START
    	#add $a0, $zero, $t9
    	#li $v0, 1
    	#syscall  
    	
    	jal colour_paddel


		addi $a0, $s0, -256
		li $a2, 0xbfbfbf #lime 
		la $t3, paddle1
		lw $t9, 0($t3)

		jal colour_paddel
		

		
		
		
		
    
    
    #storing the ball contents in struct
    #lw $s1, ball
    #add $t6, $zero, $s1 #load paddle start pos into t6
    
    #lw $s0, PADDEL_START
    #addi $t3, $zero, 6784 # load the ball start into t3
    
    #sw $t3, 0($t6) # store the start loaction of the ball into the " ball" struct. 
 
    
    # drawing ball 
    #lw $t0, ADDR_DSPL       # $t0 = base address for display
    
    #addi $a2, $zero, 0xFFFFFF # white color for the ball 
    #addi $t5, $t0, 6784 # ball lol
    #sw $a2, 0($t5) #drawing the ball on bitmap

   
game_loop:		
	#TASK 1
		# 1a. Check if key has been pressed
			lw $t1, ADDR_KBRD               # $t1 = base address for keyboard
			lw $t8, ($t1)                  # Load first word from keyboard
			bne $t8, 1, keyboard_no_input   # If first word 1, key is pressed
			
		# 1b. Check which key has been pressed
			lw $a0, 4($t1)                  # Load second word from keyboard
			li $v0, 1                       # FOR TESTING: ask system to print $a0
			syscall
			
						
		#1c. Check if q, a or d was pressed: 
	
    			beq $a0, 0x71, respond_to_Q     # Check if the key q was pressed
    	
  				beq $a0, 0x61, respond_to_A     # Check if the key a was pressed
  	
    			beq $a0, 0x64, respond_to_D     # Check if the key d was pressed
    			
    			beq $a0, 0x6A, respond_to_J		# Check if the key j was pressed
    			
    			beq $a0, 0x6C, respond_to_L		# Check if the key l was pressed
    			
    			beq $a0, 0x32, respond_to_U		# Check if the key l was pressed
    			
    			beq $a0, 0x70, respond_to_P      # Check if key "p" was pressed
    			
    			
    			
    			
    			
    	
   	#TASK 2
		# 2a. Check for collisions
	
		# 2b. Update locations (paddle, ball)
		
	#TASK 3
		# 3. Draw the screen
		
		
		#Sleep
		
	#b game_loop
	keyboard_no_input: 
			li $v0, 32
			li $a0, 5
			syscall
			j move_ball
		
		#j move_ball
		
		
		
		j game_loop
	#5. Go back to 1'
	
	
	
b game_loop

#HELPERS#

move_ball:
    add $v1, $zero, $ra
	la $t1,direction
	lb $t2 0($t1)
	
	lw $a0, 0($t1)
	li $v0, 1
	syscall
	
	la $s0, ball
	lw $s1, 0($s0)
	
	addi $a0, $zero, 7936
	bge $s1, $a0, respond_to_Q
	
	bnez $t2 ball1 # if direction != 0, go to ball1
		#Ball is going up and right
		
		lw $t0, ADDR_DSPL  # $t0 = base address for display
		
		add $t6, $t0, $s1   # Load possible blocks ball may collide with :)
		addi $t7, $t6, -256 # Location above ball A
		addi $t8, $t6, -252 # Location above and right of ball C
		addi $t6, $t6, 4  # Location to right of ball B

    		li $s5, 0x000000
    		li $s6, 0xbfbfbf
    		lw $t9, 0($t6)
    		bne $t9, $s5, BNotBLACK1  #Check colour of B
    			lw $t9, 0($t7)
    			bne $t9, $s5, ANotBlack1
    				lw $t9, 0($t8)
    				bne $t9, $s5, CNotBlack1
    					j MOVE1
    				CNotBlack1:
    				    lw $t9, 0($t8)
        				beq $t9, $s6, graySkip111
        				addi $v0, $zero, 0x000000
        				lw $a1, yellow
        			    bne $t9, $a1, JUMPP111
        			    lw $v0, lyellow
        			    j JUMPP411
        			    JUMPP111:
        			    lw $a1, orange
        			    bne $t9, $a1, JUMPP211
        			    lw $v0, lorange
        			    j JUMPP411
        			    JUMPP211:
        			    lw $a1, red
        			    bne $t9, $a1, JUMPP311
        			    lw $v0, lred
        			    j JUMPP411
        			    JUMPP311:
        			    lw $a1, maroon
        			    bne $t9, $a1, JUMPP411
        			    lw $v0, lmaroon
        			    j JUMPP411
        			    JUMPP411:
    				    add $a3, $t8, $zero
                        addi $s4, $zero, 16
                        div $s4, $a3, $s4
                        mfhi $s3
                        sub $a3, $a3, $s3

                        addi $s3, $a3, 16   # Last unit to colour 
                    	LOOPe11:
                    		Bge $a3, $s3, ENDe11  # branch is i >= $t4
                    		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                    		add $s2, $zero, $v0
                    		sw $s2, 0($a3)     # Colour $t5 purple
                    		addi $a3, $a3, 4    # increment i by 4
                    		j LOOPe11
                    	ENDe11:
                    	graySkip111:
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    			ANotBlack1:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip121
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP121
    			    lw $v0, lyellow
    			    j JUMPP421
    			    JUMPP121: 
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP221
    			    lw $v0, lorange
    			    j JUMPP421
    			    JUMPP221:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP321
    			    lw $v0, lred
    			    j JUMPP421
    			    JUMPP321:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP421
    			    lw $v0, lmaroon
    			    j JUMPP421
    			    JUMPP421:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe21:
                		Bge $a3, $s3, ENDe21  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe21
                	ENDe21:
                	graySkip121:
    				lw $t9, 0($t8)
    				bne $t9, $s5, ACNotBlack1 # Probs remove this
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    				ACNotBlack1: # Probs remove this
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    		BNotBLACK1:
    		    lw $t9, 0($t6)
				beq $t9, $s6, graySkip131
				addi $v0, $zero, 0x000000
				lw $a1, yellow
			    bne $t9, $a1, JUMPP131
			    lw $v0, lyellow
			    j JUMPP431
			    JUMPP131:
			    lw $a1, orange
			    bne $t9, $a1, JUMPP231
			    lw $v0, lorange
			    j JUMPP431
			    JUMPP231:
			    lw $a1, red
			    bne $t9, $a1, JUMPP331
			    lw $v0, lred
			    j JUMPP431
			    JUMPP331:
			    lw $a1, maroon
			    bne $t9, $a1, JUMPP431
			    lw $v0, lmaroon
			    j JUMPP431
			    JUMPP431:
    		    add $a3, $t6, $zero
                addi $s4, $zero, 16
                div $s4, $a3, $s4
                mfhi $s3
                sub $a3, $a3, $s3

                addi $s3, $a3, 16   # Last unit to colour 
            	LOOPe31:
            		Bge $a3, $s3, ENDe31  # branch is i >= $t4
            		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
            		add $s2, $zero, $v0
            		sw $s2, 0($a3)     # Colour $t5 purple
            		addi $a3, $a3, 4    # increment i by 4
            		j LOOPe31
            	ENDe31:
            	graySkip131:
    			lw $t9, 0($t7)
    			bne $t9, $s5, BANotBlack1
    				lw $t9, 0($t8)
    				bne $t9, $s5, BCNotBlack1
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    				BCNotBlack1:
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    			BANotBlack1:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip141
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP141
    			    lw $v0, lyellow
    			    j JUMPP441
    			    JUMPP141:
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP241
    			    lw $v0, lorange
    			    j JUMPP441
    			    JUMPP241:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP341
    			    lw $v0, lred
    			    j JUMPP441
    			    JUMPP341:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP441
    			    lw $v0, lmaroon
    			    j JUMPP441
    			    JUMPP441:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe41:
                		Bge $a3, $s3, ENDe41  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe41
                	ENDe41:
                	graySkip141:
    				lw $t9, 0($t8)
    				bne $t9, $s5, BACNotBlack1
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    				BACNotBlack1:
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    		MOVE1:
    		
   		addi $a2,$zero, 0x000000 # paint previous area black 
    		add $t5,$t0, $s1 # prev ball location
    		sw $a2,0($t5) #covering the ball on bitmap
    		
		addi $s1, $s1,-252 #updating the ball location
		sw $s1,0($s0) # storing new location in ball varible

   		addi $a2, $zero, 0xFFFFFF # white color for the ball 
    		add $t5, $t0, $s1 # ball lol
    		sw $a2, 0($t5) #drawing the ball on bitmap
		
		j ballEnd
	ball1: 
		li $t3, 1
		bne $t2, $t3 ball2 # if direction != 1, go to ball2
		
		lw $t0, ADDR_DSPL       # $t0 = base address for display
			
		add $t6, $t0, $s1   # Load possible blocks ball may collide with :)
		addi $t7, $t6, -256 # Location above ball A
		addi $t8, $t6, -260 # Location above and left of ball C
		addi $t6, $t6, -4  # Location to left of ball B

    		li $s5, 0x000000
    		lw $t9, 0($t6)
    		bne $t9, $s5, BNotBLACK2  #Check colour of B
    			lw $t9, 0($t7)
    			bne $t9, $s5, ANotBlack2
    				lw $t9, 0($t8)
    				bne $t9, $s5, CNotBlack2
    					j MOVE2
    				CNotBlack2:
    				    lw $t9, 0($t8)
        				beq $t9, $s6, graySkip112
        				addi $v0, $zero, 0x000000
        				lw $a1, yellow
        			    bne $t9, $a1, JUMPP112
        			    lw $v0, lyellow
        			    j JUMPP412
        			    JUMPP112:
        			    lw $a1, orange
        			    bne $t9, $a1, JUMPP212
        			    lw $v0, lorange
        			    j JUMPP412
        			    JUMPP212:
        			    lw $a1, red
        			    bne $t9, $a1, JUMPP312
        			    lw $v0, lred
        			    j JUMPP412
        			    JUMPP312:
        			    lw $a1, maroon
        			    bne $t9, $a1, JUMPP412
        			    lw $v0, lmaroon
        			    j JUMPP412
        			    JUMPP412:
    				    add $a3, $t8, $zero
                        addi $s4, $zero, 16
                        div $s4, $a3, $s4
                        mfhi $s3
                        sub $a3, $a3, $s3

                        addi $s3, $a3, 16   # Last unit to colour 
                    	LOOPe12:
                    		Bge $a3, $s3, ENDe12  # branch is i >= $t4
                    		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                    		add $s2, $zero, $v0
                    		sw $s2, 0($a3)     # Colour $t5 purple
                    		addi $a3, $a3, 4    # increment i by 4
                    		j LOOPe12
                    	ENDe12:
                    	graySkip112:
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    			ANotBlack2:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip122
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP122
    			    lw $v0, lyellow
    			    j JUMPP422
    			    JUMPP122: 
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP222
    			    lw $v0, lorange
    			    j JUMPP422
    			    JUMPP222:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP322
    			    lw $v0, lred
    			    j JUMPP422
    			    JUMPP322:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP422
    			    lw $v0, lmaroon
    			    j JUMPP422
    			    JUMPP422:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe22:
                		Bge $a3, $s3, ENDe22  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe22
                	ENDe22:
                	graySkip122:
    				lw $t9, 0($t8)
    				bne $t9, $s5, ACNotBlack2 # Probs remove this
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    				ACNotBlack2: # Probs remove this
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    		BNotBLACK2:
    		    lw $t9, 0($t6)
				beq $t9, $s6, graySkip132
				addi $v0, $zero, 0x000000
				lw $a1, yellow
			    bne $t9, $a1, JUMPP132
			    lw $v0, lyellow
			    j JUMPP432
			    JUMPP132:
			    lw $a1, orange
			    bne $t9, $a1, JUMPP232
			    lw $v0, lorange
			    j JUMPP432
			    JUMPP232:
			    lw $a1, red
			    bne $t9, $a1, JUMPP332
			    lw $v0, lred
			    j JUMPP432
			    JUMPP332:
			    lw $a1, maroon
			    bne $t9, $a1, JUMPP432
			    lw $v0, lmaroon
			    j JUMPP432
			    JUMPP432:
    		    add $a3, $t6, $zero
                addi $s4, $zero, 16
                div $s4, $a3, $s4
                mfhi $s3
                sub $a3, $a3, $s3

                addi $s3, $a3, 16   # Last unit to colour 
            	LOOPe32:
            		Bge $a3, $s3, ENDe32  # branch is i >= $t4
            		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
            		add $s2, $zero, $v0
            		sw $s2, 0($a3)     # Colour $t5 purple
            		addi $a3, $a3, 4    # increment i by 4
            		j LOOPe32
            	ENDe32:
            	graySkip132:
    			lw $t9, 0($t7)
    			bne $t9, $s5, BANotBlack2
    				lw $t9, 0($t8)
    				bne $t9, $s5, BCNotBlack2
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    				BCNotBlack2:
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    			BANotBlack2:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip142
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP142
    			    lw $v0, lyellow
    			    j JUMPP442
    			    JUMPP142:
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP242
    			    lw $v0, lorange
    			    j JUMPP442
    			    JUMPP242:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP342
    			    lw $v0, lred
    			    j JUMPP442
    			    JUMPP342:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP442
    			    lw $v0, lmaroon
    			    j JUMPP442
    			    JUMPP442:
    			
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe42:
                		Bge $a3, $s3, ENDe42  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe42
                	ENDe42:
                	graySkip142:
    				lw $t9, 0($t8)
    				bne $t9, $s5, BACNotBlack2
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    				BACNotBlack2:
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    		MOVE2:
    
   			addi $a2,$zero, 0x000000 # paint previous area black 
    			add $t5, $t0, $s1 # prev ball location
    			sw $a2, 0($t5) #covering the ball on bitmap
		
		
			addi $s1,$s1,-260 #updaing the ball location
			sw $s1,0($s0) # storing new location in ball varible
		
		    
   			addi $a2,$zero,0xFFFFFF # white color for the ball 
    			add $t5, $t0, $s1 # ball lol
    			sw $a2, 0($t5) #drawing the ball on bitmap
	
			j ballEnd
	ball2:
		li $t3, 2
		bne $t2, $t3 ball3 #if direction != 2, go to ball3
		
			lw $t0, ADDR_DSPL       # $t0 = base address for display
			
		add $t6, $t0, $s1   # Load possible blocks ball may collide with :)
		addi $t7, $t6, 256 # Location above ball A
		addi $t8, $t6, 260 # Location above and left of ball C
		addi $t6, $t6, 4  # Location to left of ball B

    		li $s5, 0x000000
    		lw $t9, 0($t6)
    		bne $t9, $s5, BNotBLACK3  #Check colour of B
    			lw $t9, 0($t7)
    			bne $t9, $s5, ANotBlack3
    				lw $t9, 0($t8)
    				bne $t9, $s5, CNotBlack3
    					j MOVE3
    				CNotBlack3:
    				    lw $t9, 0($t8)
        				beq $t9, $s6, graySkip113
        				addi $v0, $zero, 0x000000
        				lw $a1, yellow
        			    bne $t9, $a1, JUMPP113
        			    lw $v0, lyellow
        			    j JUMPP413
        			    JUMPP113:
        			    lw $a1, orange
        			    bne $t9, $a1, JUMPP213
        			    lw $v0, lorange
        			    j JUMPP413
        			    JUMPP213:
        			    lw $a1, red
        			    bne $t9, $a1, JUMPP313
        			    lw $v0, lred
        			    j JUMPP413
        			    JUMPP313:
        			    lw $a1, maroon
        			    bne $t9, $a1, JUMPP413
        			    lw $v0, lmaroon
        			    j JUMPP413
        			    JUMPP413:
    				    
    				    add $a3, $t8, $zero
                        addi $s4, $zero, 16
                        div $s4, $a3, $s4
                        mfhi $s3
                        sub $a3, $a3, $s3

                        addi $s3, $a3, 16   # Last unit to colour 
                    	LOOPe13:
                    		Bge $a3, $s3, ENDe13  # branch is i >= $t4
                    		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                    		add $s2, $zero, $v0
                    		sw $s2, 0($a3)     # Colour $t5 purple
                    		addi $a3, $a3, 4    # increment i by 4
                    		j LOOPe13
                    	ENDe13:
                    	graySkip113:
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    			ANotBlack3:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip123
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP123
    			    lw $v0, lyellow
    			    j JUMPP423
    			    JUMPP123: 
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP223
    			    lw $v0, lorange
    			    j JUMPP423
    			    JUMPP223:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP323
    			    lw $v0, lred
    			    j JUMPP423
    			    JUMPP323:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP423
    			    lw $v0, lmaroon
    			    j JUMPP423
    			    JUMPP423:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe23:
                		Bge $a3, $s3, ENDe23  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe23
                	ENDe23:
                	graySkip123:
    				lw $t9, 0($t8)
    				bne $t9, $s5, ACNotBlack3 # Probs remove this
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    				ACNotBlack3: # Probs remove this
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    		BNotBLACK3:
    		    lw $t9, 0($t6)
				beq $t9, $s6, graySkip133
				addi $v0, $zero, 0x000000
				lw $a1, yellow
			    bne $t9, $a1, JUMPP133
			    lw $v0, lyellow
			    j JUMPP433
			    JUMPP133:
			    lw $a1, orange
			    bne $t9, $a1, JUMPP233
			    lw $v0, lorange
			    j JUMPP433
			    JUMPP233:
			    lw $a1, red
			    bne $t9, $a1, JUMPP333
			    lw $v0, lred
			    j JUMPP433
			    JUMPP333:
			    lw $a1, maroon
			    bne $t9, $a1, JUMPP433
			    lw $v0, lmaroon
			    j JUMPP433
			    JUMPP433:
			    
    		    add $a3, $t6, $zero
                addi $s4, $zero, 16
                div $s4, $a3, $s4
                mfhi $s3
                sub $a3, $a3, $s3

                addi $s3, $a3, 16   # Last unit to colour 
            	LOOPe33:
            		Bge $a3, $s3, ENDe33  # branch is i >= $t4
            		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
            		add $s2, $zero, $v0
            		sw $s2, 0($a3)     # Colour $t5 purple
            		addi $a3, $a3, 4    # increment i by 4
            		j LOOPe33
            	ENDe33:
            	graySkip133:
    			lw $t9, 0($t7)
    			bne $t9, $s5, BANotBlack3
    				lw $t9, 0($t8)
    				bne $t9, $s5, BCNotBlack3
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    				BCNotBlack3:
    					li $t2, 3
    					sb $t2, 0($t1)
    					j move_ball
    			BANotBlack3:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip143
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP143
    			    lw $v0, lyellow
    			    j JUMPP443
    			    JUMPP143:
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP243
    			    lw $v0, lorange
    			    j JUMPP443
    			    JUMPP243:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP343
    			    lw $v0, lred
    			    j JUMPP443
    			    JUMPP343:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP443
    			    lw $v0, lmaroon
    			    j JUMPP443
    			    JUMPP443:
    				
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe43:
                		Bge $a3, $s3, ENDe43  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe43
                	ENDe43:
                	graySkip143:
    				lw $t9, 0($t8)
    				bne $t9, $s5, BACNotBlack3
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    				BACNotBlack3:
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    		MOVE3:
    
   			addi $a2, $zero, 0 # paint previous area black 
    			add $t5, $t0, $s1 # prev ball location
    			sw $a2, 0($t5) #covering the ball on bitmap
		
		
			addi $s1, $s1,260 #updaing the ball location
			sw $s1, 0($s0) # storing new location in ball varible
		
		    
   			addi $a2, $zero, 0xFFFFFF # white color for the ball 
    			add $t5, $t0, $s1 # ball lol
    			sw $a2, 0($t5) #drawing the ball on bitmap
		
			j ballEnd
	ball3:
		li $t3, 3
		bne $t2, $t3 ballEnd # if direction != 3, exit 
		
			lw $t0, ADDR_DSPL       # $t0 = base address for display
			
		add $t6, $t0, $s1   # Load possible blocks ball may collide with :)
		addi $t7, $t6, 256 # Location above ball A
		addi $t8, $t6, 252 # Location above and left of ball C
		addi $t6, $t6, -4  # Location to left of ball B

    		li $s5, 0x000000
    		lw $t9, 0($t6)
    		bne $t9, $s5, BNotBLACK4  #Check colour of B
    			lw $t9, 0($t7)
    			bne $t9, $s5, ANotBlack4
    				lw $t9, 0($t8)
    				bne $t9, $s5, CNotBlack4
    					j MOVE4
    				CNotBlack4:
    				    lw $t9, 0($t8)
        				beq $t9, $s6, graySkip114
        				addi $v0, $zero, 0x000000
        				lw $a1, yellow
        			    bne $t9, $a1, JUMPP114
        			    lw $v0, lyellow
        			    j JUMPP414
        			    JUMPP114:
        			    lw $a1, orange
        			    bne $t9, $a1, JUMPP214
        			    lw $v0, lorange
        			    j JUMPP414
        			    JUMPP214:
        			    lw $a1, red
        			    bne $t9, $a1, JUMPP314
        			    lw $v0, lred
        			    j JUMPP414
        			    JUMPP314:
        			    lw $a1, maroon
        			    bne $t9, $a1, JUMPP414
        			    lw $v0, lmaroon
        			    j JUMPP414
        			    JUMPP414:
    				    add $a3, $t8, $zero
                        addi $s4, $zero, 16
                        div $s4, $a3, $s4
                        mfhi $s3
                        sub $a3, $a3, $s3

                        addi $s3, $a3, 16   # Last unit to colour 
                    	LOOPe14:
                    		Bge $a3, $s3, ENDe14  # branch is i >= $t4
                    		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                    		add $s2, $zero, $v0
                    		sw $s2, 0($a3)     # Colour $t5 purple
                    		addi $a3, $a3, 4    # increment i by 4
                    		j LOOPe14
                    	ENDe14:
                    	graySkip114:
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    			ANotBlack4:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip124
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP124
    			    lw $v0, lyellow
    			    j JUMPP424
    			    JUMPP124: 
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP224
    			    lw $v0, lorange
    			    j JUMPP424
    			    JUMPP224:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP324
    			    lw $v0, lred
    			    j JUMPP424
    			    JUMPP324:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP424
    			    lw $v0, lmaroon
    			    j JUMPP424
    			    JUMPP424:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe24:
                		Bge $a3, $s3, ENDe24  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe24
                	ENDe24:
                	graySkip124:
    				lw $t9, 0($t8)
    				bne $t9, $s5, ACNotBlack4 # Probs remove this
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    				ACNotBlack4: # Probs remove this
    					li $t2, 1
    					sb $t2, 0($t1)
    					j move_ball
    		BNotBLACK4:
                lw $t9, 0($t6)
				beq $t9, $s6, graySkip134
				addi $v0, $zero, 0x000000
				lw $a1, yellow
			    bne $t9, $a1, JUMPP134
			    lw $v0, lyellow
			    j JUMPP434
			    JUMPP134:
			    lw $a1, orange
			    bne $t9, $a1, JUMPP234
			    lw $v0, lorange
			    j JUMPP434
			    JUMPP234:
			    lw $a1, red
			    bne $t9, $a1, JUMPP334
			    lw $v0, lred
			    j JUMPP434
			    JUMPP334:
			    lw $a1, maroon
			    bne $t9, $a1, JUMPP434
			    lw $v0, lmaroon
			    j JUMPP434
			    JUMPP434:
    		    add $a3, $t6, $zero
                addi $s4, $zero, 16
                div $s4, $a3, $s4
                mfhi $s3
                sub $a3, $a3, $s3

                addi $s3, $a3, 16   # Last unit to colour 
            	LOOPe34:
            		Bge $a3, $s3, ENDe34  # branch is i >= $t4
            		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
            		add $s2, $zero, $v0
            		sw $s2, 0($a3)     # Colour $t5 purple
            		addi $a3, $a3, 4    # increment i by 4
            		j LOOPe34
            	ENDe34:
            	graySkip134:
    			lw $t9, 0($t7)
    			bne $t9, $s5, BANotBlack4
    				lw $t9, 0($t8)
    				bne $t9, $s5, BCNotBlack4
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    				BCNotBlack4:
    					li $t2, 2
    					sb $t2, 0($t1)
    					j move_ball
    			BANotBlack4:
    			    lw $t9, 0($t7)
    				beq $t9, $s6, graySkip144
    				addi $v0, $zero, 0x000000
    				lw $a1, yellow
    			    bne $t9, $a1, JUMPP144
    			    lw $v0, lyellow
    			    j JUMPP444
    			    JUMPP144:
    			    lw $a1, orange
    			    bne $t9, $a1, JUMPP244
    			    lw $v0, lorange
    			    j JUMPP444
    			    JUMPP244:
    			    lw $a1, red
    			    bne $t9, $a1, JUMPP344
    			    lw $v0, lred
    			    j JUMPP444
    			    JUMPP344:
    			    lw $a1, maroon
    			    bne $t9, $a1, JUMPP444
    			    lw $v0, lmaroon
    			    j JUMPP444
    			    JUMPP444:
    			    add $a3, $t7, $zero
                    addi $s4, $zero, 16
                    div $s4, $a3, $s4
                    mfhi $s3
                    sub $a3, $a3, $s3

                    addi $s3, $a3, 16   # Last unit to colour 
                	LOOPe44:
                		Bge $a3, $s3, ENDe44  # branch is i >= $t4
                		add $s4, $t0, $a3   # $t5 holds address($t0 + i)
                		add $s2, $zero, $v0
                		sw $s2, 0($a3)     # Colour $t5 purple
                		addi $a3, $a3, 4    # increment i by 4
                		j LOOPe44
                	ENDe44:
                	graySkip144:
    				lw $t9, 0($t8)
    				bne $t9, $s5, BACNotBlack4
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    				BACNotBlack4:
    					li $t2, 0
    					sb $t2, 0($t1)
    					j move_ball
    		MOVE4:
    
   			addi $a2, $zero, 0 # paint previous area black 
    			add $t5, $t0, $s1 # prev ball location
    			sw $a2, 0($t5) #covering the ball on bitmap
		
		
			addi $s1, $s1,252 #updaing the ball location
			sw $s1, 0($s0) # storing new location in ball varible
		
		    
   			addi $a2, $zero, 0xFFFFFF # white color for the ball 
    			add $t5, $t0, $s1 # ball lol
    			sw $a2, 0($t5) #drawing the ball on bitmap
	
		j ballEnd 


ballEnd:
    
	jr  $v1

   
  
colour_row: #parameters: a0: starting unit, a1: ending unit, a2: color
#
	add $t4, $zero, $a1  # Last unit to colour
	add $t9, $zero, $a0  # i starts from this unit (i = starting value) 
	#
	LOOPs: #while i < ending unit  
		Bge $t9, $t4, ENDs  # branch is i >= $t4
		add $t5, $t0, $t9   # $t5 holds addr($t0 + i)
		sw $a2, 0($t5)      # Colour $t5 with color in $a2
		addi $t9, $t9, 4    # increment i by 4 
		j LOOPs
	ENDs:
	jr $ra 
	
colour_row2: #parameters: a0: starting unit, a1: ending unit, a2: color
#
	add $t4, $zero, $a1  # Last unit to colour
	add $t9, $zero, $a0  # i starts from this unit (i = starting value) 
	#
	LOOPr: #while i < ending unit  
		Bge $t9, $t4, ENDr  # branch is i >= $t4
		add $t5, $t0, $t9   # $t5 holds addr($t0 + i)
		sw $a2, 0($t5)      # Colour $t5 with color in $a2
		sw $a2, 4($t5)      # Colour $t5 with color in $a2
		sw $a2, 8($t5)      # Colour $t5 with color in $a2
		sw $a2, 12($t5)      # Colour $t5 with color in $a2
		addi $t9, $t9, 32    # increment i by 4 
		j LOOPr
	ENDr:
	jr $ra 
	
colour_column: 
	add $t4, $zero, $a1  # Last unit to colour
	add $t9, $zero, $a0  # i starts from this unit 
	LOOPa:
		Bge $t9, $t4, ENDa   # branch is i >= $t4
		add $t5, $t0, $t9    # $t5 holds addr($t0 + i)
		sw $a2, 0($t5)       # Colour $t5 red
		sw $a2, 4($t5)       # Colour $t5 red
		sw $a2, 8($t5)       # Colour $t5 red
		sw $a2, 12($t5)       # Colour $t5 red
		addi $t9, $t9, 256   # increment i by 256
		j LOOPa
	ENDa:
	jr $ra
	
	
colour_paddel: 
	#addi $t9, $a0, 7576    # 7576, min value
	#addi  $t9, $a0, 7768  # 7768, max value
	addi $t4, $t9, 32   # Last unit to colour 
	LOOPc:
		Bge $t9, $t4, ENDc  # branch is i >= $t4
		add $t5, $t0, $t9   # $t5 holds address($t0 + i)
		sw $a2, 0($t5)      # Colour $t5 purple
		addi $t9, $t9, 4    # increment i by 4
		j LOOPc
	ENDc:
	jr $ra
	
colour_brick: 
	#addi $t9, $a0, 7576    # 7576, min value
	#addi  $t9, $a0, 7768  # 7768, max value
	addi $t4, $t9, 16   # Last unit to colour 
	LOOPf:
		Bge $t9, $t4, ENDf  # branch is i >= $t4
		add $t5, $t0, $t9   # $t5 holds address($t0 + i)
		sw $a2, 0($t5)      # Colour $t5 purple
		addi $t9, $t9, 4    # increment i by 4
		j LOOPf
	ENDf:
	jr $ra
    
respond_to_Q:
	li $v0, 10                      # Quit gracefully
	syscall
	
respond_to_U:
	li $v0, 101102                      # second level
	li $t1, 0x000000
	add $t5, $t0, $s1 # prev ball location
	sw $t1, 0($t5)
	j main
	
respond_to_A:
	
	#extracting data from memory 
		la $s1, paddle #load memory adress 
		lw $t3, 0($s1) #load word from memory 
	
		li $t2, 7696 # storing the left side min into memory 
	
	#if statment 
		beq $t3,$t2,left_end #check if curr_pos == max left, if yes then jump to end 
		
		#draw black over current post
			
			add $t9, $t3, $zero
			li $a2, 0
			

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPleft1:
				Bge $t9, $t4, ENDleft  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPleft1
			ENDleft:
			
	#add 4 to memory location
			addi $t3, $t3, -4
			sw $t3, 0($s1)
		
	#paint purple 
	  		add $t9, $zero, $t3
			li $a2, 0xA020F0 

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPleft2:
				Bge $t9, $t4, ENDleft2  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPleft2
			ENDleft2:
left_end: 
	jr $ra
	
	
	

respond_to_D:
	
	#extracting data from memory 
		la $s1, paddle #load memory adress 
		lw $t3, 0($s1) #load word from memory 
	
		li $t2, 7888  # storing the left side min into memory 
	
	#if statment 
		beq $t3,$t2,right_end #check if curr_pos == max left, if yes then jump to end 
		
		#draw black over current post
			
			add $t9, $t3, $zero
			li $a2, 0
			

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPright1:
				Bge $t9, $t4, ENDright  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPright1
			ENDright:
			
	#add 4 to memory location
			addi $t3, $t3, 4
			sw $t3, 0($s1)
		
	#paint purple 
	  		add $t9, $zero, $t3
			li $a2, 0xA020F0 

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPright2:
				Bge $t9, $t4, ENDright2  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPright2
			ENDright2:
right_end: 
	jr $ra


########################### Second Paddle ###########################



respond_to_J:
	
	#extracting data from memory 
		la $s1, paddle1 #load memory adress 
		lw $t3, 0($s1) #load word from memory 
	
		li $t2, 7440 # storing the left side min into memory 
	
	#if statment 
		beq $t3,$t2,left_end2 #check if curr_pos == max left, if yes then jump to end 
		
		#draw black over current post
			
			add $t9, $t3, $zero
			li $a2, 0
			

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPleft12:
				Bge $t9, $t4, ENDleft22  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPleft12
			ENDleft22:
			
	#add 4 to memory location
			addi $t3, $t3, -4
			sw $t3, 0($s1)
		
	#paint purple 
	  		add $t9, $zero, $t3
			li $a2, 0xbfbfbf 

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPleft22:
				Bge $t9, $t4, ENDleft21  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPleft22
			ENDleft21:
left_end2: 
	jr $ra
	
	
	

respond_to_L:
	
	#extracting data from memory 
		la $s1, paddle1 #load memory adress 
		lw $t3, 0($s1) #load word from memory 
	
		li $t2, 7632  # storing the left side min into memory 
	
	#if statment 
		beq $t3,$t2,right_end1 #check if curr_pos == max left, if yes then jump to end 
		
		#draw black over current post
			
			add $t9, $t3, $zero
			li $a2, 0
			

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPright11:
				Bge $t9, $t4, ENDright1  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPright11
			ENDright1:
			
	#add 4 to memory location
			addi $t3, $t3, 4
			sw $t3, 0($s1)
		
	#paint purple 
	  		add $t9, $zero, $t3
			li $a2, 0xbfbfbf

			addi $t4, $t9, 32   # Last unit to colour 
			LOOPright21:
				Bge $t9, $t4, ENDright21  # branch is i >= $t4
				add $t5, $t0, $t9   # $t5 holds address($t0 + i)
				sw $a2, 0($t5)      # Colour location $t5 black
				addi $t9, $t9, 4    # increment i by 4
				j LOOPright21
			ENDright21:
right_end1: 
	jr $ra

respond_to_P:
        li $v0, 32
        li $a0, 10000
        syscall
        jr $ra
	