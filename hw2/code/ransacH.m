function [bestH] = ransacH(matches, locs1, locs2, nIter, tol)
% input
% locs1 and locs2 - matrices specifying point locations in each of the images
% matches - matrix specifying matches between these two sets of point locations
% nIter - number of iterations to run RANSAC
% tol - tolerance value for considering a point to be an inlier
% output
% bestH - homography model with the most inliers found during RANSAC

inlierT=floor(size(matches,1)*0.5);
Maxinlier=0;
idxall=1:size(matches,1);
for i=1:nIter
    tic
    %if ranflag==1
    idxran=randperm(size(matches,1),4);
    idxfit=idxran;
    %else
    
    %         idxfit=countinlier;
    %         nIter=nIter-1
    %     end
    
    % Build model
    p1(1,:)=locs1(matches(idxfit,1)',1);
    p1(2,:)=locs1(matches(idxfit,1)',2);
    p1(3,:)=1;
    p2(1,:)=locs2(matches(idxfit,2)',1);
    p2(2,:)=locs2(matches(idxfit,2)',2);
    p2(3,:)=1;
    H2to1=computeH(p1,p2); % p1=H*p2;
    
    % test on the rest to find inliers
    %     clear p1rest
    %     clear p2rest
    %     clear p1compute
    
    idxrest=idxall;
    idxrest(idxfit)=[];
    %assert(length(idxrest)==(length(idxall)-4));
    p1rest(1,:)=locs1(matches(idxrest,1)',1);
    p1rest(2,:)=locs1(matches(idxrest,1)',2);
    p1rest(3,:)=1;
    p2rest(1,:)=locs2(matches(idxrest,2)',1);
    p2rest(2,:)=locs2(matches(idxrest,2)',2);
    p2rest(3,:)=1;
    p1compute=H2to1*p2rest; % p1=H*p2;
    for k=1:size(p1compute,2);
        p1compute(:,k)=p1compute(:,k)./p1compute(3,k);
    end
    countinlier=0;
    
    for idx=1:length(idxrest)
        dis=pdist2(p1compute(1:2,idx)',p1rest(1:2,idx)');
        if dis<tol
            countinlier=countinlier+1;
            idxinlier(countinlier)=idx;
        end
    end
    
    if countinlier>inlierT
        break
    end
    toc
    
    if countinlier>Maxinlier
        Maxinlier=countinlier;
        bestH=H2to1;
    end
end

% Finial refine
%{
idxfit=idxinlier;
p1f(1,:)=locs1(matches(idxfit,1)',1);
p1f(2,:)=locs1(matches(idxfit,1)',2);
p1f(3,:)=1;
p2f(1,:)=locs2(matches(idxfit,2)',1);
p2f(2,:)=locs2(matches(idxfit,2)',2);
p2f(3,:)=1;

bestH=computeH(p1f,p2f); % p1=H*p2;
%}

end