# PID Python-nucleo

## Descripción

Ejemplo de comunicación desde Python con la placa Nucleo F334R8, para trabajar con un controlador PID en posición y velocidad.

El circuito fue armado por Damián Perez (mperez@df.uba.ar) y el código de la placa está en https://github.com/damian2340/servo_encoder

## Contenido

* `PID_basico.py`: ejemplo de funcionamiento básico
* `conexion_servo_driver.pdf`: Circuito de conexión de la placa nucleo con el puente H y el encoder
* `en.stsw-link009.zip`: Instalador de la placa para Windows (bajado de acá https://www.st.com/en/development-tools/stsw-link009.html)

# PID vasito, cámara, ventiladores

## Descripción

Este otro bloque sirve para la práctica de PID del vasito volador. Desde la compu capturamos imágenes de la cámara y trackeamos la imagen del vasito para medir su posición. Y controlamos la intensidad del ventilador a través de un canal PWM de la placa Arduino.

## Contenido

* `PID_camara.py`: ejemplo de funcionamiento básico de comunicación con la placa Arduino y la cámara.
* `circuito_pid.png`: Circuito de control de los ventiladores
* `pwm.ino`: Código para meter en la placa Arduino