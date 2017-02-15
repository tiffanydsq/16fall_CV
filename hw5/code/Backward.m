function [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a)
% [grad_W, grad_b] = Backward(W, b, X, Y, act_h, act_a) computes the gradient
% updates to the deep network parameters and returns them in cell arrays
% 'grad_W' and 'grad_b'. This function takes as input:
%   - 'W' and 'b' the network parameters
%   - 'X' and 'Y' the single input data sample and ground truth output vector,
%     of sizes Nx1 and Cx1 respectively
%   - 'act_h' and 'act_a' the network layer pre and post activations when forward
%     forward propogating the input smaple 'X'

H=length(W);
softmax=exp(act_a{H})./repmat(sum(exp(act_a{H})),size(act_a{H},1),1);
deltah{H}=softmax .* (1-Y/(Y'*softmax));

for i=1:size(W{H},1)
    grad_W{H}(i,:)=softmax(i)*(1-Y(i)/(Y'*softmax))*act_h{H-1};
    grad_b{H}(i,1)=softmax(i)*(1-Y(i)/(Y'*softmax));
end

for i=H-1:-1:2
    deltah{i}=act_h{i}.*(1-act_h{i}).*(W{i+1}'*deltah{i+1});%sum(deltah{i+1}*W{i+1})';
    grad_W{i}=deltah{i}*act_h{i-1}';
    grad_b{i}=deltah{i};
end

deltah{1}=act_h{1}.*(1-act_h{1}).*(deltah{2}'*W{2})';%sum(W{2}'*deltah{2});
grad_W{1}=deltah{1}*X';%act_h{1};
grad_b{1}=deltah{1};

end
