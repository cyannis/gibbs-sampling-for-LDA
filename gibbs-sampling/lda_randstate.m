function [zi,theta,phi] = lda_randstate(...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% initialize gibbs and collapsed gibbs samplers by uniformly randomly 
% assigning each word to one of the K topics.
% for uncollapsed gibbs we further sample theta and phi given the observed
% data and topic assignments.

zi    = cell(I,1);
theta = zeros(D,K);
phi   = zeros(K,W);
for ii = 1:I
  cc = ci(ii);
  zi{ii}   = ceil(rand(1,cc)*K);
end

for dd = 1:D
  zz = cat(2,zi{Id{dd}});
  cc = length(zz);
  theta(dd,:) = alpha + collect(ones(1,cc),2,K,zz);
end
theta = randdir(theta,2);

for ww = 1:W
  zz = cat(2,zi{Iw{ww}});
  cc = length(zz);
  phi(:,ww) = beta + collect(ones(1,cc),2,K,zz);
end
phi = randdir(phi,2);

