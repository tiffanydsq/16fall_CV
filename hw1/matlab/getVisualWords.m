function [wordMap] = getVisualWords(img, filterBank, dictionary)
% Compute visual words mapping for the given image using the dictionary of visual words.

% Inputs:
% 	img: Input RGB image of dimension (h, w, 3)
% 	filterBank: a cell array of N filters
% Output:
%   wordMap: WordMap matrix of same size as the input image (h, w)

% TODO Implement your code here
if size(img,3)<3
    img=repmat(img,[1 1 3]);
end
H=size(img,1);
W=size(img,2);
dictionary=dictionary';
fresponse = extractFilterResponses(img, filterBank);
d=pdist2(fresponse,dictionary);
[~,wordMap]=min(d,[],2);
wordMap=reshape(wordMap,[H W]);

