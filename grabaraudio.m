function [x] = grabaraudio(t,fs)
% Funci�n para grabar un archivo de audio con el nombre "grabacion".
% Devuelve un vector x y su frecuencia de muestreo y almacena la se�al grabada en la carpeta "grabaraudio".

recObj = audiorecorder(fs, 16, 1); % Crea un objeto grabador de audio
disp('Comenzando a grabar');
recordblocking(recObj, t); % Grabar durante t segundos
disp('Grabaci�n finalizada');
x = getaudiodata(recObj); % Obtiene los datos grabados

audiowrite('grabacion.wav', x, fs); % Guarda el archivo de audio en la carpeta actual

% Reproduce la se�al grabada
[y,fs] = audioread('grabacion.wav');
sound(y,fs);

end
