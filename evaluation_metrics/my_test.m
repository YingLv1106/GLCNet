clear;
clc;

pathname_Left_view='/home/.../NCTU_L_test/';
pathname_Fixation_Density_Maps='/home/.../NCTU_test_label/';

img_load_ol=['/home/.../NCTU_L_test/*.bmp'];

img_load_fix=['/home/.../NCTU_test_label/*.bmp'];
pathname_saliency='/home/.../predict/';

img_load_sa=['/home/.../predict/*.bmp'];

leftview_name=dir(img_load_ol);
fixview_name=dir(img_load_fix);
%sort(fixview_name.name);
fixview_name.name;
saview_name=dir(img_load_sa);
%sort(saview_name.name);
saview_name.name;

im_list = dir(strcat(pathname_Left_view, '*.bmp'));
im_num = length(im_list);

tic
for i = 1:im_num 
    i
    new_ours_smap = imread(strcat(pathname_saliency,saview_name(i).name));
    new_user_data = imread(strcat(pathname_Fixation_Density_Maps,fixview_name(i).name));
    new_ours_smap = im2double(new_ours_smap);
    new_user_data = im2double(new_user_data);
    level=graythresh(new_user_data);
    binary_user_data=im2bw(new_user_data, level);
    
    PLCC_KLD_NSS(i,1)=CC(new_ours_smap,new_user_data);
    PLCC_KLD_NSS(i,2)=KLDiv(new_ours_smap,new_user_data);
    PLCC_KLD_NSS(i,3)=AUC_Borji(new_ours_smap,binary_user_data);
    PLCC_KLD_NSS(i,4)=NSS(new_ours_smap, binary_user_data);
    

    [row col] = size(new_ours_smap);
    ours_array = zeros(row*col, 2);
    ours_array(:, 1) = new_ours_smap(:);
    ours_array(:, 2) = binary_user_data(:);

end
PLCC_KLD_NSS(19,1)=mean(PLCC_KLD_NSS(1:im_num,1));
PLCC_KLD_NSS(19,2)=mean(PLCC_KLD_NSS(1:im_num,2));
PLCC_KLD_NSS(19,3)=mean(PLCC_KLD_NSS(1:im_num,3));
PLCC_KLD_NSS(19,4)=mean(PLCC_KLD_NSS(1:im_num,4));

PLCC_KLD_NSS(19,:)
