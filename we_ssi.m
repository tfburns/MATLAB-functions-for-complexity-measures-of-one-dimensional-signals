function [wmean,ssv] = we_ssi(x,fs)
% input:    x       1-dimensional dataset (wave)
%           fs      sampling frequency of x
% output:   wmean   the spectral flatness measure/Wiener entropy on an expanded dynamic range (logarithmic scale) of x
%           ssv     the spectral structure variation/spectral structure index of x

% compute fft
w =    hamming(fs/50); %vary the hamming window length according to fs
nfft = 1042;
spgm = specgram(x,nfft,fs,w);
 
if(find(spgm == 0))
  [row col] =     find(spgm == 0);
  spgm(row,col)=  eps;
end

y =  abs(spgm).^2;
mp = y;
column_power = sum(mp);
for i = 1:size(mp,2)
  prob(:,i) = mp(:,i)/column_power(i);
end

[R,C] = size(prob);

for z = 1:C
   for j = R:-1:1
         if (prob(j,z)>.0001)              
          weiner(z) = sum(log(prob(1:j,z))/j)-log(sum(prob(1:j,z))/j); %calculate weiner/SFM for that 'window'  
         break;
      end
   end
end

plot(weiner,'k');
figure(2);
%print('-djpeg',[name,' - SSI.jpeg']);
specgram(x,nfft,fs,w);

wmean =  mean(weiner); %mean SFM/weiner entropy across windows
wstd =   std(weiner); %the standard deviation of the SFMs/weiner entropy across windows
wratio = wstd/wmean;
ssv =    var(weiner); %effectively the same as = sum( ((weiner-((sum(weiner))/(length(weiner)))).^2) / (length(weiner)) );