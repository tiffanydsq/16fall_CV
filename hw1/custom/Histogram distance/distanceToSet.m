function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) ??? 1 / 3) ?? 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) ??? 1 / 3) ?? T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 ?? T vector

	% TODO Implement your code here
	%wordHistmatrix=repmat(wordHist,[1 size(histograms,2)]);
    %%i=1:size(histograms,2);
    %histInter=sum(min(wordHistmatrix,histograms));
    
    histInter=histogram_intersection(wordHist',histograms'); %0.575
    %histInter=chi_square_statistics(wordHist',histograms'); %0.5875
    % histInter=kolmogorov_smirnov_distance(wordHist',histograms'); %0.3125 %(10)0.0688
    % histInter=match_distance(wordHist',histograms'); %  0.3125
    
end