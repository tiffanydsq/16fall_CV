function [h] = getImageFeaturesSPM(layerNum, wordMap, dictionarySize)
% Compute histogram of visual words using SPM method
% Inputs:
%   layerNum: Number of layers (L+1)
%   wordMap: WordMap matrix of size (h, w)
%   dictionarySize: the number of visual words, dictionary size
% Output:
%   h: histogram of visual words of size {dictionarySize * (4^layerNum - 1)/3} (l1-normalized, ie. sum(h(:)) == 1)

% TODO Implement your code here
%H=zeros(layerNum,layerNum,dictionarySize);

h=zeros(1,dictionarySize * (4^layerNum - 1)/3);
%[r,c]=ndgrid(1:numsep,1:numsep);
count=0;

% l=L=2
l=layerNum-1;
numsep=2^l;
ch=floor(size(wordMap,1)/numsep);
cw=floor(size(wordMap,2)/numsep);
hf=cell(numsep,numsep);
for r=1:numsep
    for c=1:numsep
        count= count+1;
        hist=histcounts(wordMap((r-1)*ch+1:r*ch,(c-1)*cw+1:c*cw),1:dictionarySize+1);
        hf{r,c}=hist/norm(hist,1); %unweighted h
        h((count-1)*dictionarySize+1:count*dictionarySize)=hist/norm(hist,1)/2/numsep/numsep;
    end
end

%l=1~l=L-1
for l=1:layerNum-2
    numsep=2^l;
    for r=1:numsep
        for c=1:numsep
            count= count+1;
            hist=hf{2*r-1,2*c-1}+hf{2*r-1,2*c}+hf{2*r,2*c-1}+hf{2*r,2*c};
            hf{r,c}=hist/norm(hist,1); %unweighted h
            h((count-1)*dictionarySize+1:count*dictionarySize)=hist/norm(hist,1)/2^(layerNum-l)/numsep/numsep;
        end
    end
end

% l=0
count=count+1;
hist=hf{1,1}+hf{1,2}+hf{2,1}+hf{2,2};
h((count-1)*dictionarySize+1:count*dictionarySize)=hist/norm(hist,1)/2^(layerNum-1);

%
h=h';
assert(numel(h) == (dictionarySize * (4^layerNum - 1)/3));
end