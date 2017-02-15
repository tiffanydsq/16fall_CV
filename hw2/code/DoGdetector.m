function [locsDoG, GaussianPyramid] = DoGdetector(im, sigma0, k, levels, th_contrast, th_r)

GaussianPyramid = createGaussianPyramid(im, sigma0, k, levels);
%displayPyramid(GaussianPyramid);
[DoGPyramid, DoGLevels] = createDoGPyramid(GaussianPyramid, levels);
%displayPyramid(DoGPyramid);
PrincipalCurvature = computePrincipalCurvature(DoGPyramid);
locsDoG = getLocalExtrema(DoGPyramid, DoGLevels, PrincipalCurvature,th_contrast, th_r);

end