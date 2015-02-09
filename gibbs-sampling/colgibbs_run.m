function [zi,Adk,Bkw,Mk,LL,PP,T] = colgibbs_run(zi,numiter,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% collapsed gibbs run everything

LL = zeros(1,numiter+1);
PP = zeros(1,numiter+1);
T  = zeros(1,numiter+1);

time = toc;
[Adk,Bkw,Mk] = colgibbs_counts(zi,I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
for iter = 1:numiter
  T(iter) = toc-time;
  LL(iter) = colgibbs_logjoint(Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  PP(iter) = colgibbs_logpred(Adk,Bkw,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  [zi,Adk,Bkw,Mk] = colgibbs_update(zi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  fprintf(1,'collapsed gibbs iteration %d logjoint %g logpred %g time %g\r',...
        iter,LL(iter),PP(iter),toc-time);
end
iter = numiter+1;
  T(iter) = toc-time;
  LL(iter) = colgibbs_logjoint(Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  PP(iter) = colgibbs_logpred(Adk,Bkw,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  fprintf(1,'collapsed gibbs iteration %d logjoint %g logpred %g time %g\n',...
        numiter,LL(iter),PP(iter),toc-time);

