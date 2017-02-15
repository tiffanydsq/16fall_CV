function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../dat/traintest.mat');

	% TODO create train_features
    L=2;
    train_features=zeros(size(dictionary,2)*(4^(L+1)-1)/3,length(train_imagenames));
    for i=1:length(train_imagenames)
    train_matname=strrep(train_imagenames{i},'.jpg','.mat');
    load(strcat('../dat/',train_matname));
    train_features(:,i)=getImageFeaturesSPM(3, wordMap, size(dictionary,2));
    end
    train_labels=train_labels';
	save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');
end