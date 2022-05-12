# -*- coding: utf-8 -*-
"""
Manómetro Edwards
Manual U (pdf): https://github.com/diegoshalom/labosdf/blob/master/manuales/Edwards-Active-Digital-Controller%20Medidor%20de%20presi%C3%B3n%20-%20Vac%C3%ADo.pdf
"""

import visa

class edwards:
    def __init__(self,port='COM1'): 
        self._gauge = serial.Serial(port, baudrate=9600)     
        self._gauge.baudrate = 9600
        self._gauge.port = port
        self._gauge.bytesize = 8
        self._gauge.parity = 'N'
        self._gauge.stopbits = 1
        self._gauge.timeout = 1   
        self.open() 

    def open(self):
        if not self._gauge.is_open:
            self._gauge.open()            

    def close(self):
        self._gauge.close()	        

    def GetPressure(self):        
        pressure = ""
        while len(pressure) != 9:
            self._gauge.write(b'?GA1\r')        
            pressure = self._gauge.readline()
            if pressure[:2]=="ERR":
                print("Error message: ",pressure)
        pres = float(pressure.decode('ascii'))
        return pres

controlador = edwards('COM1')
data = controlador.GetPressure()
print(data)
