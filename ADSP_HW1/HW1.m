clc
close all
clear all

filter_length = 15;
sampling_frequency = 1500;
stop_band = [0 420];
transition_band = [360 480];
weighting = [1 0.6];
delta = 0.0001;

f_stop_band = stop_band/sampling_frequency;
f_transition_band = transition_band/sampling_frequency;
extreme_point = [0 0.05 0.1 0.15 0.2 0.35 0.4 0.45 0.5];
interval = 0.000001;
node_num = 0.5/interval + 1;
E1 = inf;
err = 0 : interval : 0.5;
x = 0 : interval : 0.5;
extreme_point_num = (filter_length -1)/2 + 2;
h = zeros(1,node_num);
for i = 1 : node_num;
    if   (i/node_num/2) >= (f_stop_band(1))&& (i/node_num/2) <= (f_stop_band(2))
        h(i) = 0;
    else
        h(i) = 1;
    end
end
while(1)
E0 = 0;
Hd = zeros(1,(filter_length -1)/2 + 2);
amp = zeros(1,node_num)
A = zeros((filter_length -1)/2 + 2,(filter_length -1)/2 + 2);
for i = 1 : extreme_point_num
    if( f_stop_band(1) <= extreme_point(i) && f_stop_band(2) >= extreme_point(i))
        Hd(i) = 0;
    else
    	Hd(i) = 1;
    end
end;
A(:,1) = 1;
for i = 1 : (filter_length -1)/2 + 2
    for j = 2 : (filter_length -1)/2 + 1
        A(i,j) = cos(2*pi*extreme_point(i)*(j-1));
    end
end
for i = 1 : (filter_length -1)/2 + 2
        if(Hd(i) == 0)
            A(i, (filter_length -1)/2 + 2) = (-1)^(i-1) / weighting(2);
        else if(Hd(i) ~= 0)
            A(i, (filter_length -1)/2 + 2) = (-1)^(i-1) / weighting(1);
        end
    end
end

s = A\Hd';
s = s';
n=length(s);

for j = 1 : node_num
    for i = 1 : n-1
        amp(j) = s(i)*cos(2*pi*x(j)*(i-1)) + amp(j);
    end
end

for i = 1 : node_num
    err(i) = 0;
    if i/node_num/2 < f_transition_band(1) || i/node_num/2 > f_transition_band(2)
        if h(i) == 0
            err(i) = (amp(i) - 0) * weighting(2);
        else
            err(i) = (amp(i) - 1) * weighting(1);
        end
    else
        err(i) = 0;
    end
end
extreme_point_num = 0;
extreme_point = 0;
for i = 1 : node_num
    if E0<abs(err(i))
        E0 = abs(err(i));
    end
    if i == 1 || i/node_num/2 == f_transition_band(2)
        if (abs(err(i)) > abs(err(i+1)))
            extreme_point_num= extreme_point_num+1;
            if i ==1 
                extreme_point(extreme_point_num) = 0;
            else
                extreme_point(extreme_point_num) = (i-1)/node_num/2;
            end
        end
    elseif i/node_num/2 == f_transition_band(1) || i/node_num/2 == 0.5
        if (abs(err(i)) > abs(err(i-1)))
            extreme_point_num= extreme_point_num+1;
            extreme_point(extreme_point_num) = (i-1)/node_num/2;
        end
    else
        if(abs(err(i)) > abs(err(i-1)) && abs(err(i)) > abs(err(i+1)))
            extreme_point_num= extreme_point_num+1;
            extreme_point(extreme_point_num) = (i-1)/node_num/2;
    end
    end
end
E0
if( (E1-E0) < delta )
    break
else
    E1 = E0;
end
end
extreme_point
hn = zeros(1,filter_length);
for i = 1: filter_length
    if( i == (filter_length-1)/2 +1 )
        hn(i) = s(1);
    else
        hn(i) = s(abs((filter_length-1)/2 +1-i)+1)/2;
    end
end

hn
plot(x,amp,x,h)
text(0.225, 0.24, 'R(F)');
text(0.24, 0.9, 'Hd(F)');