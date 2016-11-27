
name = 'med';
med_f1(:,:) = get_features(strcat(name,'1.dat'));
med_f2(:,:) = get_features(strcat(name,'2.dat'));
med_f3(:,:) = get_features(strcat(name,'3.dat'));
med_f4(:,:) = get_features(strcat(name,'4.dat'));
med_f5(:,:) = get_features(strcat(name,'5.dat'));


med_f_mag1 = sqrt(sum(abs(med_f1).^2,2));
med_f_mag2 = sqrt(sum(abs(med_f2).^2,2));
med_f_mag3 = sqrt(sum(abs(med_f3).^2,2));
med_f_mag4 = sqrt(sum(abs(med_f4).^2,2));
med_f_mag5 = sqrt(sum(abs(med_f5).^2,2));

med_f_mag_norm1 = bsxfun(@rdivide, med_f1, med_f_mag1);
med_f_mag_norm2 = bsxfun(@rdivide, med_f2, med_f_mag2);
med_f_mag_norm3 = bsxfun(@rdivide, med_f3, med_f_mag3);
med_f_mag_norm4 = bsxfun(@rdivide, med_f4, med_f_mag4);
med_f_mag_norm5 = bsxfun(@rdivide, med_f5, med_f_mag5);


med_mean1 = mean(med_f_mag_norm1,1);
med_mean2 = mean(med_f_mag_norm2,1);
med_mean3 = mean(med_f_mag_norm3,1);
med_mean4 = mean(med_f_mag_norm4,1);
med_mean5 = mean(med_f_mag_norm5,1);

med_var1 = var(med_f_mag_norm1,1);
med_var2 = var(med_f_mag_norm2,1);
med_var3 = var(med_f_mag_norm3,1);
med_var4 = var(med_f_mag_norm4,1);
med_var5 = var(med_f_mag_norm5,1);

med_together_mean = [med_mean1;med_mean2;med_mean3;med_mean4;med_mean5];
med_total_mean = mean(med_together_mean,1);

med_together_var = [med_var1;med_var2;med_var3;med_var4;med_var5];
med_total_var = var(med_together_var,1);
