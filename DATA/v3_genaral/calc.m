
name = 'calc';
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


calc_mean1 = mean(calc_f_mag_norm1,1);
calc_mean2 = mean(calc_f_mag_norm2,1);
calc_mean3 = mean(calc_f_mag_norm3,1);
calc_mean4 = mean(calc_f_mag_norm4,1);
calc_mean5 = mean(calc_f_mag_norm5,1);

calc_var1 = var(calc_f_mag_norm1,1);
calc_var2 = var(calc_f_mag_norm2,1);
calc_var3 = var(calc_f_mag_norm3,1);
calc_var4 = var(calc_f_mag_norm4,1);
calc_var5 = var(calc_f_mag_norm5,1);

calc_together_mean = [calc_mean1;calc_mean2;calc_mean3;calc_mean4;calc_mean5];
calc_total_mean = mean(calc_together_mean,1);

calc_together_var = [calc_var1;calc_var2;calc_var3;calc_var4;calc_var5];
calc_total_var = var(calc_together_var,1);
