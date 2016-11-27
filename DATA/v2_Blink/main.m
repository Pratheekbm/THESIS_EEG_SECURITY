clear;
clc;

for i = 1:20
    file_name = strcat(int2str(i),'.dat');
    features(i,:) = get_features(file_name);
end

raw_features(:,:) = get_features('raw.dat');
no_blink(:,:) = get_features('no_blink.dat');
eye_move(:,:) = get_features('eye_move.dat');
calc(:,:) = get_features('calc.dat');
meditate(:,:) = get_features('meditate.dat');
breath(:,:) = get_features('breath.dat');

features_mag = sqrt(sum(abs(features).^2,2));
raw_mag = sqrt(sum(abs(raw_features).^2,2));
no_blink_mag = sqrt(sum(abs(no_blink).^2,2));
eye_move_mag = sqrt(sum(abs(eye_move).^2,2));
calc_mag = sqrt(sum(abs(calc).^2,2));
meditate_mag = sqrt(sum(abs(meditate).^2,2));
breath_mag = sqrt(sum(abs(breath).^2,2));

features_mag_norm = bsxfun(@rdivide, features, features_mag);
raw_mag_norm = bsxfun(@rdivide, raw_features, raw_mag);
no_blink_mag_norm = bsxfun(@rdivide, no_blink, no_blink_mag);
eye_move_mag_norm = bsxfun(@rdivide, eye_move, eye_move_mag);
calc_mag_norm = bsxfun(@rdivide, calc, calc_mag);
meditate_mag_norm = bsxfun(@rdivide, meditate, meditate_mag);
breath_mag_norm = bsxfun(@rdivide, breath, breath_mag);