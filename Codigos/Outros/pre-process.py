#Arquivo Original: time, id, x, y, speed
#2 horas: 7200 segundos
#8 horas: 28800 segundos
# 21600 segundos é 6 hr

from math import sqrt

#entrada do dataset
dadosIn = open("files/kolntrace",'r')

dic = {}

time = 21600#tempo inicial do dataset
timeFinish = 28800 #tempo final do dataset
nextTime = 60 # intervalo de "salto" 

#arquivo de saída (grafo gerado)
dadosOut = open("graph120.txt",'w')

t = 1
while True:

	eof = dadosIn.readline()
	valor = eof.rstrip().split()

	if(not eof or valor[0] > str(time) ):
		print(time)
	
		for i in dic:
			for j in dic:
				if(i != j):
					dist = sqrt( (dic[i][0]-dic[j][0])**2 + (dic[i][1]-dic[j][1])**2 ) #verifica se a distancia entre todos os carros são de 100m. Se sim, forma um a aresta de X para  Y.
					if(dist <= 100):
						dadosOut.write(i +" "+ j + " " + str(t) + " " +str(t)+ "\n")
		
		
		if(not eof or valor[0] >  str(timeFinish)):
			print "[=>] Leitura terminada"
			break

		dic = {}
		time = time + nextTime
		t += 1

	if (valor[0] == str(time)) :
		vall = valor[1]
		
		if ("#" in vall):
			vall = vall.replace("#","")
			
		if ("." in vall):
			vall = vall.replace(".","")
			
		if ("_" in vall):
			vall = vall.replace("_","")
	
		dic[vall] = (float(valor[2]),float(valor[3]))


dadosIn.close()
dadosOut.close()