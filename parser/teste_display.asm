LOADi %5
STORE $SEG
DISPLAY $SEG
STORE $MIN
DISPLAY $MIN
STORE $HORA
DISPLAY $HORA

CMPTEMPO: #Comparar o valor dos divisores para fazer o tempo
	LOAD $DIVISORA  #Carregar o valor da posição DivisorA
	CMPi %1  #Comparar com o imediato 1
	JE INC_SEG  #Se for igual, pular para INC_SEG
	JMP CMPTEMPO #Se não, voltar pro inicio

INC_SEG:  #Incrementar Segundo
    LOADi %0
    STORE $DIVISORB
	LOAD $SEG #Carregar o valor de segundos no accumulador
	CMPi %59  #Compara com o imediato 59
	JE INC_MIN  #Se o valor for igual, pular para INC_MIN
	ADDi %1     #Se não, somar 1 ao valor
	STORE $SEG  #Guardar o valor incrementado na posição de memoria do seg
	DISPLAY $SEG
	JMP RST     #Pular para RST

INC_MIN: #Incrementar Minuto
	LOAD $MIN  #Carregar o valor de segundos no accumulador
	CMPi %59	#Compara com o imediato 59
	JE INC_HORA	#Se o valor for igual, pular para INC_HORA
	ADDi %1		#Se não, somar 1 ao valor
	STORE $MIN  #Guardar o valor na posição de memoria do min
	DISPLAY $MIN
	LOAD $SEG   #Carregar o valor de segundos
	XOR $SEG    #Fazer XOR com eles mesmo, isso irá zerar o valor
	STORE $SEG  #Guardar o valor
	DISPLAY $SEG
	JMP RST     #/Pular para o RST

INC_HORA: #Incrementar a Hora
	LOAD $HORA  #Carregar o valor de horas
	CMPi %23	#Comparar com o imediato 23
	JE RSTDIGITOS  #Se for igual, pular para RSTDIGITOS
	ADDi %1     #Se não, somar 1 ao valor
	STORE $HORA #Guardar o valor
	DISPLAY $HORA
	LOAD $MIN   #Carregar o valor de minuto
	XOR $MIN    #Zerá-lo
	DISPLAY $HORA
	STORE $MIN  #Guarda-lo
	DISPLAY $MIN
	LOAD $SEG   #Carregar o valor de segundo
	XOR $SEG    #Zerá-lo
	STORE $SEG  #Guarda-lo
	DISPLAY $SEG
	JMP RST     #Pular para o RST

RST: #Resetar tempo
	LOADi %1
	STORE $DIVISORB #Guardar o valor na posição DIVISORB
	JMP CMPTEMPO #Pular para CHECK


RSTDIGITOS:
	LOADi %0
	STORE $HORA #Guardar o valor
	STORE $MIN  #Guarda-lo
	STORE $SEG  #Guardá-lo
	JMP RST     #Pular para o RST