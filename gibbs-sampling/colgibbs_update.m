function [zi,Adk,Bkw,Mk] = gibbs_update(zi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);

k=1:K;

% for each pair (word,doc)
for i=1:I

    % substract the old topic assignments from counts
    for j=1:ci(i)
        Adk(di(i),zi{i}(j)) = Adk(di(i),zi{i}(j)) - 1;
        Bkw(zi{i}(j),wi(i)) = Bkw(zi{i}(j),wi(i)) - 1;
        Mk(zi{i}(j)) = Mk(zi{i}(j)) - 1;
    end
        
    % gen a new random probability vector (without the 'id' count)
    param = (alpha + Adk(di(i), :)) .* (beta + Bkw(:,wi(i)))' ./ (W * beta + Mk)';

    % gen new assigments for zi's word in the current document
    cs = cumsum(param./sum(param));
    gen = sum( bsxfun(@ge, rand(ci(i),1), cs), 2) + 1;
    zi{i} = k(gen);
    
    % add the new topic assignments to counts
    for j=1:ci(i)
        Adk(di(i),zi{i}(j)) = Adk(di(i),zi{i}(j)) + 1;
        Bkw(zi{i}(j),wi(i)) = Bkw(zi{i}(j),wi(i)) + 1;
        Mk(zi{i}(j)) = Mk(zi{i}(j)) + 1;
    end
    
end