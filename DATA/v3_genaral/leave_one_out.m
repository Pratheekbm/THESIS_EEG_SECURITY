name = 'calc';
calc_f1(:,:) = get_features(strcat(name,'1.dat'));
calc_f2(:,:) = get_features(strcat(name,'2.dat'));
calc_f3(:,:) = get_features(strcat(name,'3.dat'));
calc_f4(:,:) = get_features(strcat(name,'4.dat'));
calc_f5(:,:) = get_features(strcat(name,'5.dat'));


% calc_f_mag1 = sqrt(sum(abs(calc_f1).^2,2));
% calc_f_mag2 = sqrt(sum(abs(calc_f2).^2,2));
% calc_f_mag3 = sqrt(sum(abs(calc_f3).^2,2));
% calc_f_mag4 = sqrt(sum(abs(calc_f4).^2,2));
% calc_f_mag5 = sqrt(sum(abs(calc_f5).^2,2));

calc_f_mag1 = 1;
calc_f_mag2 = 1;
calc_f_mag3 = 1;
calc_f_mag4 = 1;
calc_f_mag5 = 1;

calc_f_mag_norm1 = bsxfun(@rdivide, calc_f1, calc_f_mag1);
calc_f_mag_norm2 = bsxfun(@rdivide, calc_f2, calc_f_mag2);
calc_f_mag_norm3 = bsxfun(@rdivide, calc_f3, calc_f_mag3);
calc_f_mag_norm4 = bsxfun(@rdivide, calc_f4, calc_f_mag4);
calc_f_mag_norm5 = bsxfun(@rdivide, calc_f5, calc_f_mag5);

name = 'breath';
breath_f1(:,:) = get_features(strcat(name,'1.dat'));
breath_f2(:,:) = get_features(strcat(name,'2.dat'));
breath_f3(:,:) = get_features(strcat(name,'3.dat'));
breath_f4(:,:) = get_features(strcat(name,'4.dat'));
breath_f5(:,:) = get_features(strcat(name,'5.dat'));


% breath_f_mag1 = sqrt(sum(abs(breath_f1).^2,2));
% breath_f_mag2 = sqrt(sum(abs(breath_f2).^2,2));
% breath_f_mag3 = sqrt(sum(abs(breath_f3).^2,2));
% breath_f_mag4 = sqrt(sum(abs(breath_f4).^2,2));
% breath_f_mag5 = sqrt(sum(abs(breath_f5).^2,2));

breath_f_mag1 = 1;
breath_f_mag2 = 1;
breath_f_mag3 = 1;
breath_f_mag4 = 1;
breath_f_mag5 = 1;

breath_f_mag_norm1 = bsxfun(@rdivide, breath_f1, breath_f_mag1);
breath_f_mag_norm2 = bsxfun(@rdivide, breath_f2, breath_f_mag2);
breath_f_mag_norm3 = bsxfun(@rdivide, breath_f3, breath_f_mag3);
breath_f_mag_norm4 = bsxfun(@rdivide, breath_f4, breath_f_mag4);
breath_f_mag_norm5 = bsxfun(@rdivide, breath_f5, breath_f_mag5);


cal_full = [calc_f_mag_norm1;calc_f_mag_norm2;calc_f_mag_norm3;calc_f_mag_norm4;calc_f_mag_norm5];
breath_full = [breath_f_mag_norm1;breath_f_mag_norm2;breath_f_mag_norm3;breath_f_mag_norm4;breath_f_mag_norm5];

for i = 1:size(cal_full,1)
    if i == size(cal_full,1)
        cal_rest = cal_full(1:i-1,:);
        breath_rest = breath_full(1:i-1,:);
    else
        cal_rest = cal_full([1:i-1,i+1:end],:);
        breath_rest = breath_full([1:i-1,i+1:end],:);
    end
    
    cal_mean = mean(cal_rest,1);
    breath_mean = mean(breath_rest,1);
    cal_k_inv = inv(cov(cal_rest));
    breath_k_inv = inv(cov(breath_rest));
    
    maha_c_c = (cal_full(i,:) - cal_mean) * cal_k_inv * (cal_full(i,:) - cal_mean)';
    maha_c_b = (cal_full(i,:) - breath_mean) * breath_k_inv * (cal_full(i,:) - breath_mean)';
    if(maha_c_c <= maha_c_b)
        c_out(i) = 1;
    else
        c_out(i) = 0;
    end
    
	maha_b_c = (breath_full(i,:) - cal_mean) * cal_k_inv * (breath_full(i,:) - cal_mean)';
    maha_b_b = (breath_full(i,:) - breath_mean) * breath_k_inv * (breath_full(i,:) - breath_mean)';
    if(maha_b_b <= maha_b_c)
        b_out(i) = 1;
    else
        b_out(i) = 0;
    end
end
c = 100 * sum(c_out) / 50.0
b = 100 * sum(b_out) / 50.0
