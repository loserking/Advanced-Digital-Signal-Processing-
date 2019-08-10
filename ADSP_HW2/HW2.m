clear all
close all
clc

k=8; %modify here to change the number of node
N=2*k+1;
H=j*2*pi;
interval = 0.0001;
x=0:interval:1;
node_num = 1/interval+1;
sampling_interval = node_num/N;
Hd = zeros(1,node_num);
r1_temp = zeros(1,N);
r1 = zeros(1,N);
r = zeros(1,N);
R = zeros(1,node_num);
h = zeros(1,N);
for i=1 : node_num
    if (x(i)<0.5)
        Hd(i)=H*x(i);
    else
        Hd(i)=H*(x(i)-1);
    end
end

r1_temp(1) = Hd(1);
for i =1 : N-1
    r1_temp(i+1) = Hd(round(i*sampling_interval));
end
r1=ifft(r1_temp);

for i= 1 : N
    if(i < (N+1)/2)
        r(i) = r1(i+(N+1)/2);
    else
        r(i) = r1(i-(N-1)/2);
    end
end

for i = 1 : node_num
    for z = 1 : N
        R(i) = R(i) + r(z)*exp(-j*2*pi*x(i)*((z-1)-(N-1)/2));
    end
end

subplot(2,1,1);
plot(x,real(Hd),x,real(R))
subplot(2,1,2);
plot(x,imag(Hd),x,imag(R))
