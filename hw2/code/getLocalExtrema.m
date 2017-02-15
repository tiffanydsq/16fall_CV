function locs = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r)
%%Detecting Extrema
% inputs
% DoG Pyramid - size (size(im), numel(levels) - 1) matrix of the DoG pyramid
% DoG Levels
% PrincipalCurvature - size (size(im), numel(levels) - 1) matrix contains the curvature ratio R
% th_contrast - remove any point that is a local extremum but does not have a DoG response magnitude above this threshold
% th_r - remove any edge-like points that have too large a principal curvature ratio
% output
% locs - N x 3 matrix where the DoG pyramid achieves a local extrema in both scale and space, and also satisfies the two thresholds.
countN=0;
for l=2:size(DoGPyramid,3)-1
    for r=2:size(DoGPyramid,1)-1
        for c=2:size(DoGPyramid,2)-1
            if (abs(DoGPyramid(r,c,l))>th_contrast) && (PrincipalCurvature(r,c,l)<th_r)
                Max=max(max(max(DoGPyramid(r-1:r+1,c-1:c+1,l))),max(DoGPyramid(r,c,l-1:l+1)));
                Min=min(min(min(DoGPyramid(r-1:r+1,c-1:c+1,l))),min(DoGPyramid(r,c,l-1:l+1))); 
                if ((DoGPyramid(r,c,l)==Max)||(DoGPyramid(r,c,l)==Min))
                    countN=countN+1;    
                    locs(countN,1)=c;
                    locs(countN,2)=r;
                    locs(countN,3)=DoGLevels(l);
                end
            end
        end
    end
end

                    
                        
    
