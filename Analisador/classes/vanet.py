#encoding:UTF-8

from math import sqrt

"""
Modulo vanet contém os componentes da rede ad hoc veicular: Veiculo e RSU.
Cada componente dispõe de um metodo para calcular a distancia baseado em um raio de
transmissão.

Author: Douglas
Date: 21/02/2015
"""

class Componente(object):
	def __init__(self, identifier, x, y):
		self.set_vehicle = set()
		self.identifier = identifier
		self.x = float(x)
		self.y = float(y)
	def transmissao(self, componente, raio):
		distancia = sqrt((componente.x - self.x)**2 + (componente.y - self.y)**2)
		if distancia <= raio:
			return True
		else:
			return False

	def contain(self, id):
		return id in self.set_vehicle

			
			

"""
 classe para moldar os objetos do tipo veiculo.
 
 @param identifier
 @param x
 @param y
 @param speed
"""
class Veiculo(Componente):
	def __init__(self, tempo, identifier, x, y, speed):
		Componente.__init__(self, identifier, x, y)
		self.tempo = int(tempo)
		self.speed = float(speed)
	def to_string(self):
		return "Veiculo[id = %s, x = %f, y = %f, speed = %f]" %(self.identifier, self.x, self.y, self.speed)



		
class RSU(Componente):
	def __init__(self, identifier, x, y):
		Componente.__init__(self, identifier, x, y)
	def to_string(self):
		return "RSU[id = %s, x = %f, y = %f]" %(self.identifier, self.x, self.y)
		
		
		
		
class Cruzamento(object):
	def __init__(self, tempo, veiculo, rsu):
		self.tempo = tempo
		self.veiculo = veiculo
		self.rsu = rsu
