clear variables
close all
clc

classes = 26;
layers = [32*32, 400, classes];
% [W0, b0] = InitializeNetwork(layers);
% Weight0=W0{1};
% Before
load nist26_initial_001.mat
W0=W;
b0=b;
Weight0=W0{1};
subplot(1,2,1);
for i=1:size(Weight0,1)
    maps0(:,:,1,i)=reshape(Weight0(i,:),[32 32]);
end
maxall0=max(maps0(:));
minall0=min(maps0(:));
maps_scaled0=(maps0-minall0)/(maxall0-minall0);
montage(maps_scaled0);

% After
load nist26_model_001.mat;
subplot(1,2,2);
Weight=W{1};
for i=1:size(Weight,1)
    maps(:,:,1,i)=reshape(Weight(i,:),[32 32]);
    %mapminmax
end
maxall=max(maps(:));
minall=min(maps(:));
maps_scaled=(maps-minall)/(maxall-minall);
montage(maps_scaled);





