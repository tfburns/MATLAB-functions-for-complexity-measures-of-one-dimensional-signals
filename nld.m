function fd = nld(x)
% input:    x       data (we assume the data is non-negative in this implementation)
% output:   fd      fractal dimension estimate (using NLD method)
% Thank you to Timothy L. Corley (U Arizona) for noticing that an earlier version of this function failed to note the non-negative assumption on the input data

N =      length(x); % get length of signal

% amplitude normalization / set-up
y =     zscore(x); % could use integral or window normalization techniques instead, and if we want to use negative values this should follow the special form of 'absolute-valued' regularization shown in equation 9 of Kalauzi et al. 2009
NLDi =  zeros(1,N);

% calculate NLDi with the upper limit of N and lower limit of i=2
for i = 2:N,
    NLDi(i) =    abs(y(i)-y(i-1));
end;

% use complete algorithm and sum NLDi's
NLD =    (1/N)*(sum(NLDi));

% use the power model for NLD to FD conversion
a =      1.9079;
NLDz =   0.097178;
k =      0.18383;
fd =     a*((NLD-NLDz).^k);
