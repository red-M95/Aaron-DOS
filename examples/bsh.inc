msg db "Welcome to the Boot Shell (bsh)! Type 'help' for a quick list of commands.",$0a,$0d,$00
prompt db "@ ",$00
buf rb 64
clear db "clear",$00
help db "help",$00
msg_help db "Available commands:",$0a,$0d
	 db "clear",$0a,$0d
	 db "help",$0a,$0d,$00
error db "Syntax error",$0a,$0d,$00