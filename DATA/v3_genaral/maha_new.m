clear;clc;
name = '/Users/pbm/Google Drive/THESIS/DATA/People_data/shreyash/calc_';
calc_f1(:,:) = get_features(strcat(name,'1.dat'));
calc_f2(:,:) = get_features(strcat(name,'2.dat'));
calc_f3(:,:) = get_features(strcat(name,'3.dat'));
calc_f4(:,:) = get_features(strcat(name,'4.dat'));
calc_f5(:,:) = get_features(strcat(name,'5.dat'));



name = '/Users/pbm/Google Drive/THESIS/DATA/People_data/keith/calc_';
breath_f1(:,:) = get_features(strcat(name,'1.dat'));
breath_f2(:,:) = get_features(strcat(name,'2.dat'));
breath_f3(:,:) = get_features(strcat(name,'3.dat'));
breath_f4(:,:) = get_features(strcat(name,'4.dat'));
breath_f5(:,:) = get_features(strcat(name,'5.dat'));


cal_full = [calc_f1;calc_f2;calc_f3;calc_f4;calc_f5];
breath_full = [breath_f1;breath_f2;breath_f3;breath_f4;breath_f5];

mu = mean(cal_full);
cal_full = bsxfun(@minus, cal_full, mu);

sigma = std(cal_full);
cal_full = bsxfun(@rdivide, cal_full, sigma);

mu = mean(breath_full);
breath_full = bsxfun(@minus, breath_full, mu);

sigma = std(breath_full);
breath_full = bsxfun(@rdivide, breath_full, sigma);

calc_full_mean = mean(cal_full,1);
breath_full_mean = mean(breath_full,1);

cal_k_inv = inv(cov(cal_full));
breath_k_inv = inv(cov(breath_full));


for i = 1:size(cal_full,1)
    maha_dist_calc(i,1) =  (cal_full(i,:) - calc_full_mean) * cal_k_inv * (cal_full(i,:) - calc_full_mean)';
    maha_dist_calc(i,2) =  (cal_full(i,:) - breath_full_mean) * breath_k_inv * (cal_full(i,:) - breath_full_mean)';

    maha_dist_breath(i,1) =  (breath_full(i,:) - calc_full_mean) * cal_k_inv * (breath_full(i,:) - calc_full_mean)';
    maha_dist_breath(i,2) =  (breath_full(i,:) - breath_full_mean) * breath_k_inv * (breath_full(i,:) - breath_full_mean)';

    if maha_dist_calc(i,1) <= maha_dist_calc(i,2)
        maha_dist_calc(i,3) = 1;
    else
        maha_dist_calc(i,3) = 0;
    end


    if maha_dist_breath(i,2) <= maha_dist_breath(i,1)
        maha_dist_breath(i,3) = 1;
    else
        maha_dist_breath(i,3) = 0;
    end
end
maha_dist_calc
maha_dist_breath
c = sum(maha_dist_calc(:,3)) / 50.0
b = sum(maha_dist_breath(:,3)) / 50.0



