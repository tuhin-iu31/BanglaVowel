clear all; close all;

%量子化インターバルを変数quaに格納
%ITU-T Recommendation G.711を参照
%※μ-lowアルゴリズム

qua = zeros([1 129]);
qua(1) = 0;
qua(2) = 1;

for i = 3:3+14
    qua(i) = qua(i-1) + 2;
end

for i = 18:18+15
    qua(i) = qua(i-1) + 4;
end

for i = 34:34+15
    qua(i) = qua(i-1) + 8;
end

for i = 50:50+15
    qua(i) = qua(i-1) + 16;
end

for i = 66:66+15
    qua(i) = qua(i-1) + 32;
end

for i = 82:82+15
    qua(i) = qua(i-1) + 64;
end
for i = 98:98+15
    qua(i) = qua(i-1) + 128;
end
for i = 114:114+15
    qua(i) = qua(i-1) + 256;
end
%ここから非線形量子化(正負両方に対応)

[x, Fs] = audioread('filename.wav');
x = round(x * 8159);

for n = 1:length(x)
    
    tmp = abs(x(n));
    
    for i = 2:128
        if qua(i) <= tmp && qua(i+1) > tmp
            x(n) = sign(x(n)) * (qua(i) + qua(i+1)) / 2;
        end
    end
    if tmp == 8159
        x(n) = sgn(x(n)) * (qua(128) + qua(129)) / 2;
    end
    if tmp < qua(2)
        x(n) = 0;
    end
    
end

x = x / 8159;

audiowrite('filename.wav', x, Fs);