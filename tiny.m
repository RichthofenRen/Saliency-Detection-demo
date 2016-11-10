clear all;
clc
close all;
%% Read image from file
src = imread('birds.jpg');%well5    1223  
inImg = im2double(rgb2gray(imread('birds.jpg')));
%%inImg = imresize(inImg, 64/size(inImg, 2));

%% Spectral Residual
subplot(121);
imshow(src);

myFFT = fft2(inImg);
myLogAmplitude = log(abs(myFFT));
myPhase = angle(myFFT);
mySpectralResidual = myLogAmplitude - imfilter(myLogAmplitude, fspecial('average', 3), 'replicate');
saliencyMap = abs(ifft2(exp(mySpectralResidual + i*myPhase))).^2;

%% After Effect
%saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [10, 10], 2.5)));
saliencyMap = mat2gray(imfilter(saliencyMap, fspecial('gaussian', [20, 20], 30))); 
subplot(122);
imshow(saliencyMap);
