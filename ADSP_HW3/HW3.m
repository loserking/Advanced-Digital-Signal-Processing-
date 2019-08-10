clc
close all
clear all

volume = 1; % 調整音量大小
scale = 'C'; % 支援C, D, E, F, G, A, B 大調
BPM = 120; % beat per minute, 決定節奏的快慢
score = [1, 1, 5, 5, 6, 6, 5]; % 1: Do, 2: Re, 3: Mi, …
beat  = [1, 1, 1, 1, 1, 1, 2]; % 拍子
name = 'twinkle'; % 存檔的名稱

getmusic(volume, scale, BPM, score, beat, name) % generate the music file twinkle.wav

%, 4, 4, 3, 3, 2, 2, 1, 5, 5, 4, 4, 3, 3, 2, 5, 5, 4, 4, 3, 3, 2, 1, 1, 5, 5, 6, 6, 5, 4, 4, 3, 3, 2, 2, 1
%, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1 ,1, 2, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 2