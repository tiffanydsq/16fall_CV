function [accuracy, loss] = ComputeAccuracyAndLoss(W, b, data, labels)
% [accuracy, loss] = ComputeAccuracyAndLoss(W, b, X, Y) computes the networks
% classification accuracy and cross entropy loss with respect to the data samples
% and ground truth labels provided in 'data' and labels'. The function should return
% the overall accuracy and the average cross-entropy loss.
    numcorrect=0;
    [outputs] = Classify(W, b, data);
    D=size(outputs,1);
    for i=1:D
        L(i)=-log(outputs(i,:)*labels(i,:)');
        prediction(i,:)=outputs(i,:)==max(outputs(i,:));
        numcorrect=numcorrect+isequal(prediction(i,:),labels(i,:));
    end
    loss=mean(L);
    accuracy=numcorrect/D;
end
% bsxfun