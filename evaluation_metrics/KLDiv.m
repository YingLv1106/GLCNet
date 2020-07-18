
% created: Zoya Bylinskii, Aug 2014  kl散度估计
% 注视点位置的视觉显著性度量直方图与随机位置的视觉显著性度量直方图间的散度   越高越好！

% This finds the KL-divergence between two different saliency maps when
% viewed as distributions: it is a non-symmetric measure of the information 
% lost when saliencyMap is used to estimate fixationMap.


function score = KLDiv(saliencyMap, fixationMap)
% saliencyMap is the saliency map
% fixationMap is the human fixation map

map1 = im2double(imresize(saliencyMap, size(fixationMap)));
map2 = im2double(fixationMap);

% make sure map1 and map2 sum to 1
if any(map1(:))
    map1 = map1/sum(map1(:));
end

if any(map2(:))
    map2 = map2/sum(map2(:));
end

% compute KL-divergence
score = sum(sum(map2 .* log(eps + map2./(map1+eps))));