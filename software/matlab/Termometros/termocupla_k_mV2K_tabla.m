function Ts=termocupla_k_mV2K_tabla(mVs)
%convierte milivots a kelvin para una termocupla tipo k, sacado de
% http://www.pyromation.com/downloads/data/emfk_c.pdf
% TABLE 9 Type K Thermocouple ? thermoelectric voltage as a function of
% temperature (°C); reference junctions at 0 °C
% Thermoelectric Voltage in Millivolts


load termocupla_k_mv2T% cargo la tabla (una vez, por cada llamada a la fcn)
Ts=nan(size(mVs));
for i=1:length(mVs)
    Ts(i)=mv2T(mVs(i),TemperaturaK,VoltajemV);%calculo el voltaje usando la tabla
end
end

function T=mv2T(mV,TemperaturaK,VoltajemV)
index=find(mV<=VoltajemV,1,'first');
T=TemperaturaK(index);
end