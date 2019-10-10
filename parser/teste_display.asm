LOADi %0
STORE $SEG
DISPLAY $DISP_SEG
STORE $MIN
DISPLAY $DISP_MIN
STORE $HORA
DISPLAY $DISP_HORA
LOADi %2 #coloquei aqui/raphao
STORE $HORA #coloquei aqui/raphao
LOADi %6 #coloquei aqui/raphao
STORE $MIN #coloquei aqui/raphao
LOADi %7  #coloquei aqui/raphao
STORE $TEST  #coloquei aqui/raphao

LOADi %4 #coloquei aqui/raphao


CMPTEMPO: #Comparar o valor dos divisores para fazer o tempo
	LOAD $DIVISORA  #Carregar o valor da posição DivisorA
	CMPi %1  #Comparar com o imediato 1
	JE INC_SEG  #Se for igual, pular para INC_SEG
	JMP CMPTEMPO #Se não, voltar pro inicio

INC_SEG:  #Incrementar Segundo
	LOAD $SEG #Carregar o valor de segundos no accumulador
	CMPi %5  #Compara com o imediato 59
	JE INC_MIN  #Se o valor for igual, pular para INC_MIN
	ADDi %1     #Se não, somar 1 ao valor
	STORE $SEG  #Guardar o valor incrementado na posição de memoria do seg
	DISPLAY $DISP_SEG
	JMP RST     #Pular para RST

INC_MIN:
    LOAD $TEST  #coloquei aqui/raphao era LOAD $MIN
    ADDi %1
	STORE $MIN
	DISPLAY $DISP_MIN
	LOADi %0
	STORE $SEG
	DISPLAY $DISP_SEG
	JMP RST     #Pular para RST

RST:
	LOAD $DIVISORB
	JMP CMPTEMPO