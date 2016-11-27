
name = 'breath';
breath_f1(:,:) = get_features(strcat(name,'1.dat'));
breath_f2(:,:) = get_features(strcat(name,'2.dat'));
breath_f3(:,:) = get_features(strcat(name,'3.dat'));
breath_f4(:,:) = get_features(strcat(name,'4.dat'));
breath_f5(:,:) = get_features(strcat(name,'5.dat'));


breath_f_mag1 = sqrt(sum(abs(breath_f1).^2,2));
breath_f_mag2 = sqrt(sum(abs(breath_f2).^2,2));
breath_f_mag3 = sqrt(sum(abs(breath_f3).^2,2));
breath_f_mag4 = sqrt(sum(abs(breath_f4).^2,2));
breath_f_mag5 = sqrt(sum(abs(breath_f5).^2,2));

breath_f_mag_norm1 = bsxfun(@rdivide, breath_f1, breath_f_mag1);
breath_f_mag_norm2 = bsxfun(@rdivide, breath_f2, breath_f_mag2);
breath_f_mag_norm3 = bsxfun(@rdivide, breath_f3, breath_f_mag3);
breath_f_mag_norm4 = bsxfun(@rdivide, breath_f4, breath_f_mag4);
breath_f_mag_norm5 = bsxfun(@rdivide, breath_f5, breath_f_mag5);


breath_mean1 = mean(breath_f_mag_norm1,1);
breath_mean2 = mean(breath_f_mag_norm2,1);
breath_mean3 = mean(breath_f_mag_norm3,1);
breath_mean4 = mean(breath_f_mag_norm4,1);
breath_mean5 = mean(breath_f_mag_norm5,1);

breath_var1 = var(breath_f_mag_norm1,1);
breath_var2 = var(breath_f_mag_norm2,1);
breath_var3 = var(breath_f_mag_norm3,1);
breath_var4 = var(breath_f_mag_norm4,1);
breath_var5 = var(breath_f_mag_norm5,1);

breath_together_mean = [breath_mean1;breath_mean2;breath_mean3;breath_mean4;breath_mean5];
breath_total_mean = mean(breath_together_mean,1);

breath_together_var = [breath_var1;breath_var2;breath_var3;breath_var4;breath_var5];
breath_total_var = var(breath_together_var,1);
