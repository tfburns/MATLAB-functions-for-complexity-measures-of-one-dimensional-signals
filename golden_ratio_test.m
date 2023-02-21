% testing the first elements of the infinite Fibonacci word (sequence A003849 in the OEIS)
x = [0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1]

% set-up
N =      length(x); % get length of signal
kmax =   5; % maximal degree of reduction/degree of time stretch (increasing this will increase FD estimates)
Lmk =    zeros(kmax,kmax);

% get the mean length of curve
for k = 1:kmax,
    for m = 1:k,
        Lmki = 0;
        for i=1:fix((N-m)/k),
            Lmki = Lmki+abs(x(m+i*k)-x(m+(i-1)*k));
        end;
        Ng =        (N-1)/(fix((N-m)/k)*k);
        Lmk(m,k) =  (Lmki*Ng)/k;
    end;
end;

Lk = zeros(1,kmax);
for k = 1:kmax,
    Lk(1,k) = sum(Lmk(1:k,k))/k;
end;

% calculate the logarithmic values for slope calculation (which is the FD estimate)
lnLk =  log(Lk);
lnk =   log(1./[1:kmax]);

% calculate the slope and assign it to output
b =     polyfit(lnk,lnLk,1);
fd =    b(1);

fd-1