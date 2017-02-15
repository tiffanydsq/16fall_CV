function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../dat/traintest.mat');

	% TODO Implement your code here
    conf=zeros(8,8);
    count=0;
    for i=1:length(test_imagenames)
        test_matname=strrep(test_imagenames{i},'.jpg','.mat');
        load(strcat('../dat/',test_matname));
        test_features=getImageFeaturesSPM(3, wordMap, size(dictionary,2));
        similarity = distanceToSet(test_features, train_features);
        [~,idxPredict] = max(similarity);
        classGT= test_labels(i);
        classPredict= train_labels(idxPredict);
        conf(classGT,classPredict)=conf(classGT,classPredict)+1;
        if classGT~=classPredict
            classP=mapping{train_labels(idxPredict)};
            count=count+1;
            mis{count,1}=test_imagenames{i};
            mis{count,2}=classP;
        end
    end
    save mis 
end

