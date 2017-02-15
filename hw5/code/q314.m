clear variables
close all
clc

load nist26_model.mat;
load('../data/nist26_test.mat', 'test_data', 'test_labels')

outputs = Classify(W, b, test_data);
cfmatrix=zeros(size(test_labels,2));
for i=1:size(outputs,1)
    gt=find(test_labels(i,:));
    pred=find(outputs(i,:)==max(outputs(i,:)));
    cfmatrix(gt,pred)=cfmatrix(gt,pred)+1;
end
% dispmatrix=1-(cfmatrix-min(cfmatrix(:)))/(max(cfmatrix(:))-min(cfmatrix(:)));
% imshow(imresize(dispmatrix,15,'nearest'));
imagesc(cfmatrix)
title('Confusion matrix showing most confusion for ''D''s and ''O''s');


