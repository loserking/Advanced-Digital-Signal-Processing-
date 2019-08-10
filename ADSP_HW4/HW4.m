clc
clear all
close all

A =imread('lena.bmp');
B = C420(A);
imwrite(uint8(B),'lena_yuv420.bmp','bmp');
