print:
   lodsb ; grab a byte from SI
 
   or al,al ; logical or AL by itself
   jz .done ; if the result is zero, get out
 
   mov ah,$0e
   int $10    ; otherwise, print out the character!
 
   jmp print
 
 .done:
   ret

read:
   xor cl, cl
 
 .loop:
   xor ah,ah
   int $16   ; wait for keypress
 
   cmp al,$08	 ; backspace pressed?
   je .backspace   ; yes, handle it
 
   cmp al,$0d  ; enter pressed?
   je .done	 ; yes, we're done
 
   cmp cl,$ff  ; 63 chars inputted?
   je .loop	 ; yes, only let in backspace and enter
 
   mov ah,$0e
   int $10	; print out character
 
   stosb  ; put character in buffer
   inc cl
   jmp .loop
 
 .backspace:
   cmp cl,$00	 ; beginning of string?
   je .loop	; yes, ignore the key
 
   dec di
   mov byte[di],$00	; delete character
   dec cl		; decrement counter as well
 
   mov ah,$0e
   mov al,$08
   int 10h		; backspace on the screen
 
   mov al,' '
   int 10h		; blank character out
 
   mov al,$08
   int 10h		; backspace again
 
   jmp .loop	; go to the main loop
 
 .done:
   xor al,al	; null terminator
   stosb
 
   mov ah,$0e
   mov al,$0d
   int $10
   mov al,$0a
   int $10	       ; newline
 
   ret