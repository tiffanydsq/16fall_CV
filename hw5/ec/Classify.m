function [outputs] = Classify(W, b, data)
% [predictions] = Classify(W, b, data) should accept the network parameters 'W'
% and 'b' as well as an DxN matrix of data sample, where D is the number of
% data samples, and N is the dimensionality of the input data. This function
% should return a vector of size DxC of network softmax output probabilities.

D=size(data,1);
% for i=1:size(data,1)
%     [outputs(:,i), act_h, act_a] = Forward(W, b, data(i,:)');
%   [output, act_h, act_a] = Forward(W, b, X)
act_a{1}=W{1}*data'+repmat(b{1},1,D);
% act_h{1}=1./(1+exp(act_a{1}));

for i=2:length(W)
    act_h{i-1}=1./(1+exp(-act_a{i-1})); % sigmoid
    act_a{i}=W{i}*act_h{i-1}+repmat(b{i},1,D);
end

outputs=exp(act_a{end})./repmat(sum(exp(act_a{end})),size(act_a{end},1),1);
outputs=outputs';

end
