clear variables
close all 
clc

im1=imread('../images/01_list.jpg');
[lines1, bw1] = findLetters(im1);
lines=lines1;
figure(1)
imshow(im1);
for i=1:size(lines,2)
    for j=1:size(lines{i},1)
        x1=lines{i}(j,1);
        y1=lines{i}(j,2);
        x2=lines{i}(j,3);
        y2=lines{i}(j,4);
        w=x2-x1;
        h=y2-y1;
        rectangle('Position',[x1 y1 w h],'EdgeColor',[1 0 0]);
    end
end

im2=imread('../images/02_letters.jpg');
[lines2, bw2] = findLetters(im2);
lines=lines2;
figure(2)
imshow(im2);
for i=1:size(lines,2)
    for j=1:size(lines{i},1)
        x1=lines{i}(j,1);
        y1=lines{i}(j,2);
        x2=lines{i}(j,3);
        y2=lines{i}(j,4);
        w=x2-x1;
        h=y2-y1;
        rectangle('Position',[x1 y1 w h],'EdgeColor',[1 0 0]);
    end
end

im3=imread('../images/03_haiku.jpg');
[lines3, bw3] = findLetters(im3);
figure(3)
lines=lines3;
imshow(im3);
for i=1:size(lines,2)
    for j=1:size(lines{i},1)
        x1=lines{i}(j,1);
        y1=lines{i}(j,2);
        x2=lines{i}(j,3);
        y2=lines{i}(j,4);
        w=x2-x1;
        h=y2-y1;
        rectangle('Position',[x1 y1 w h],'EdgeColor',[1 0 0]);
    end
end

im4=imread('../images/04_deep.jpg');
[lines4, bw4] = findLetters(im4);
figure(4)
lines=lines4;
imshow(im4);
for i=1:size(lines,2)
    for j=1:size(lines{i},1)
        x1=lines{i}(j,1);
        y1=lines{i}(j,2);
        x2=lines{i}(j,3);
        y2=lines{i}(j,4);
        w=x2-x1;
        h=y2-y1;
        rectangle('Position',[x1 y1 w h],'EdgeColor',[1 0 0]);
    end
end

