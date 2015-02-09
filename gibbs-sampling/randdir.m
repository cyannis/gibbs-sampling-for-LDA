function ww = randdir(aa,normdim);
% ww = randdir(aa,normdim)
% Returns draws ww from Dirichlet distribution, with parameters given by aa.
% Basically, samples from one gamma variable for each entry in aa, then
% normalize so that along normdim ww sums to 1.  If normdim is not given the
% first nontrivial dimension is used.
% uses randgamma, which is a mex file which needs to be compiled first.

ww = randgamma(aa);

if length(aa) <= 1
  ww = 1;
  return;
end

if nargin == 1
  normdim = find(size(aa)>1);
  normdim = normdim(1);
end

ndim = ndims(aa);
index = struct('type','()','subs',{repmat({':'},1,ndim)});
index.subs{normdim} = ones(1,size(aa,normdim));

ww = ww./subsref(sum(ww,normdim),index);
