% Electromagnetism C - Coursework
% Devon Kerai (B128203)

% Question 4

% Pre-requisites to clear the command window and workspace
clear
clc

% Variables
r = 20;
z = 80;

Ba = 2*((r^2)+(z^2))^(-3/2);
Bb = (3*(r^2))*(((r^2)+(z^2))^(-5/2));
Bc = ((r^2)+(z^2))^(-3/2);
Bd = (3*(z^2))*(((r^2)+(z^2))^(-5/2));
Bfinal = Ba-Bb+Bc-Bd