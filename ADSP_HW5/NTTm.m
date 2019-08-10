function [A,B] = NTTm(N,M);

a=0; % alpha
b=0; % the inverse of alpha
c=0; % the inverse of N

while (((mod(a^N,M) ~=1) || (sum(mod(a.^(1:N-1),M) == 1) ~= 0) ) && a <= M-1)
    a = a+1;
end

if(a==M)
    disp(['Error: No Alpha Value']);
    A = 0;
    B = 0;
    return;
end
for i = 0:N-1
    for j = 0:N-1
        A(i+1,j+1) = mod(a^(i*j),M);
    end
end

while((mod(a*b,M) ~= 1))
    b = b + 1;
end

while((mod(N*c,M) ~= 1))
    c = c + 1;
end

for i = 0:N-1
    for j = 0:N-1
        B(i+1,j+1) = mod(c*(b^(i*j)),M);
    end
end
