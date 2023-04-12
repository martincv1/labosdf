# -*- coding: utf-8 -*-
"""
Fuente Agilent B2901A
Manual Usuario (local): \\Srvlabos\manuales\HP-Agilent\B2901A\B2910-90010.pdf
"""

from __future__ import division, unicode_literals, print_function, absolute_import

import visa

print(__doc__)


# Este string determina el intrumento que van a usar.
# Lo tienen que cambiar de acuerdo a lo que tengan conectado.
resource_name = 'USB0::0x0957::0x8B18::MY51140178::INSTR'

rm = visa.ResourceManager()

inst = rm.open_resource(resource_name, write_termination='\n')

# query idn
print(inst.query('*IDN?'))

# Ultimos valores medidos de 
# Voltage, corriente, resistencia, tiempo, status, source ouput setting
print(inst.query_ascii_values(':READ:SCALar?'))


float(inst.query('MEASURE:VOLT:DC?')) #para consultar el voltaje.


# parámetros para controlal la fuente
inst.write(":SOUR:FUNC:MODE CURR") # Modo corriente
inst.write(":SOUR:CURR 0.1") # Pone una corriente
inst.write(":SENS:VOLT:PROT 6") #Establece el límite de voltaje

inst.write(":SOUR:FUNC:MODE VOLT") # Modo voltaje
inst.write(":SOUR:VOLT 5") # Pone un voltaje
inst.write(":SENS:CURR:PROT 0.5") #Establece el límite de corrienteº


inst.write(":OUTP OFF") #Apago la salida

inst.close()


