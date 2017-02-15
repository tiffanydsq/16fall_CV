function [compareA, compareB] = makeTestPattern(patchWidth, nbits)  
% input
% patchWidth - the width of the image patch (usually 9)
% nbits - the number of tests n in the BRIEF descriptor
% output
% compareA and compareB - linear indices into the patchWidth x patchWidth image patch and are each nbits x 1 vectors. 
%
% Run this routine for the given parameters patchWidth = 9 and n = 256 and save the results in testPattern.mat.

sigma=patchWidth/5;%81/25;
mu=0;

Ax=normrnd(mu,sigma,1,nbits);
Ay=normrnd(mu,sigma,1,nbits);
ranA=round((Ax+patchWidth/2)*patchWidth+(Ay+patchWidth/2));
maxA=patchWidth*patchWidth*ones(1,nbits);
minA=ones(1,nbits);
compareA0=min(ranA,maxA);
compareA=max(compareA0,minA);

Bx=normrnd(mu,sigma,1,nbits);
By=normrnd(mu,sigma,1,nbits);
ranB=round((Bx+patchWidth/2)*patchWidth+(By+patchWidth/2));
maxB=patchWidth*patchWidth*ones(1,nbits);
minB=ones(1,nbits);
compareB0=min(ranB,maxB);
compareB=max(compareB0,minB);

end







