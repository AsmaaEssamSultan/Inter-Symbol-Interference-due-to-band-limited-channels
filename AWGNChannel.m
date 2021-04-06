function y = AWGNChannel(x,No,f)
%
% Inputs:
%   x:      Signal in time domain
%   No:     2 times the noise variance
% Outputs:
%   y:      The output of the AWGN channel for the input x
%
% This function generates the effect of an AWGN channel with noise variance
% No/2 on the input signal x.

y = zeros(size(x));
%%% WRITE YOUR CODE HERE
% Your code should generate the ouptut y which is a noisy version of the
% input x, corrupted by an AWGN noise with variance No/2. Hint: use randn
% as a function for generating Gaussian noise with unit variance.
channel_noise  =  sqrt((No/2))*randn([1 length(x)]);
y = x + channel_noise ;

%%%