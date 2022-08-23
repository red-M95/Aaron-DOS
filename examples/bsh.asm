org $7e00
format binary as "img"
use16

mov si,msg
call print

cmdloop:
   mov si,prompt
   call print
 
   mov di,buf
   call read
 
   mov si,buf
   cmp byte[si],$00 ; blank line?
   je cmdloop	    ; yes, ignore it
 
   mov si,buf
   mov di,clear ; "clear" command
   call strcmp
   jc .clear
 
   mov si,buf
   mov di,help ; "help" command
   call strcmp
   jc .help
 
   mov si,error
   call print
   jmp cmdloop
 
 .clear:
   xor ah,ah
   mov al,$03
   int $10
 
   jmp cmdloop
 
 .help:
   mov si,msg_help
   call print
 
   jmp cmdloop

strcmp:
 .loop:
   mov al,[si]	 ; grab a byte from SI
   mov bl,[di]	 ; grab a byte from DI
   cmp al,bl	 ; are they equal?
   jne .notequal ; nope, we're done.
 
   cmp al,$00 ; are both bytes (they were equal before) null?
   je .done   ; yes, we're done.
 
   inc di    ; increment DI
   inc si    ; increment SI
   jmp .loop ; loop!
 
 .notequal:
   clc ; not equal, clear the carry flag
   ret
 
 .done: 	
   stc ; equal, set the carry flag
   ret

include 'bsh.inc'
include 'bios.inc'

times 512-($-$$) db $00