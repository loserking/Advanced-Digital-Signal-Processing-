function B=C420(A)
A = double(A);
[h,w,depth] = size(A);

rgb2yuv=[ 0.2990    0.5870    0.1140;...
   -0.1690   -0.3310    0.5000;...
    0.5000   -0.4190   -0.0810;];

yuv = zeros(h,w,depth);
yuv_sample = zeros(h,w,depth);
B = zeros(h,w,depth);

for i = 1 : h
    for j = 1 : w
        yuv(i,j,:) = rgb2yuv * [A(i, j, 1);A(i, j, 2);A(i, j, 3)];
    end
end

%sample
yuv_sample(1:h, 1:w, 1) = yuv(1:h, 1:w, 1);
yuv_sample(1:2:end, 1:2:end, 2) = yuv(1:2:end, 1:2:end, 2);
yuv_sample(2:2:end, 1:2:end, 3) = yuv(2:2:end, 1:2:end, 3);

%for border issues
yuv_sample(1,1:2:end, 3) = yuv(2,1:2:end, 3);
yuv_sample(h,1:2:end,2) = yuv(h-1,1:2:end,2);

% interpolation
yuv_sample(2:2:end-2, 1:2:end, 2) = (yuv_sample(1:2:end-2, 1:2:end, 2) + yuv_sample(3:2:end, 1:2:end, 2))./2;
yuv_sample(3:2:end, 1:2:end, 3) = (yuv_sample(2:2:end-2, 1:2:end, 3) +  yuv_sample(4:2:end, 1:2:end, 3))./2;
yuv_sample(:, 2:2:end-2, 2:3) = (yuv_sample(:, 1:2:end-2, 2:3) +  yuv_sample(:, 3:2:end, 2:3))./2;

% for border issues
yuv_sample(:,w,2:3) = yuv_sample(:,w-1,2:3);

for i = 1 : h
    for j = 1 : w
        B(i,j,:) = inv(rgb2yuv) *[yuv_sample(i, j, 1);yuv_sample(i, j, 2);yuv_sample(i, j, 3)];
    end
end
B = uint8(B);
