# -*- coding: utf-8 -*- 
from dicionario import operations,variables
import os
import sys

len_args = len(sys.argv)

if(len_args !=2 ):
    print("Erro formato de entrada")
    print("Insira somente o arquivo de entrada .asm")
    print("Encerrando...")
    exit()




if(sys.argv[1].split('.')[1] != 'asm'):
    print("Erro formato feea")
    print("Insira somente o arquivo de entrada .asm")
    print("Encerrando...")
    exit()


symboltable_dict = {}

input_file = sys.argv[1].split('.')[0]

reservado_total_len = 8
opcode_total_len = 11
total_instruction = reservado_total_len + opcode_total_len

with open(input_file+".asm",'r') as f:
    codigo = f.readlines()

def to_file():

    os.system('mkdir {0}/'.format(input_file))

    with open("{0}/{0}.bin".format(input_file),'w') as f:
        
        for m in mif:
            f.writelines(m+'\n')

    # os.system('python bin2mif.py {0}/{0}.bin {0}/{0}.mif {1}'.format(input_file, reservado_total_len + opcode_total_len))


    print(len(mif))
    
    f=open("{0}/initROM.mif".format(input_file),"w")
    
    f.write("WIDTH=")
    f.write(str(total_instruction))
    f.write(";\n")
    f.write("DEPTH=")
    f.write(str(len(mif)))
    f.write(";\n\n")
    
    f.write("ADDRESS_RADIX=HEX;\nDATA_RADIX=BIN;\n\nCONTENT BEGIN\n")
    
    for i in range(len(mif)):
        f.write("\t")
        f.write(hex(i)[2:])
        f.write("   :   ")
        f.write(mif[i])
        f.write(";\n")
    
    f.write("END;\n")
    


def remove_comments():
    lines = []
    for line in codigo:
        comment_index = line.find("#")

        if(comment_index >=0):
            line = line[:comment_index]

        #limpando o comando
        line = line.replace('\t','')
        line = line.replace('\n','')

        #tirando os espaços finais
        if(len(line) >0):
            while(line[-1] == ' '):
                line = line[:(len(line)-1)]

        #tirando os espaçosa iniciais
        if(len(line) >0):
            while(line[0] == ' '):
                line = line[1:(len(line))]

        if(len(line) >0):
            lines.append(line)

    return lines

def symboltable():
    label_count = 0
    line_count = 0
    commands = []

    for line in codigo:

        # print(line)

        if(line.find(':') >= 0 ):
            
            colon_index = line.find(':')
            label = line[:colon_index]


            symboltable_dict[label] = line_count - label_count
            print("{0} na linha {1}".format(label,line_count - label_count))
            label_count += 1


        else:
            commands.append(line)
        line_count+=1
    
    return commands

def get_bin(x, n=0):
    return format(x, 'b').zfill(n)

def parsermif():
    mif = []


    for line in commands:
        instruction = line.split(' ')[0]

        param = line.split(' ')[1]
        cod = 0
        
        #Se o parâmetro for variável:
        if(param[0] == '$'):
            param = param[1:]
            cod = operations[instruction] + variables[param]


        elif(param[0] == '%'):

            imediato = param[1:]
            imediato_bin = get_bin(int(imediato),reservado_total_len)

            cod = operations[instruction] + imediato_bin
        else:
            #jump
            dest = line.split(' ')[1]

            dest_line = symboltable_dict[dest]
            dest_bin = get_bin(int(dest_line),reservado_total_len)

            cod = operations[instruction] + dest_bin

        mif.append(cod)
    return mif
codigo = remove_comments()

commands = symboltable()

mif = parsermif()

for m in mif:
    print(m)

to_file()







  