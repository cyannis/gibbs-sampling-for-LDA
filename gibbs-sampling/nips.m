% run both standard and collapsed gibbs on the nips data set
K = 40;             % number of topics
alpha = .1;         % dirichlet prior over topics
beta =  .01;         % dirichlet prior over words
numiter = 200;     % number of iterations

[I,D,K,W,di,wi,ci,citest,Id,Iw,Nd] = lda_read('pruned.data',K);

[zi,theta,phi] = lda_randstate(I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);

[zicolgibbs Adk Bkw Mk Lcolgibbs Pcolgibbs Tcolgibbs] ...
        = colgibbs_run(zi,numiter,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);

% get the topic max for each word = the final prediction (minus the prior)
[vocab] = textread('nips.vocab','%s');
[tmpm,tmpi] = max(BestBkw);

wtopics = cell(1,K);
for kk=1:K
    % get the words assigned to each topic
    wtopics{kk} = vocab(find(tmpi==kk & tmpm ~= 0));
end

