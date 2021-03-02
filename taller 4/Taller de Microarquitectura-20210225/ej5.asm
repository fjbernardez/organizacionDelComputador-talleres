	SET R0 , 0x04
	SET R1 , 0X00
	SET R2 , 0x01
	SET R3 , 0X01
ciclo:	CMP R0 , R2
	JN fin
	ADD R1 , R2
	ADD R2 , R3
	JMP ciclo
  fin:	JMP fin
