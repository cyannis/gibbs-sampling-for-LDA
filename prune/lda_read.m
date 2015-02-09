function [I,D,K,W,di,wi,ci,citest,Id,Iw,Nd] = lda_read(fname,K);
% initialize LDA model from file.  
% File has to contain I lines, each is doc# word# count testcount

[di,wi,ci,citest] = textread(fname,'%d%d%d%d');

I = length(di);

if I == 0 || length(wi)~=I || length(ci)~=I || length(citest)~=I
  error('lengths of di, wi, ci, citest must agree and be positive');
elseif any(di<=0) || any(wi<=0) || any(di~=ceil(di)) || any(wi~=ceil(wi))
  error('document and word indices must be positive integers');
elseif any(ci<0) || any(ci~=ceil(ci)) || ...
       any(citest<0) || any(citest~=ceil(citest))
  error('counts must be non-negative integers');
end

D  = max(di);
W  = max(wi);
di = di';
wi = wi';
ci = ci';
citest = citest';

X = sparse(di,wi,1:I,D,W,I);
Id = cell(1,D);
Nd = zeros(1,D);
Iw = cell(1,W);
for ww = 1:W
  ii = find(X(:,ww));
  Iw{ww} = full(X(ii,ww));
end
X = X';
for dd = 1:D
  ii = find(X(:,dd));
  Id{dd} = full(X(ii,dd));
  Nd(dd) = sum(ci(Id{dd}));
end

