JMP InicioControlDelTren

InicioControlDelTren:
JMP seteoValoresIniciales

seteoValoresIniciales:
SET R0, 0x0C ; curva proxima
SET R1, 0x0F ; curva superada
SET R2, 0x02 ; intensidad de la bocina
SET R3, 0x00 ; numero de curvas superadas
SET R4, 0x20 ; 0x20=32=cantidad de curvas establecida
SET R5, 0xFF ; buffer para consultar direccion [0x00] con instrucción LOAD
STR [0xF0], R1 ; velocidad maxima inicial.
SET R6, controlDeVelocidad
STR [0x00], R6 ; etiqueto el handler de la interrupcion
LOAD R7, [0xF0] ; registro para visualizar estado actual de [0xF0]

STI ; activo interrupciones
JMP poolingBocina

poolingBocina:
CMP R3, R4 ; comparo R3 con 0x20=32
JZ incrementaIntensidadBocina ; pregunto si R3=32
JMP poolingBocina

incrementaIntensidadBocina:
SIG R2 ; incremento intensidad de la bocina
JMP poolingBocina ; retorno al ciclo

; la logica del control de velodidad es cambiar a la velocidad opuesta
; dado que son dos estados posibles: curva proxima o curva superada
controlDeVelocidad:
LOAD R5, [0xF0] ; cargo estado actual
CMP R5, R0
JZ esCurvaProxima ; consulto si el estadoa actual es curva proxima
retornoEsCurvaProxima: ; ¿deberia ser un call?
CMP R5, R1
JZ esCurvaSuperada ; consulto si el estadoa actual es curva superada
retornoEsCurvaSuperada: ; ¿deberia ser un call?
IRET ; retorno al proximo fetch

esCurvaProxima:
STR [0xF0], R1 ; cambio a curva superada
LOAD R7, [0xF0]
JMP retornoEsCurvaProxima ; retorno ¿deberia ser un call?

esCurvaSuperada:
STR [0xF0], R0 ; cambio a curva proxima
LOAD R7, [0xF0]
SIG R3 ; aumento en 1 las curvas superadas
JMP retornoEsCurvaSuperada ; retorno
