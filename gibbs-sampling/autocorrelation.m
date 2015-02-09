function [ac] = autocorrelation(x,lag)
% Compute the autocorrelations for each lag from one to the lag value.
% x is the chain the autocorrelations are computed from.


n = length(x); % the length of the chain
m = sum(x) ./ n; % the estimated mean
v = ((x-m)'*(x-m)); % estimated unormalized variance (denominator)

ac = zeros(1, lag); % the autocorrelations vector

for l=1:lag

    ccs = 0; % correlation cumulated sum

    % for each value, compute the autocorrelation numerator (the sum of the
    % product of each value in the chain separated by a lag l).
    for t=(l+1):(n-l)
      ccs = ccs + (x(t) - m) * (x(t - l) - m);  
    end

    ac(l) = sum(ccs) ./ v; % add the autocorrelation to the final vector.
end
