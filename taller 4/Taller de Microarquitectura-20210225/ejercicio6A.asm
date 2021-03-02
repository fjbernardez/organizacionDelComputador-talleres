JMP demoSIG

demoSIG:
SET R0, 0x0E

bucle:
SIG R0
JMP bucle ; genera el valor en R0 aumento de uno en uno
