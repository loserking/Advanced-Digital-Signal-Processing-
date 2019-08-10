clc
close all
clear all

M=5;
N=4; %N=2;

[A,B] = NTTm(N,M);

A
B
I = mod(A*B,M)