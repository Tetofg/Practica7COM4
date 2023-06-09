
function [y]=Ecualizador(Ganancias,x,fs)

    if nargin<3 % revisa si se ingreso fs o si no toma como valor fs=8000
    disp('No ha ingresado la frecuencia de muestreo fs, por lo tanto tomara el valor por default fs=48000 Hz')
    disp('Esto provocara una mala grabación de las funciones finales si no coinciden los fs')
    fs=16000;
    end 
    if nargin==2 % revisa si se ingreso fs o si no toma como valor fs=8000
       fs=48000;
    end
    G=Ganancias;
    fac=1;%Normalización de la frecuencia
    
%Frecuancias de corte para Filtros
    Wn1 =  fac*[0.01098  0.02150]; %filtro banda 1
    Wn2 =  fac*[0.02150  0.04150]; %filtro banda 2
    Wn3 =  fac*[0.05250  0.07250]; %filtro banda 3
    Wn4 =  fac*[0.08500  0.11500]; %filtro banda 4
    Wn5 =  fac*[0.11500  0.18300]; %filtro banda 5
    Wn6 =  fac*[0.19400  0.29700]; %filtro banda 6
    Wn7 =  fac*[0.30000  0.40500]; %filtro banda 7
    Wn8 =  fac*[0.41000  0.60500]; %filtro banda 8
    Wn9 =  fac*[0.60000  0.76040]; %filtro banda 9
    Wn10 = fac*[0.77000  0.92465]; %filtro banda 10

%filtros butter  
        [b1,a1] = butter(2,Wn1);
        y1 = filter(b1,a1,x);
        audiowrite('filtro1.wav', y1, fs);

        [b2,a2] = butter(3,Wn2,'bandpass');
        y2 = filter(b2,a2,x);
        audiowrite('filtro2.wav', y2, fs);

%filtros cheby1  
        [b3,a3] = cheby1(5,10,Wn3);
        y3 = filter(b3,a3,x);
        audiowrite('filtro3.wav', y3, fs);
        
        [b4,a4] = cheby1(5,10,Wn4);
        y4 = filter(b4,a4,x);
        audiowrite('filtro4.wav', y4, fs);
        
  %filtros ellip  
  
        [b5,a5] = ellip(5,10,500,Wn5);
        y5 = filter(b5,a5,x);
        audiowrite('filtro5.wav', y5, fs);
        
        [b6,a6] = ellip(5,1,200,Wn6);
        y6 = filter(b6,a6,x);
        audiowrite('filtro6.wav', y6, fs);
 
%filtros cheby2      
 
        [b7,a7] = cheby2(10,50,Wn7);
        y7 = filter(b7,a7,x);
        audiowrite('filtro7.wav', y7, fs);

        
        [b8,a8] = cheby2(10,40,Wn8);
        y8= filter(b8,a8,x);
        audiowrite('filtro8.wav', y8, fs);

        
 %filtros tipo fir
 
         y9=y8;
         y10=y9;
         b9 = fir1(60,Wn9);
         ym9 = conv(b9,x);
         audiowrite('filtro9.wav', y9, fs);
          
         b10 = fir1(60,Wn10);
         ym10 =conv(b10,x);
         audiowrite('filtro10.wav', y10, fs);
         
         
%Arreglo de vectores
         y9=1:length(x);
         y10=y9;
         for i=1:length(x)
           y9(i)=ym9(i);
           y10(i)=ym10(i);
         end
         y9=transpose(y9);
         y10=transpose(y10);
       
%Calculo de función de salida   
       
        %Arreglo de vector de ganancias para orientación de vector 
        v=size(G);
        if v(1,1)==10
            G=transpose(G);
        end
        
    y=G(1,1)*y1+G(1,2)*y2+G(1,3)*y3+G(1,4)*y4+G(1,5)*y5+G(1,6)*y6+G(1,7)*y7+G(1,8)*y8+G(1,9)*y9+G(1,10)*y10; 
%guardando el archivo de audio

audiowrite('y.wav', y, fs);

  %Graficas
    %Funciones
        figure(12)
      n=1:length(x);
      subplot(2,1,1)
            stem(n,x)
            title('x[n]')
      subplot(2,1,2)
            stem(n,y)
            title('y[n]')
            
      %filtros
      
        figure(1)
        fvtool(b1,a1)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  31.5 Hz')
        
        figure(2)
        fvtool(b2,a2)
             title('FILTRO CON FRECUENCIA CENTRAL EN:  63 Hz')
             
        figure(3)
        fvtool(b3,a3)
             title('FILTRO CON FRECUENCIA CENTRAL EN: 125 Hz')
             
        figure(4) 
        fvtool(b4,a4)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  250 Hz')
        
        figure(5)
        fvtool(b5,a5)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  500 Hz')
        
        figure(6)
        fvtool(b6,a6)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  1 kHz')
            
        figure(7)    
        fvtool(b7,a7)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  2 kHz')
            
        figure(8)    
        fvtool(b8,a8)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  4 kHz')
            
        figure(9)    
        fvtool(b9,1)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  8 kHz')
            
        figure(10)    
        fvtool(b10,1)
            title('FILTRO CON FRECUENCIA CENTRAL EN:  16 kHz')
            
        figure(11)    
        fvtool(b1,a1,b2,a2,b3,a3,b4,a4,b5,a5,b6,a6,b7,a7,b8,a8,b9,1,b10,1)
        title('RELACION TOTAL DE FILTROS GON GANANCIA UNITARIA')
     
         
   