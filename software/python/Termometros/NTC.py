"""
Tabla de calibracion de un NTC (Negative Temperature Coefficient), termistor
Modelo 104-GT-2 fabricado por "ATC Semitec"
Rango Temperatura: -50C a 300C
Rango Resistencia: 80 Ohm a 8.7 MOhm
"""

import numpy as np
import matplotlib.pyplot as plt

# Funcion que carga tabla e interpola
def NTC_res2temp_tabla(R): #en Ohm
    data = np.loadtxt('NTC_104-GT-2.csv',delimiter=',',skiprows=1) 
    temperature_vals = np.flip(data[:,0]) # en Celsius (flip porque R tiene que ser creciente)
    resistance_vals = np.flip(data[:,1]) #en Ohm (flip porque R tiene que ser creciente)
    # Tomo log porque R exponencial con T
    return np.interp(np.log10(R), np.log10(resistance_vals), temperature_vals)

# Funcion que utiliza polinomio (opera sobre log(R) pues R exponencial con T)
def NTC_res2temp_poli(R): #en Ohm
   a,b,c,d,e,f = [ 8.30898289e+02, -4.43056704e+02,  1.16417971e+02, -1.87119140e+01,
      1.63900559e+00, -5.96756860e-02]
   logR = np.log10(R)
   return a + b*logR + c*logR**2 + d*logR**3 + e*logR**4 + f*logR**5

# Grafico ambas
R = np.logspace(np.log10(80),np.log10(8.7e6),100)
plt.semilogx(R, NTC_res2temp_tabla(R))
plt.semilogx(R, NTC_res2temp_poli(R))
plt.ylabel('Temperatura [C]')
plt.xlabel('Resistencia NTC [Ohm]')
plt.legend(('Poli','Interp'))
plt.grid(True)
