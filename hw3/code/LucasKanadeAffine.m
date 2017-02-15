function M = LucasKanadeAffine(It, It1)

% input - image at time t, image at t+1 
% output - M affine transformation matrix


%% Pre-compute
M=eye(3);
T=It;
rangex=size(It,2);
rangey=size(It,1);

rectX=1:rangex;
rectY=1:rangey;
[gridX,gridY]=meshgrid(rectX,rectY);
Post=[gridX(:),gridY(:),ones(size(gridX(:)))]';

% Gradient of T(X)
[gTX,gTY]=gradient(T);

% quiver(gTX,gTY) 
% Jacobian
%  J=[1 0;0 1];
JX=[gridX(:),zeros(size(gridX(:))),gridY(:),zeros(size(gridX(:))),ones(size(gridX(:))),zeros(size(gridX(:)))];
JY=[zeros(size(gridX(:))),gridX(:),zeros(size(gridX(:))),gridY(:),zeros(size(gridX(:))),ones(size(gridX(:)))];

% Isd=[rectX(:),rectX(:),gTY(:),gTY(:),ones(size(gTY(:))),ones(size(gTY(:)))];

% Steepest descent images
 % numPixel*2
Isd=repmat(gTX(:),1,6).*JX+repmat(gTY(:),1,6).*JY;
% Isd2(1,:)=gTX(:)'*JX;
% Isd2(2,:)=gTY(:)'*JY;
% Isdgt=0;
% for x=rectX
%     for y=rectY
%         J=[x 0 y 0 1 0; 0 x 0 y 0 1];
%         Isdgt=Isdgt+[gTX(y,x) gTY(y,x)]*J; 
%     end
% end

% Hessian
H=Isd'*Isd;
% H2=Isd2'*Isd2;
%     [U,S,V]=svd(H);
%     IS=zeros(size(S));
%     IS(S>0.01)=1./S(S>0.01);
%     Hi=V*IS'*U'
    
% Hgt=Isdgt'*Isdgt;
% H=Hgt;

maxIteration=50;
%% Iterate
motion=100;
% Warped Image I_t+1
while motion>1e-10 && maxIteration
    maxIteration=maxIteration-1;
% WX=gridX+p1;
% WY=gridY+p2;
Post1=M*Post;
WX=reshape(Post1(1,:),rangey,rangex);
WY=reshape(Post1(2,:),rangey,rangex);
Cropmask=(WX>=0&WX<=rangex)&(WY>=0&WY<=rangey);
CropedWX=Cropmask.*WX;
CropedWY=Cropmask.*WY;
Iw=interp2(It1,CropedWX,CropedWY);
  %  Iw2 = interp2(gridX, gridY, It1, CropedWX, CropedWY);
Iw(isnan(Iw))=0;

% Error image
E=Cropmask.*(Iw-T);

% Step 7
% S7=Isd'*E(:);
S7=gTX(:)'.*E(:)'*JX+gTY(:)'.*E(:)'*JY;
% S7gt=0;
% for x=rectX
%     for y=rectY
%         J=[x 0 y 0 1 0; 0 x 0 y 0 1];
%         S7gt=S7gt+[gTX(y,x) gTY(y,x)]*J*E(y,x); 
%     end
% end

% Compute deltaP
deltap=H\S7';

M(1,1)=M(1,1)-deltap(1);
M(1,2)=M(1,2)-deltap(3);
M(1,3)=M(1,3)-deltap(5);
M(2,1)=M(2,1)-deltap(2);
M(2,2)=M(2,2)-deltap(4);
M(2,3)=M(2,3)-deltap(6);

motion=sum(deltap.^2);
end



