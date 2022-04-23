"""
Tabla de calibracion Termocupla tipo K
Rango Temperatura: -200C a 500C (73K a 773K)
Rango Voltaje: -5.891 mV a 20.644 mV
"""

import numpy as np
import matplotlib.pyplot as plt

# funcion que carga la tabla e interpola
def TC_K_volt2temp_interp(mV): # en mV 
    data = np.loadtxt('termocupla_k_mv2T.csv',delimiter=',')
    temperature_vals = data[:,0] # en K 
    voltage_vals = data[:,1] # en mV 
    return np.interp(mV, voltage_vals, temperature_vals)

# funcion utiliza polinomio
def TC_K_volt2temp_poli(mV): # en mV 
    #  The coefficients for Temperature range -200 deg C to 0 deg C 
    #  Voltage range -5.891 mV to 0 mV
    #  Error Range .04 deg C to -.02 deg C are:    
    C0 = 273
    C1 = 2.5173462 * 10**1
    C2 = -1.1662878
    C3 = -1.0833638
    C4 = -8.9773540 * 10**-1
    C5 = -3.7342377 * 10**-1
    C6 = -8.6632643 * 10**-2
    C7 = -1.0450598 * 10**-2
    C8 = -5.1920577 * 10**-4
    C9 = 0            
    T1 = C0 + C1*mV + C2*mV**2 + C3*mV**3 + C4*mV**4 + C5*mV**5 + C6*mV**6 + C7*mV**7 +  C8*mV**8 + C9*mV**9                

    #  The coefficients for Temperature range 0 deg C to 500 deg C
    #  Voltage range 0 mV to 20.644 mV
    #  Error range .04 deg C to -.05 deg C are:    
    C0 = 273
    C1 = 2.508355 * 10**1
    C2 = 7.860106 * 10**-2
    C3 = -2.503131 * 10**-1
    C4 = 8.315270 * 10**-2
    C5 = -1.228034 * 10**-2
    C6 = 9.804036 * 10**-4
    C7 = -4.413030 * 10**-5
    C8 = 1.057734 * 10**-6
    C9 = -1.052755 * 10**-8
    T2 = C0 + C1*mV + C2*mV**2 + C3*mV**3 + C4*mV**4 + C5*mV**5 + C6*mV**6 + C7*mV**7 +  C8*mV**8 + C9*mV**9        
    
    return T1 * (mV<0) + T2 * (mV>=0) * (mV<20.644) #Kelvin

# Grafico ambas
mV = np.linspace(-5.891,20.643,100)
plt.plot(mV, TC_K_volt2temp_poli(mV))
plt.plot(mV, TC_K_volt2temp_interp(mV))
plt.ylabel('Temperatura [K]')
plt.xlabel('Voltaje Termocupla K [mV]')
plt.legend(('Poli','Interp'))
plt.grid(True)

