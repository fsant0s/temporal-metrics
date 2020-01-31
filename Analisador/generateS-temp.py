from scipy.sparse import lil_matrix
import cPickle as pickle
import numpy as np
import copy

S = {}

matrix = None
with open('matrix-9s.dat', 'rb') as infile:
	matrix = pickle.load(infile)

cruzamentos = matrix.shape[0]
veiculos = matrix.shape[1]

#t_cruzamentos = 27615

#t_veiculos = 118482


for cruzamento in range(0,cruzamentos):
   	S[cruzamento] = []
   	print(cruzamento)
   	for veiculo in range(0,veiculos):
   		#print(cruzamento,veiculo)
   		if(matrix[cruzamento,veiculo] > 0):
   			S[cruzamento].append(veiculo)

with open('S-9s.dat', 'wb') as outfile:
        pickle.dump(S, outfile, pickle.HIGHEST_PROTOCOL)
