function mask = SubtractDominantMotion(image1, image2)

% input - image1 and image2 form the input image pair
% output - mask is a binary image of the same size

M = LucasKanadeAffine(image1, image2);

rangex=size(image1,2);
rangey=size(image1,1);

rectX=1:rangex;
rectY=1:rangey;
[gridX,gridY]=meshgrid(rectX,rectY);
Post=[gridX(:),gridY(:),ones(size(gridX(:)))]';
Post1=M*Post; 
WX=reshape(Post1(1,:),rangey,rangex);
WY=reshape(Post1(2,:),rangey,rangex);
Cropmask=(WX>=0&WX<=rangex)&(WY>=0&WY<=rangey);
CropedWX=Cropmask.*WX;
CropedWY=Cropmask.*WY;
Iw=interp2(image2,CropedWX,CropedWY);
Iw(isnan(Iw))=0;
Dis=(image1 - Iw).*(image1 - Iw);
MaxDis=max(max(Dis)); 
% SortedDis=sort(Dis(:));
% Threshold=SortedDis(round(length(Dis(:))*0.97));
mask=(image1 - Iw).*(image1 - Iw)>MaxDis*0.01;


