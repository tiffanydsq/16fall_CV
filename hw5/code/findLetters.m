function [lines, bw] = findLetters(im)
% [lines, BW] = findLetters(im) processes the input RGB image and returns a cell
% array 'lines' of located characters in the image, as well as a binary
% representation of the input image. The cell array 'lines' should contain one
% matrix entry for each line of text that appears in the image. Each matrix entry
% should have size Lx4, where L represents the number of letters in that line.
% Each row of the matrix should contain 4 numbers [x1, y1, x2, y2] representing
% the top-left and bottom-right position of each box. The boxes in one line should
% be sorted by x1 value.

im=im2double(rgb2gray(im));

% RGB to Binary image
% Use Vally Value of Histogram to get Adaptive Threshold 
[counts,x]=imhist(im,20);
[pks,locs]=findpeaks(-counts,'NPeaks',1);
[~,idx]=max(-pks);
thr=x(locs(idx));

bw=im2bw(im,thr);
se=strel('disk',5);
bw=imerode(bw,se);
% se=strel('disk',2);
% bw=imdilate(bw,se);

% Find bwconncomp
bw=~bw;
CC=bwconncomp(bw);
rcount=0;
for i=1:size(CC.PixelIdxList,2)
    indlist=CC.PixelIdxList{i};
    if size(indlist,1)>(size(im,1)*size(im,2)/8000);
        [Y,X]=ind2sub(CC.ImageSize,indlist);
        x1=min(X);
        y1=min(Y);
        x2=max(X);
        y2=max(Y);
        rcount=rcount+1;
        Pc(rcount,1)=(x1+x2)/2;
        Pc(rcount,2)=(y1+y2)/2;
        rectlist(rcount,:)=[x1 y1 x2 y2];
    end
end

% Aw=mean(rectlist(:,3)-rectlist(:,1));
Ah=mean(rectlist(:,4)-rectlist(:,2)); % Average height of letters
[Pc,Idx]=sortrows(Pc,2);
rectlist=rectlist(Idx,:);
for i=2:size(Pc,1)
    if (Pc(i,2)-Pc(i-1,2))<1.2*Ah
        Pc(i,2)=Pc(i-1,2);
    end
end
[Pc,Idx]=sortrows(Pc,[2 1]);
rectlist=rectlist(Idx,:);
l=1;
j=1;
lines{1}(1,:)=rectlist(1,:);
for i=2:size(rectlist,1)
    if Pc(i,2)==Pc(i-1,2)
        j=j+1;
        lines{l}(j,:)=rectlist(i,:);
    else
        j=1;
        l=l+1;
        lines{l}(1,:)=rectlist(i,:);
    end
%     w=rectlist(i,3)-rectlist(i,1);
%     h=rectlist(i,4)-rectlist(i,2);
%     rectangle('Position',[rectlist(i,1:2) w h]);
end

% Visualize line-by-line
% for i=1:size(lines,2)
%     for j=1:size(lines{i},1)
%         x1=lines{i}(j,1);
%         y1=lines{i}(j,2);
%         x2=lines{i}(j,3);
%         y2=lines{i}(j,4);
%         w=x2-x1;
%         h=y2-y1;
%         rectangle('Position',[x1 y1 w h]);
%     end
% end
bw=~bw;
end
