clc
clear variables
close all

thrDis=2;
numTrue=zeros(1,36);
im1=im2double(imread('../data/model_chickenbroth.jpg'));
if size(im1,3)~=1
    im1=rgb2gray(im1);
end

originr1=size(im1,1)/2;
originc1=size(im1,2)/2;

for rot=1:36
    tic
    % Rotate to get im2
    theta(rot)=10*rot;
    PI=3.14159;
    degree=theta(rot)/180*PI;
    R=[cos(degree) -sin(degree); sin(degree) cos(degree)];
    im2=imrotate(im1,theta(rot));

    if size(im2,3)~=1
        im2=rgb2gray(im2);
    end
    originr2=size(im2,1)/2;
    originc2=size(im2,2)/2;
    
    % BRIEF
    [locs1, desc1] = briefLite(im1);
    [locs2, desc2] = briefLite(im2);
    
    matches=briefMatch(desc1, desc2);
    
    count=0;
    Tmatches=0; % Initial
    
    p1=locs1(matches(:,1),1:2); %x
    pc1=p1(:,1);
    pr1=p1(:,2);
    
    p2=locs2(matches(:,2),1:2); %x

    pc2=p2(:,1);
    pr2=p2(:,2);
    
    x1=pc1-originc1; %x
    y1=originr1-pr1; %y
    x12=R(1,:)*[x1 y1]';
    y12=R(2,:)*[x1 y1]';
    x2=pc2-originc2;
    y2=originr2-pr2;
    
    dx=x2-x12';
    dy=y2-y12';
    Tidx=((dx.^2+dy.^2)<=thrDis.^2);
    Tmatches=matches(Tidx,:);
    
    if Tmatches~=0
        %plotMatches(im1, im2, Tmatches, locs1, locs2);
        numTrue(rot)=size(Tmatches,1);
    end
    toc
end

bar(theta,numTrue);
axis([0 370 0 max(numTrue)+10]);
xlabel('Degree of Rotation');
ylabel('Number of Correct Matches');
