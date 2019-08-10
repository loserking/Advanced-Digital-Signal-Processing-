function getmusic(volume, scale, BPM,score, beat, name)
% generate the music file name.wav
S_L = length(score);
fs = 8000;
tempo = 60/BPM;
filename = [name '.wav'];
switch scale
    case 'C'
        Do = 261.63;
    case 'D'
        Do = 261.63 * 2^(2/12);
    case 'E'
        Do = 261.36 * 2^(4/12);
    case 'F'
        Do = 261.36 * 2^(5/12)
    case 'G'
        Do = 261.63 * 2^(7/12);
    case 'A'
        Do = 261.63 * 2^(9/12);
    case 'B'
        Do = 261.63 * 2^(11/12);
end
Re = Do * 2^(2/12);
Mi = Do * 2^(4/12);
Fa = Do * 2^(5/12);
So = Do * 2^(7/12);
La = Do * 2^(9/12);
Si = Do * 2^(11/12);
Hz = [Do, Re, Mi, Fa, So, La, Si];
x = [];
for i = 1 : S_L
	t = [1/fs : 1/fs : tempo*beat(i)];
    x = [x, (volume*cos(2*pi*Hz(score(i))*t).*exp(-3*t))];
end
sound(x, fs)
wavwrite(x, fs, filename);
