function P = gibbs_logpred(Adk,Bkw,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% collapsed gibbs log predictive probabilities

Pdk = alpha + Adk;
ss  = sum(Pdk,2);
Pdk = Pdk ./ ss(:,ones(1,K));
Pkw = beta + Bkw;
ss  = sum(Pkw,2);
Pkw = Pkw ./ ss(:,ones(1,W));

Pi = zeros(I,1);
for ii = 1:I
  Pi(ii) = Pdk(di(ii),:) * Pkw(:,wi(ii));
end

% sum_id log( sum_k E[ Pdk * Pkxid ])
P = citest * log(Pi);



