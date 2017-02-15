function histInter = distanceToSet(wordHist, histograms)
% Compute distance between a histogram of visual words with all training image histograms.
% Inputs:
% 	wordHist: visual word histogram - K * (4^(L+1) ??? 1 / 3) ?? 1 vector
% 	histograms: matrix containing T features from T training images - K * (4^(L+1) ??? 1 / 3) ?? T matrix
% Output:
% 	histInter: histogram intersection similarity between wordHist and each training sample as a 1 ?? T vector

	% TODO Implement your code here
	wordHistmatrix=repmat(wordHist',[1 size(histograms,2)]);
    %i=1:size(histograms,2);
    histInter=sum(min(wordHistmatrix,histograms));
end