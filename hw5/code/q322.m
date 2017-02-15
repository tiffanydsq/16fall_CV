clear variables
close all
clc

classes = 36;
layers = [32*32, 800, classes];

load nist36_initial.mat
W0=W;
b0=b;
figure(1)
for i=1:size(W0{1},1)
    maps0(:,:,1,i)=reshape(W0{1}(i,:),[32 32]);
end
maxall0=max(maps0(:));
minall0=min(maps0(:));
maps_scaled0=(maps0-minall0)/(maxall0-minall0);
montage(maps_scaled0);

% After
load nist36_model.mat;
figure(2)
Weight=W{1};
for i=1:size(Weight,1)
    maps(:,:,1,i)=reshape(Weight(i,:),[32 32]);
    %mapminmax
end
maxall=max(maps(:));
minall=min(maps(:));
maps_scaled=(maps-minall)/(maxall-minall);
montage(maps_scaled);





