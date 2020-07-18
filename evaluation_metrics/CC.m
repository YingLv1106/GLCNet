function score = CC(saliencyMap1, saliencyMap2)
% saliencyMap1 and saliencyMap2 are 2 real-valued matrices   0-1  相似度越大 值越高
%  plcc pearson linear correlation coefficient

map1 = im2double(imresize(saliencyMap1, size(saliencyMap2)));
map2 = im2double(saliencyMap2);

% normalize both maps
map1 = (map1 - mean(map1(:))) / std(map1(:)); 
map2 = (map2 - mean(map2(:))) / std(map2(:)); 

score = corr2(map2, map1);