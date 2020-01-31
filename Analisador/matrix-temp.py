###########################
# Filtra os veiculos que passaram por menos de 3 cruzamentos
import os
import pickle

from scipy.sparse import lil_matrix

dic_cruzamentos = {}
dic_carros = {}
cont_cruzamentos = 0
cont_carros = 0


def filtro(inicio, fim):
    os.chdir("result")

    contatos = {}
    for i in range(inicio, fim + 1, 9):
        print i
        os.chdir("%s" % i)
        arquivo = open("V2I", 'r')
        linhas = arquivo.readlines()
        for linha in linhas:
            linha = linha.split("\n")[0]
            if "# " in linha:
                cruzamento = linha.split("# ")[1]
            else:
                carro = linha
                if carro != 'NA':
                    if contatos.has_key(carro):
                        if not cruzamento in contatos[carro][0]:
                            contatos[carro][0].append(cruzamento)
                        if not i in contatos[carro][1]:
                            contatos[carro][1].append(i)
                    else:
                        contatos[carro] = [[cruzamento], [i]]

        arquivo.close()
        os.chdir("..")

    X = []
    for veiculo in contatos:
        cruzamentos = list(set(contatos[veiculo][0]))
        cruzamentos = len(cruzamentos)

        tempo = list(set(contatos[veiculo][1]))
        tempo = len(tempo)

        if (cruzamentos >= 4) and (tempo >= 60):
            X.append((veiculo, cruzamentos, tempo))

    # insert_filtro(X)
    os.chdir("..")

    return X


#################################

def alimentar(inicio, fim):
    # cruzamentos = query_cruzamento()
    # carros = query_carro2()
    # close()
    t_cruzamentos = 27615
    # t_veiculos = 118769
    t_veiculos = 118482
    global cont_cruzamentos
    global cont_carros

    matrix = lil_matrix((t_cruzamentos, t_veiculos))

    os.chdir("result")
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
    with open('matrix-9s.dat', 'wb') as outfile:
        pickle.dump(matrix, outfile, pickle.HIGHEST_PROTOCOL)


# filtro(21600,28800)
alimentar(21600, 28800)

