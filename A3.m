% Configuraci�n de la duraci�n y frecuencia de muestreo de la grabaci�n
duracion_grabacion = 5; % duraci�n de la grabaci�n en segundos
frecuencia_muestreo = 44100; % frecuencia de muestreo en Hz

% Grabaci�n de audio
x = grabaraudio(duracion_grabacion, frecuencia_muestreo);

% Visualizaci�n de la forma de onda del audio grabado
plot(x);
title('Forma de onda del audio grabado');
xlabel('Tiempo (s)');
ylabel('Amplitud');

% C�lculo de la duraci�n y frecuencia fundamental del audio grabado
duracion_audio = length(x) / frecuencia_muestreo;
frecuencia_fundamental = 1 / duracion_audio;
fprintf('Duraci�n del audio grabado: %.2f segundos\n', duracion_audio);
fprintf('Frecuencia fundamental del audio grabado: %.2f Hz\n', frecuencia_fundamental);

