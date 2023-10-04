# AtariBreakOut
Atari Breakout an arcade video game developed and published by Atari, Inc. I implemented this in Assembly Language using the MIPS 32 Architecture.

# Instructions

Assemble the Code.
Open and configure Bits Map display. 8 by 8 unit. 512 by 256 grid. $gp.
Open and configure Keyboard and Display MMIO Simulator.
Run the program.

Recomended Compiler: http://courses.missouristate.edu/kenvollmar/mars/
For faster runtime use Saturn IDE

# How to play:

1. Use the keys ”a” and ”d” to move the lower paddle.
2. Use the keys ”j” and ”l” to move the upper paddle
3. The goal is to keep the ball from falling off the screen, and to hit the bricks. Make use of the paddles in the
game to do so.
4. Each brick needs to be hit twice to break the brick
5. There are unbreakable bricks which are grey, these bricks cannot be broken no matter how many times they
are hit.
6. For more fun there is an extra level we implemented, you can access the extra level by pressing ”2”
7. To pause the game at any time press the ”p” button

# Brief details on implementation of extra features
• Second paddle: Copied over the first paddles implementation, but ensured that it lay one row above.
• Unbreakable bricks: Used a conditional jump to ignore breaking bricks of gray color.
• Game Pausing: Using syscalls and sleep functions
• Second level(Extra level): Redrew the screen using loops and multiple sw statements.
• Multiple hits: Based on the color either change the color of the brick or delete it entirely.

