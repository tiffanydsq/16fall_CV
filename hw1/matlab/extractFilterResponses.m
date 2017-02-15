function [filterResponses] = extractFilterResponses(img, filterBank)
% Extract filter responses for the given image.
% Inputs:
%   img:                a 3-channel RGB image with width W and height H
%   filterBank:         a cell array of N filters
% Outputs:
%   filterResponses:    a W*H x N*3 matrix of filter responses

% TODO Implement your code here
%[cidx fidx]=ndgrid(1:3,1:length(filterBank));
img=RGB2Lab(img);
Responses4D=zeros(size(img,1),size(img,2),size(img,3),length(filterBank));
for fidx=1:length(filterBank)
    cidx=1:3;
    %fidx=1:length(filterBank);
    f=filterBank{fidx};
    channel=img(:,:,cidx);
    rchannel=imfilter(channel,f,'conv');
    %cidx+3*(fidx-1)
    %filterResponses(:,:,cidx+3*(fidx-1))=rchannel;
    Responses4D(:,:,cidx,fidx)=rchannel;
    filterResponses=reshape(Responses4D,[size(img,1)*size(img,2),size(img,3)*length(filterBank)]);
end
%figure
%montage(Responses4D,'Size',[4 5]);
end
