#encoding: UTF-8

from classes.vanet import *
from os import mkdir
from os import chdir


#----------- Variaveis -------------#
inicio = 21600 				# tempo inicial: 6 horas
fim = 28800 				# tempo final: 8 horas
intervalo = 9 				# 9 segundos
tempo = inicio 				# tempo atual
arquivo = "data/kolntrace" 	# arquivo com traços de mobilidade
arquivo2 = "data/koln.txt" 	# arquivo com traços de mobilidade
veiculos = []				# veiculos no mapa no intervalo de tempo atual
dps = []					# dps
#-----------------------------------#




#---------- Cruzamentos -----------#
"""
Carregando cruzamentos do arquivo.

"""
cruzamentos = open(arquivo2, 'r')
cruzamentos = cruzamentos.readlines()

for cruzamento in cruzamentos:
	linha = cruzamento.split(" ")
	dp = RSU(linha[0], linha[1], linha[2])
	dps.append(dp)
#----------------------------------#



#------------ Funcoes --------------#
def analisar(veiculos, dps, tempo):
	tempo = "%s" %tempo
	try:
		mkdir(tempo)
	except OSError:
		pass
	chdir(tempo)	
	
	for veiculo in veiculos:
		
		saida = open("V2V", "a")
		saida.write("# %s\n" %veiculo.identifier)
		
		quant = 0
		for veiculo2 in veiculos:	
			if veiculo != veiculo2:
				if veiculo.transmissao(veiculo2, 100):
					saida.write("%s\n" %veiculo2.identifier)
					quant += 1
					
		if quant == 0:
			saida.write("NA\n")
		
		saida.close()			
					
	for dp in dps:				
		saida = open("V2I", "a")
		saida.write("# %s\n" %dp.identifier)
		
		quant = 0
		for veiculo in veiculos:
			if dp.transmissao(veiculo, 100):
				saida.write("%s\n" %veiculo.identifier)
				quant += 1
					
		if quant == 0:
			saida.write("NA\n")
		
		saida.close()
			
	chdir("..")			
	
	
#----------- Inicio ---------------#
arquivo = open(arquivo, "r")
linha = arquivo.readline()
linha = linha.split(" ")
tempo = int(linha[0])
cont = 0

try:
	mkdir("result")
except OSError:
	pass
chdir("result")
	
	
	
while True:
	if inicio == tempo:
		cont += 1
		veiculo = Veiculo(linha[0], linha[1], linha[2], linha[3], linha[4])
		veiculos.append(veiculo)
		
		linha = arquivo.readline()
		linha = linha.split(" ")
		
		if len(linha[0]) != 0:
			tempo = int(linha[0])
		else:
			analisar(veiculos, dps, tempo)
			break
	elif tempo < inicio:
		linha = arquivo.readline()
		linha = linha.split(" ")
		tempo = int(linha[0])
		continue
	elif tempo > fim:
		break
	else:
		print "+--------------------------------------+"
		print "|Tempo: ", tempo - 1
		print "|Veículos no cenário: ",cont
		print "+--------------------------------------+"
		analisar(veiculos, dps, tempo - 1)
		veiculos = []
		cont = 0
		inicio += intervalo
