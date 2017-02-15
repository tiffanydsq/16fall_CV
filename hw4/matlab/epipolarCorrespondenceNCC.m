function [ x2, y2 ] = epipolarCorrespondenceNCC( im1, im2, F, x1, y1 )
% epipolarCorrespondence:
%       im1 - Image 1
%       im2 - Image 2
%       F - Fundamental Matrix between im1 and im2
%       x1 - x coord in image 1
%       y1 - y coord in image 1

% Q2.6 - Todo:
%           Implement a method to compute (x2,y2) given (x1,y1)
%           Use F to only scan along the epipolar line

%           Experiment with different window sizes or weighting schemes
%           Save F, pts1, and pts2 used to generate view to q2_6.mat
%
%           Explain your methods and optimization in your writeup
range=40;
wsize=5;
% mask=fspecial('disk',5);
% mask=fspecial('gaussian',[2*wsize+1 2*wsize+1],9);
im1=double(rgb2gray(im1));
im2=double(rgb2gray(im2));

x=x1;   
y=y1;
% l2=[x y 1]*F;
l2=F*[x y 1]';
a=l2(1);
b=l2(2);
c=l2(3);
[X,Y]=meshgrid(x-wsize:x+wsize,y-wsize:y+wsize);
win1=interp2(im1,X,Y);

% initialization
% dist=1e10; 
cor=-1e10;
for yy2=max(wsize,y1-range):min(size(im1,1)-1,y1+range)
    xx2=min(max(wsize,(-b*yy2-c)/a),size(im2,2)-1); % restrict
    x=xx2; %2:size(im1,2)-1 %x
    y=yy2;  
%     test=l2*[x y 1]'
    [X,Y]=meshgrid(x-wsize:x+wsize,y-wsize:y+wsize);
    win2=interp2(im2,X,Y);

%% NCC
 
    corall=(win1-mean(win1(:))).*(win2+mean(win2(:)));
    cortest=mean(corall(:))/std2(win1)/std2(win2);
    if cortest>cor
        cor=cortest;
        x2=xx2; 
        y2=yy2;
    end


%% SSD
%{
    sqrdist=(win1-mean(win1(:))-win2+mean(win2(:))).^2*mask;
    if sum(sqrdist(:))<dist
        dist=sum(sqrdist(:));
        x2=xx2;  %x1() %
        y2=yy2;
    end
%}
end

end


