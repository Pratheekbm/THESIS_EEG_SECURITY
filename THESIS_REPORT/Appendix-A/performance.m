function [TPR, FPR ] = performance( pred, y , class)
TP = 0;
FN = 0;
FP = 0;
TN = 0;
for i = 1:length(pred)
  if((pred(i) == class) && (y(i) == class))
    TP = TP + 1;
    
  elseif((pred(i) ~= class) && (y(i) == class))
    FN = FN + 1;
  elseif((pred(i) == class) && (y(i) ~= class))
    FP = FP + 1;
  elseif((pred(i) ~= class) && (y(i) ~= class))
    TN = TN + 1;
  end
end

TPR = (TP * 100)/(TP+FN);
FPR = (FP * 100)/(FP+TN);
end

