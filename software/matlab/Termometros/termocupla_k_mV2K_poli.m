function Ts=termocupla_k_mV2K_poli(mVs)
%convierte milivots a kelvin para una termocupla tipo k, sacado de
% 'http://www.home.agilent.com/upload/cmc_upload/All/5306OSKR-MXD-5501-040107_2.htm?&cc=AR&lc=eng'
%
%elijo los coeficientes dependiendo del rango de voltajes
%error menor 0.05K para 70K<T<1645K

Ts=nan(size(mVs));
for i=1:length(mVs)
    Ts(i)=mv2T(mVs(i));
end
end

function T=mv2T(mV)
if mV<0
%  The coefficients for Temperature range -200 deg C to 0 deg C 
%  Voltage range -5.891 mV to 0 mV
%  Error Range .04 deg C to -.02 deg C are:    
 C0 = 273;
 C1 = 2.5173462 * 10^1;
 C2 = -1.1662878;
 C3 = -1.0833638;
 C4 = -8.9773540 * 10^-1;
 C5 = -3.7342377 * 10^-1;
 C6 = -8.6632643 * 10^-2;
 C7 = -1.0450598 * 10^-2;
 C8 = -5.1920577 * 10^-4;
 C9 = 0;
elseif mV<20.644
%  The coefficients for Temperature range 0 deg C to 500 deg C
%  Voltage range 0 mV to 20.644 mV
%  Error range .04 deg C to -.05 deg C are:    
 C0 = 273;
 C1 = 2.508355 * 10^1;
 C2 = 7.860106 * 10^-2;
 C3 = -2.503131 * 10^-1;
 C4 = 8.315270 * 10^-2;
 C5 = -1.228034 * 10^-2;
 C6 = 9.804036 * 10^-4;
 C7 = -4.413030 * 10^-5;
 C8 = 1.057734 * 10^-6;
 C9 = -1.052755 * 10^-8; 
else 
%  The coefficients for Temperature range 500 deg C to 1372 deg C
%  Voltage range 20.644 mV to 54.886 mV
%  Error range .06 deg C to -.05 deg C are:    
 C0 = 273-1.318058 * 10^2;
 C1 = 4.830222 * 10^1;
 C2 = -1.646031 ;
 C3 = 5.464731 * 10^-2;
 C4 = -9.650715 * 10^-4;
 C5 = 8.802193 * 10^-6;
 C6 = -3.110810 * 10^-8;
 C7 = 0;
 C8 = 0;
 C9 = 0;
end

 T = C0 + C1*mV + C2*mV.^2 + C3*mV.^3 + C4*mV.^4 ...
        + C5*mV.^5 + C6*mV.^6 + C7*mV.^7 +  C8*mV.^8 + C9*mV.^9;
end


