
name = '/Users/pbm/Google Drive/THESIS/DATA/People_data/keith/calc_';
calc_f1(:,:) = get_features(strcat(name,'1.dat'));
calc_f2(:,:) = get_features(strcat(name,'2.dat'));
calc_f3(:,:) = get_features(strcat(name,'3.dat'));
calc_f4(:,:) = get_features(strcat(name,'4.dat'));
calc_f5(:,:) = get_features(strcat(name,'5.dat'));

calc_f_mag1 = sqrt(sum(abs(calc_f1).^2,2));
calc_f_mag2 = sqrt(sum(abs(calc_f2).^2,2));
calc_f_mag3 = sqrt(sum(abs(calc_f3).^2,2));
calc_f_mag4 = sqrt(sum(abs(calc_f4).^2,2));
calc_f_mag5 = sqrt(sum(abs(calc_f5).^2,2));

calc_f_mag_norm1 = bsxfun(@rdivide, calc_f1, calc_f_mag1);
calc_f_mag_norm2 = bsxfun(@rdivide, calc_f2, calc_f_mag2);
calc_f_mag_norm3 = bsxfun(@rdivide, calc_f3, calc_f_mag3);
calc_f_mag_norm4 = bsxfun(@rdivide, calc_f4, calc_f_mag4);
calc_f_mag_norm5 = bsxfun(@rdivide, calc_f5, calc_f_mag5);

cal_train = [calc_f_mag_norm1;calc_f_mag_norm2;calc_f_mag_norm3;calc_f_mag_norm4];
cal_full = [calc_f_mag_norm5];

calc_full_mean = mean(cal_train,1);
cal_k_inv = inv(cov(cal_train));
cal_k_det = det(cov(cal_train));

for i = 1:size(cal_full,1)
    maha_dist_calc(i) =  (cal_full(i,:) - calc_full_mean) * cal_k_inv * (cal_full(i,:) - calc_full_mean)';
    prob(i) = (1/((2 * pi)^4 * (cal_k_det)^0.5)) * exp(-1 * maha_dist_calc(i) / 2);
end
maha_dist_calc'
prob'