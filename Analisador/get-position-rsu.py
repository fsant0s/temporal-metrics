###########################
# Filtra os veiculos que passaram por menos de 3 cruzamentos
import os
import pickle
from scipy.sparse import lil_matrix

dic_cruzamentos = {}
dic_carros = {}
cont_cruzamentos = 0
cont_carros = 0


def alimentar(inicio, fim):

    t_cruzamentos = 27615

    t_veiculos = 118482
    global cont_cruzamentos
    global cont_carros

    matrix = lil_matrix((t_cruzamentos, t_veiculos))

    os.chdir("result-agg")
    dici = {}
    for snap in range(inicio, fim + 1, 9):
        # if snap % 100 == 0:
        print "Snap: ", snap
        os.chdir("%s" % snap)

        arquivo = open("V2I", "r")
        linhas = arquivo.readlines()

        cruzamento = None

        for linha in linhas:
            linha = linha.split("\n")[0]
            if "# " in linha:
                cruzamento = linha.split("# ")[1]
                if (cruzamento not in dic_cruzamentos):
                    dic_cruzamentos[cruzamento] = cont_cruzamentos+1
                    cont_cruzamentos = cont_cruzamentos + 1
            else:
                carro = linha
                if (carro not in dic_carros):
                    dic_carros[carro] = cont_carros + 1
                    cont_carros = cont_carros + 1

                if carro != 'NA':
                    try:
                        j = dic_carros[carro]
                        # j = query_carro3(carro)
                        if j != None:
                            i = dic_cruzamentos[cruzamento]
                            #i = query_cruzamento(cruzamento)
                            matrix[i - 1, j - 1] = matrix[i - 1, j - 1] + 1
                            #print i, j,"=",matrix[i, j]
                    except:
                        print("Error 404")
        arquivo.close()
        os.chdir("..")
       
    os.chdir("..")
    with open('matrix-9s-agg.dat', 'wb') as outfile:
        pickle.dump(matrix, outfile, pickle.HIGHEST_PROTOCOL)


# filtro(21600,28800)
alimentar(21600, 28800)


log = open('position-rsu-agg.txt', 'a')
pd = [24160, 24161, 1809, 21216, 2582, 5632, 5621, 5627, 5622, 17214, 22918, 5835, 16013, 16014, 5623, 21213, 11888, 18639, 21188, 22914, 21189, 24933, 5611, 21212, 22913]


for key in dic_cruzamentos:
    if dic_cruzamentos[key] in pd:
        log.write(str(key) +": "+ str(dic_cruzamentos[key])+"\n" )

