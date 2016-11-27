k = 1;
step = 128;
z = 0;
for i = 1 : step : length(delta) - (step)
    del_fft = abs(fft(delta(i:i+step),step));
    for j = 1:step
        z(k) = del_fft(j)^2;
    end
    %z = abs(fft(filtered_data(i:i+step)));
    %z = pwelch(delta(i:i+step));
    %z(k) = z(k) / (step);
    k = k + 1;
end

figure;
plot(VarName1);

figure;
plot(z);