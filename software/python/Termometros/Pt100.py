"""
Tabla de calibracion de un PT100
Rango Temperatura: -200C a 850C
Rango Resistencia: 18.52Ohm a 390.48Ohm
"""

import numpy as np
import matplotlib.pyplot as plt

# Funcion que carga tabla e interpola 
def PT100_res2temp_interp(R): #en Ohm
    data = np.loadtxt('Pt100_resistencia_temperatura.csv',delimiter=',') 
    temperature_vals = data[:,0] # en Celsius
    resistance_vals = data[:,1] #en Ohm
    return np.interp(R, resistance_vals, temperature_vals)

R = np.linspace(18.53,390.47,100)
plt.plot(R, PT100_res2temp_interp(R))
plt.ylabel('Temperatura [C]')
plt.xlabel('Resistencia Pt100 [Ohm]')
plt.grid(True)
