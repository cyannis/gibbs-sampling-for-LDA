function P = stdgibbs_logpred(theta,phi,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% standard gibbs log predictive probabilities

Pi = zeros(I,1);
for ii = 1:I
  Pi(ii) = theta(di(ii),:) * phi(:,wi(ii));
end

P = citest * log(Pi);
