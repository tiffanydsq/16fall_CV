function [ F ] = ransacF( pts1, pts2, M )
% ransacF:
%   pts1 - Nx2 matrix of (x,y) coordinates
%   pts2 - Nx2 matrix of (x,y) coordinates
%   M    - max (imwidth, imheight)

% Q2.X - Extra Credit:
%     Implement RANSAC
%     Generate a matrix F from some '../data/some_corresp_noisy.mat'
%          - using sevenpoint
%          - using ransac
nIter=100;
tols=3*1e-3;
inlierT=0.65*size(pts1,1);
Maxinlier=0;
% idxall=1:size(pts1,1);
npts1=pts1/M; % normalized
npts2=pts2/M;
% T=[1/M 0 0;0 1/M 0;0 0 1];
for i=1:nIter
    fprintf('Iteration No.%d\n',i);
    idxfit=randperm(size(npts1,1),7);

    randp1=npts1(idxfit,:);
    randp2=npts2(idxfit,:);

    cellF = sevenpoint( randp1, randp2, 1 );
    for j=1:size(cellF,1);
        F=cellF{j}; %T*cellF{j}{1}*T';

        el=F*[npts1,ones(size(npts1,1),1)]'; % epipolar line l'
        Dist=abs(sum([npts2,ones(size(npts1,1),1)].*el',2))./sqrt(el(1,:).^2+el(2,:).^2)';
        countinlier=sum(Dist<tols);
        idxinlier=Dist<tols;
        
        if countinlier>inlierT
            bestidxinlier=idxinlier;
            break;
        end
        
        if countinlier>Maxinlier
            Maxinlier=countinlier;
            %             bestF=F;
            bestidxinlier=idxinlier;
        end
    end
    
    if countinlier>inlierT
        bestidxinlier=idxinlier;
        break;
    end
end

F= eightpoint( pts1(bestidxinlier,:), pts2(bestidxinlier,:), M );

%     In your writeup, describe your algorith, how you determined which
%     points are inliers, and any other optimizations you made

end

