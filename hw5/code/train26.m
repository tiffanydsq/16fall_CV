clear variables
close all 
clc

num_epoch = 30;
classes = 26;
layers = [32*32, 400, classes];
learning_rate = 0.01;

load('../data/nist26_test.mat', 'test_data', 'test_labels')
%  %{
load('../data/nist26_train.mat', 'train_data', 'train_labels')
load('../data/nist26_valid.mat', 'valid_data', 'valid_labels')
[W, b] = InitializeNetwork(layers);
% save('nist26_initial_0001.mat','W','b');
% save('nist26_initial_001.mat','W','b');
% load('nist26_initial_001.mat','W','b');
% load('nist26_initial_0001.mat','W','b');
tic
for j = 1:num_epoch
    shuffle=randperm(size(train_data,1));
    shuffled_train_data=train_data(shuffle,:);
    shuffled_train_labels=train_labels(shuffle,:);
    [W, b] = Train(W, b, shuffled_train_data, shuffled_train_labels, learning_rate);
    [train_acc(j), train_loss(j)] = ComputeAccuracyAndLoss(W, b, shuffled_train_data, shuffled_train_labels);
    [valid_acc(j), valid_loss(j)] = ComputeAccuracyAndLoss(W, b, valid_data, valid_labels);
    fprintf('Epoch %d - accuracy: %.5f, %.5f \t loss: %.5f, %.5f \n', j, train_acc(j), valid_acc(j), train_loss(j), valid_loss(j))
    toc
    fprintf('\n')
    
end

x=1:num_epoch;
figure(1)
plot(x,train_acc,x,valid_acc);
legend('Train','Valid')
title('Accuracy');
figure(2);
plot(x,train_loss,x,valid_loss);
legend('Train','Valid')
title('Cross-entropy Loss');
% save('train26_Rate','train_acc','train_loss','valid_acc','valid_loss');
% save('train26_Rate0001','train_acc','train_loss','valid_acc','valid_loss');
% save('nist26_model_0001.mat', 'W', 'b');
% save('nist26_model.mat','W','b'); 
%  %}

%% Get test result

load nist26_model_001.mat
[test_acc, test_loss] = ComputeAccuracyAndLoss(W, b,test_data, test_labels);


