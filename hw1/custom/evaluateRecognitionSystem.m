function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

load('vision.mat');
load('../dat/traintest.mat');
train_features=train_features';
Bag= TreeBagger(500,train_features,train_labels,'OOBPred','on');
save Bag
% ntree=500 'OOBPred','on'    0.7688
% ntree=500 'OOBPred','off' 0.7438
% ntree=50 'OOBPred','on'   0.7188

conf=zeros(8,8);

for i=1:length(test_imagenames)
   
    test_matname=strrep(test_imagenames{i},'.jpg','.mat');
    load(strcat('../dat/',test_matname));
    test_features=getImageFeaturesSPM(3, wordMap, size(dictionary,2));
    
    class=predict(Bag,test_features');
    classPredict = str2num(class{1});
    
    classGT= test_labels(i);

    conf(classGT,classPredict)=conf(classGT,classPredict)+1;
end

end

