clear variables
close all
clc

classes = 8;
layers = [30, 20, 5, classes];
learning_rate = 1e-4;
train_data=10*rands(1,30);
train_labels=zeros(1,classes);
train_labels(randperm(classes,1))=1;
epsilon=1e-4;
[W, b] = InitializeNetwork(layers);

for idx = 1:size(train_data,1)
    tic
    % Get BP grad
    [output, act_h, act_a] = Forward(W, b, train_data(idx,:)');
    [grad_W, grad_b] = Backward(W, b, train_data(idx,:)', train_labels(idx,:)', act_h, act_a);
    gradGT_W=grad_W;
    for layer=1:length(W)
        for i=1:size(W{layer},1)
            for j=1:size(W{layer},2)
                WP=W;
                WM=W;
                WP{layer}(i,j)=W{layer}(i,j)+epsilon;
                WM{layer}(i,j)=W{layer}(i,j)-epsilon;
                [train_accP, train_lossP] = ComputeAccuracyAndLoss(WP, b, train_data, train_labels);
                [train_accM, train_lossM] = ComputeAccuracyAndLoss(WM, b, train_data, train_labels);
                gradGT_W{layer}(i,j)=(train_lossP-train_lossM)/(2*epsilon);
                %% Use Relative Error as measurement metric
                RelativeError=abs((gradGT_W{layer}(i,j)-grad_W{layer}(i,j)) / grad_W{layer}(i,j))
            end
        end
    end
    toc
end

