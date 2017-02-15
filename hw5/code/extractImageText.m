function [text] = extractImageText(fname)
% [text] = extractImageText(fname) loads the image specified by the path 'fname'
% and returns the next contained in the image as a string.

CharList='ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
load nist36_model_001.mat;
im=imread(fname);

[lines, bw] = findLetters(im);
imshow(bw);
Ccount=1;
for i=1:size(lines,2)
    for j=1:size(lines{i},1)
        x1=lines{i}(j,1);
        y1=lines{i}(j,2);
        x2=lines{i}(j,3);
        y2=lines{i}(j,4);
        imC=bw(y1:y2,x1:x2);
%         imshow(imC);
        
        % Padding
        imC=~imC;
        
        [h w]=size(imC);
        if h>w
        imC = padarray(imC,[5 round((h-w)/2)+5]);
        elseif h<w
                   imC = padarray(imC,[round((w-h)/2) 0]);
        end
         imC=~imC;
        imC=imresize(imC,[32 32]);
%         imshow(imC);

        test_data(Ccount,:)=imC(:);
        Ccount=Ccount+1;
    end
end
outputs = Classify(W, b, test_data);
% cfmatrix=zeros(size(test_labels,2));
for i=1:size(outputs,1)
%     gt=find(test_labels(i,:));
    pred=find(outputs(i,:)==max(outputs(i,:)));
    text(i)=CharList(pred);
%     cfmatrix(gt,pred)=cfmatrix(gt,pred)+1;
end

% text=0;
end
