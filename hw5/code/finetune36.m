clear variables
close all 
clc

num_epoch = 5;
classes = 36;
layers = [32*32, 800, classes];
learning_rate = 0.01;

load('../data/nist36_test.mat', 'test_data', 'test_labels')
load('nist36_initial.mat','W','b');

%{
load('../data/nist26_model_60iters.mat','W','b')
W0=W;
b0=b;
load('../data/nist36_train.mat', 'train_data', 'train_labels')
load('../data/nist36_valid.mat', 'valid_data', 'valid_labels')
[W, b] = InitializeNetwork(layers);
W{1}=W0{1};
W{2}(1:26,:)=W0{2}(1:26,:);
b{1}=b0{1};
b{2}(1:26,:)=b0{2}(1:26,:);

save('nist36_initial.mat','W','b');
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
save('train36_Rate001','train_acc','train_loss','valid_acc','valid_loss');
save('nist36_model_001.mat', 'W', 'b');
save('nist36_model.mat','W','b'); 
%}

load nist36_model.mat
[test_acc, test_loss] = ComputeAccuracyAndLoss(W, b,test_data, test_labels);

