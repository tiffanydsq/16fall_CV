function [u,v] = LucasKanadeBasis(It, It1, rect, bases)

% input - image at time t, image at t+1, rectangle (top left, bot right
% coordinates), bases
% output - movement vector, [u,v] in the x- and y-directions.


%% Pre-compute
% basis prep
k=size(bases,3);
dpbases=zeros(size(bases));% dot product

p1=0;
p2=0;
rectX=rect(1):rect(3);
rectY=rect(2):rect(4);
[gridX,gridY]=meshgrid(rectX,rectY);
T=It(rectY,rectX);
% Gradient of T(X)
[gTX,gTY]=gradient(T);
% quiver(gTX,gTY)
% Jacobian
J=[1 0;0 1];
% Steepest descent images


[JX1,JX2]=meshgrid(J(1,:),gTX);
[JY1,JY2]=meshgrid(J(2,:),gTY);
Isd=JX1.*JX2+JY1.*JY2; % numP*2
Axterm=0;
    for i=1:k
        A=reshape(bases(:,:,i),[],1);
        Ayterm=repmat(A,1,2).*Isd;
        Axterm=Axterm+repmat(sum(Ayterm),size(A,1),1).*repmat(A,1,2);  
    end
Isdq=Isd-Axterm;
    
% Hessian
H=Isdq'*Isdq;


for i=1:k
    dpbases(:,:,i)=bases(:,:,i).*bases(:,:,i);
end

%% Iterate
motion=100;
% Warped Image I_t+1
%while motion>1e-10
for itr=1:50
    WX=gridX+p1;
    WY=gridY+p2;
    Iw=interp2(It1,WX,WY);
    
    %% Error image with basis
    %E=Iw-T;
    deltaI=Iw-T;
    W=zeros(k);
    curbases=zeros(size(T));
    for i=1:k
        t1=deltaI.*bases(:,:,i);
        t2=dpbases(:,:,i);
        weight=sum(t1(:))/sum(t2(:));
        temp=bases(:,:,i).*deltaI;
        lambda=sum(temp(:));
        curbases=curbases+weight*bases(:,:,i);  
    end
    E=deltaI-curbases;
    
    %{
% Diffmap=repmat(Diff,1,1,size(bases,3));
for dim3=1:size(bases,3)
%  weightmap(:,:,dim3)=bases(:,:,dim3)'*inv(bases(:,:,dim3)*bases(:,:,dim3)');
%  basesterm=bases(:,:,dim3)/(bases(:,:,dim3)*bases(:,:,dim3)');
% A=bases(:,:,dim3)*bases(:,:,dim3)';
% b=
% [U,S,V]=svd(A);
weightlist(:,:,dim3)=(Diff*bases(:,:,dim3)')./(bases(:,:,dim3)*bases(:,:,dim3)');

% basesterm=bases(:,:,dim3)/(bases(:,:,dim3)'*bases(:,:,dim3));
%  weightmap(:,:,dim3)=Diff.*basesterm; % 4755= 4755 4755
end
% weight=Diffmap*weightmap;
baseterm=sum(weightmap.*bases,3);
E=Iw-T-baseterm;
    %}
    
    % Step 7
    S7=Isd'*E(:);
    % delta p
    deltap=H\S7;
    % svd
    % eig()
    p1=p1-deltap(1);
    p2=p2-deltap(2);
    motion=deltap(1)^2+deltap(2)^2;
end

u=p1;
v=p2;
