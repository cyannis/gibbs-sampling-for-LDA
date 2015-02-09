K=50;

[I,D,K,numselectedw,di,wi,ci,citest,Id,Iw,Nd] = lda_read('nips.data',K);

%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Calculate the heuristic for each word
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

% get vocabulary to have interpretable results
[vocab] = textread('nips.vocab','%s');

% get frequency of the words
tfidf = zeros(1, numselectedw);
for w=1:numselectedw
    
    % number of documents it appears in (high presence = not relevant)
    tf = log(D) - log(length(Iw{w}));
    
    % 'frequence' in the corpus (high presence = relevant)
    idf = sum(ci(Iw{w}));

    % final heuristic
    tfidf(w) = tf * idf;
end
[~, idtfidf] = sort(tfidf);
vocabsorted = vocab(idtfidf);

%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
% Write the 500 words selected into the file 'pruned.data'
%- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
numselectedw = 500;
selectedwords = idtfidf(end:-1:end-numselectedw);

% save the new words
fileID = fopen('pruned.data','w');

for ww=1:numselectedw
    indices = Iw{selectedwords(ww)};
    for ii=1:length(indices)
        fprintf(fileID,'%d %d %d %d\n', di(indices(ii)), selectedwords(ww), ...
            ci(indices(ii)), citest(indices(ii)));
    end
end

fclose(fileID);
