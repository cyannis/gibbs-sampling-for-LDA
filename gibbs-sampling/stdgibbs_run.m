function [zi,theta,phi,Adk,Bkw,Mk,LL,PP,T] ...
        = stdgibbs_run(zi,theta,phi,numiter,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
% standard gibbs run everything

LL = zeros(1,numiter+1);
PP = zeros(1,numiter+1);
T  = zeros(1,numiter+1);

time = toc;
[Adk,Bkw,Mk] = stdgibbs_counts(zi,I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
for iter = 1:numiter
  T(iter) = toc-time;
  LL(iter) = stdgibbs_logjoint(theta,phi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  PP(iter) = stdgibbs_logpred(theta,phi,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  [zi,theta,phi,Adk,Bkw,Mk] = stdgibbs_update(zi,theta,phi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  fprintf(1,'standard gibbs iteration %d logjoint %g logpred %g time %g\r',...
        iter,LL(iter),PP(iter),toc-time);
end
iter = numiter+1;
  T(iter) = toc-time;
  LL(iter) = stdgibbs_logjoint(theta,phi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  PP(iter) = stdgibbs_logpred(theta,phi,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);
  fprintf(1,'standard gibbs iteration %d logjoint %g logpred %g time %g\n',...
        numiter,LL(iter),PP(iter),toc-time);

