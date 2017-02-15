function [filterBank, dictionary] = getFilterBankAndDictionary(imPaths)
% Creates the filterBank and dictionary of visual words by clustering using kmeans.

% Inputs:
%   imPaths: Cell array of strings containing the full path to an image (or relative path wrt the working directory.
% Outputs:
%   filterBank: N filters created using createFilterBank()
%   dictionary: a dictionary of visual words from the filter responses using k-means.

% TODO Implement your code here
filterBank  = createFilterBank();
alpha=200; %50 %alpha=200:1080.863016
filterresponses=zeros(alpha*length(imPaths),3*length(filterBank));
tic
for i=1:length(imPaths) % i = 579 Error %1000s
    i
    I=imread(imPaths{i});
    %I=imread('sun_actxjfubtgbnomqp.jpg');
    if size(I,3)<3
        I=repmat(I,[1 1 3]);
    end
    I=im2double(I);
    fresponse = extractFilterResponses(I, filterBank);
    sample=randperm(size(I,1)*size(I,2),alpha);
    filterresponses((i-1)*alpha+1:i*alpha,:)=fresponse(sample,:);
    toc
end

tic
K=300 %150;%100; %K=150:300s
[~, dictionary] = kmeans(filterresponses, K, 'EmptyAction','drop');
dictionary=dictionary';
toc

end
