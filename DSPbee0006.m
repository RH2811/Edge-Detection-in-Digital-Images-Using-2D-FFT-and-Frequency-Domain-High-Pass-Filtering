%Edge Detection in Digital Images Using 2D FFT and Frequency Domain High-Pass Filtering
% ROHITH A - 23BEE0006
clc;
clear;
close all;

disp('Code started');

% Read the image from MATLAB working directory
img = imread('abc.jpg');

% Display image size in command window (height, width, channels)
disp(size(img));

% If the image is RGB (3 channels), convert it to grayscale
if size(img,3) == 3
    img = rgb2gray(img);
    %Gray = 0.2989R + 0.5870G + 0.1140B
end

% Resize image to 512x512 for faster FFT processing
img = imresize(img,[512 512]);

% Create figure window and display original image
figure('Position',[100 100 900 300]);

subplot(3,1,1)
imshow(img,[])
title('Original Image')

% Convert image to frequency domain using 2D Fast Fourier Transform
F = fft2(img);

% Shift zero frequency component to the center of spectrum
F_shift = fftshift(F);

% Show logarithmic magnitude spectrum for better visibility
subplot(3,1,2)
imshow(log(1+abs(F_shift)),[])
title('Magnitude Spectrum')

% Generate frequency grid
[M,N] = size(img);
[u,v] = meshgrid(1:N,1:M);

% Compute distance of each point from center
D = sqrt((u-N/2).^2 + (v-M/2).^2);

% Define cutoff frequency for high-pass filtering
D0 = 30;

% Create circular high-pass filter mask
H = double(D > D0);

% Apply high-pass filter to shifted FFT
G = F_shift .* H;

% Shift spectrum back and convert to spatial domain
G = ifftshift(G);
edge_img = real(ifft2(G));

subplot(3,1,3)
imshow(edge_img,[])
title('Edge Detected Image')

disp('Reached end of code');