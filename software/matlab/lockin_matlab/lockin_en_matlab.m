%% Genero la se�al y la referencia

Fs = 100000;           %[Hz ] Sampling frequency                    
T = 1/Fs;              %[s] Sampling period       
L = 20000;             %[samples] Length of signal
t = (0:L-1)*T;         %[s] Time vector
MaxT = L/Fs;           %[s] Tiempo maximo

A1 = 8;                %[V] amplitud
A2 = 4;                %[V] amplitud
FREC = 200;            %[Hz] Frecuencia de la se�al y la referencia
OMEGA = FREC*2*pi;     %[rad/s] frecuencia angular
FASE1 = 0;             %[rad] Fase de la se�al respecto a la referencia
FASE2 = pi/2;          %[rad] Fase de la se�al respecto a la referencia
ruido = 4;             %[V] ruido
timeconstant=0.02;     %[s] Constante de tiempo del lockin, para el filtro

%Armo la se�al con dos tramos de distinta amplitud y fase, y le sumo ruido
SENIAL=[A1*sin(OMEGA*t(1:L/2)+FASE1) A2*sin(OMEGA*t((L/2)+1:end)+FASE2)];
RUIDO = ruido*randn(size(t));
ORIGINAL = SENIAL + RUIDO;

%Referencia
REFERENCIA1=sin(OMEGA*t);%referencia en fase
REFERENCIA2=cos(OMEGA*t);%referencia en cuadratura

%Se�al original
figure(1);clf;
subplot(3,2,1)
plot(t,ORIGINAL,t,SENIAL,t,REFERENCIA1)
ylabel('Se�al original [V]')
xlabel('Tiempo [s]')
grid on
ylim([-30 30])
legend('Se�al con ruido','Se�al','Referencia en fase')
anArrow = annotation('doublearrow','Head1Style','vback3','Head2Style','vback3','X',[.0 .099],'Y', [-25 -25]);
anArrow.Parent = gca;
anArrow = annotation('doublearrow','Head1Style','vback3','Head2Style','vback3','X',[.101 .2],'Y', [-25 -25]);
anArrow.Parent = gca;
str = sprintf('A: %g, FASE: %g',A1,FASE1);
text(.05,-23,str,'horizontalalignment','center')
str = sprintf('A: %g, FASE: %g',A2,FASE2);
text(.15,-23,str,'horizontalalignment','center')

%FFT original
subplot(3,2,2)
Y = fft(ORIGINAL);
P2 = abs(Y/L);
P1 = P2(1:(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
frecuencia = Fs*(0:(L/2))/L;
semilogy(frecuencia,P1,'o-') 
ylabel('Potencia Original ')
xlabel('Frecuencia [Hz]')
grid on
xlim([0 2000])

%% PSD, Phase sensitive detector
%calculo la salida del PSD
PSD1 = 2 * ORIGINAL .* REFERENCIA1;
PSD2 = 2 * ORIGINAL .* REFERENCIA2;%PSD del segundo canal

%PSD
subplot(3,2,3);cla;hold all
line([min(t) max(t)],[0 0],'color','k')
plot(t,PSD1)
ylabel('Se�al PSD [V]')
xlabel('Tiempo [s]')
grid on

%FFT PSD
subplot(3,2,4)
Y = fft(PSD1);
P2 = abs(Y/L);
P1 = P2(1:(L/2+1));
P1(2:end-1) = 2*P1(2:end-1);
frecuencia = Fs*(0:(L/2))/L;
semilogy(frecuencia,P1,'o-') 
ylabel('Potencia PSD ')
xlabel('Frecuencia [Hz]')
grid on
xlim([0 2000])

%% PSD FILTRADA
%Filtro la se�al que sale del PSD 
subplot(3,2,5);cla;hold all

%Elijo el filtro
filtro='butter';
% filtro='ellip';
% filtro='fir1';
% filtro='none';

fc = 1/timeconstant;%[Hz] Frecuencia de corte
switch filtro
    case 'butter'% %Filtro con butter
        order = 5;                  %el orden del filtro
        [b,a] = butter(order,fc/(Fs/2)); 
    case 'ellip'
        % %filtro con ellip. elliptic filter
        order = 5;                  %el orden del filtro
        bandpassripple=5;%with 5 dB of passband ripple
        stopbandattenuation=40;%40 dB of stopband attenuation
        [b,a] = ellip(order,bandpassripple,stopbandattenuation,fc/(Fs/2));
    case 'fir1'
        % filtro con fir1. Window-based FIR filter design
        order=1000;
        b = fir1(order,fc/(Fs/2),'low');
        a=1;        
    otherwise
        %none
        a=1;
        b=1;        
end
PSD1FILTRADA = filter(b,a,PSD1);
PSD2FILTRADA = filter(b,a,PSD2);

%filtrada
plot(t,PSD1FILTRADA)
plot(t,PSD2FILTRADA)
line([min(t) max(t)],[0 0],'color','k')
ylabel('PSD Filtrada [V]')
xlabel('Tiempo [s]')
grid on
legend('X','Y')

%FFR PDF Filtrada
subplot(3,2,6)
Y = fft(PSD1FILTRADA);
P2 = abs(Y/L);% Compute the two-sided spectrum P2.
P1 = P2(1:(L/2+1)); 
P1(2:end-1) = 2*P1(2:end-1); %Then compute the single-sided spectrum P1 based on P2 and the even-valued signal length L.
frecuencia = Fs*(0:(L/2))/L;
semilogy(frecuencia,P1,'o-') 
ylabel('Potencia PSD Filtrada')
xlabel('Frecuencia [Hz]')
grid on
xlim([0 2000])