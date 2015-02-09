function [zi,theta,phi,Adk,Bkw,Mk] = stdgibbs_update(zi,theta,phi,Adk,Bkw,Mk,...
        I,D,K,W,di,wi,ci,citest,Id,Iw,Nd,alpha,beta);

% update (sample) phi's
for k=1:K
    phi(k,:) = randdir(beta + Bkw(k,:));
end

% update (sample) theta's
for d=1:D
    theta(d,:) = randdir(alpha + Adk(d,:));
end

% update (sample) zi's

k=1:K;

% for each pair (word,doc)
for i=1:I

    % substract the old topic assignments from counts
    for j=1:ci(i)
        Adk(di(i),zi{i}(j)) = Adk(di(i),zi{i}(j)) - 1;
        Bkw(zi{i}(j),wi(i)) = Bkw(zi{i}(j),wi(i)) - 1;
        Mk(zi{i}(j)) = Mk(zi{i}(j)) - 1;
    end
        
    % gen a new random probability vector
    param = phi(:, wi(i))' .* theta(di(i), :);
    
    % gen new assigments
    zi{i} = k( sum( bsxfun(@ge, rand(ci(i), 1), cumsum(param./sum(param))), 2) + 1 );
    
    % add the new topic assignments to counts
    for j=1:ci(i)
        Adk(di(i),zi{i}(j)) = Adk(di(i),zi{i}(j)) + 1;
        Bkw(zi{i}(j),wi(i)) = Bkw(zi{i}(j),wi(i)) + 1;
        Mk(zi{i}(j)) = Mk(zi{i}(j)) + 1;
    end
    
end
