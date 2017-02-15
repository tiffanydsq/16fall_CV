function [u,v] = LucasKanadeInverseCompositional(It, It1, rect)

% input - image at time t, image at t+1, rectangle (top left, bot right coordinates)
% output - movement vector, [u,v] in the x- and y-directions.


%% Pre-compute
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

% Hessian
H=Isd'*Isd;

%% Iterate

motion=100;
% Warped Image I_t+1
while motion>1e-10
WX=gridX+p1;
WY=gridY+p2;
Iw=interp2(It1,WX,WY);

% Error image
E=Iw-T;

% Step 7
S7=Isd'*E(:);

% Compute deltaP
deltap=H\S7;

p1=p1-deltap(1);
p2=p2-deltap(2);
motion=deltap(1)^2+deltap(2)^2;
end

u=p1;
v=p2;




