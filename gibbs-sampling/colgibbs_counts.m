function [Adk,Bkw,Mk] = gibbs_stats(zi,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% collect counts

Adk = zeros(D,K);
for dd = 1:D
  zz = cat(2,zi{Id{dd}});
  cc = length(zz);
  Adk(dd,:) = collect(ones(1,cc),2,K,zz);
end
Bkw = zeros(K,W);
for ww = 1:W
  zz = cat(2,zi{Iw{ww}});
  cc = length(zz);
  Bkw(:,ww) = collect(ones(1,cc),2,K,zz)';
end
Mk  = sum(Bkw,2);
