function [X, fX, i] = fmincg(f, X, options, P1, P2, P3, P4, P5)
% Minimize a continuous differentialble multivariate function. Starting point
% is given by "X" (D by 1), and the function named in the string "f", must
% return a function value and a vector of partial derivatives. The Polack-
% Ribiere flavour of conjugate gradients is used to compute search directions,
% and a line search using quadratic and cubic polynomial approximations and the
% Wolfe-Powell stopping criteria is used together with the slope ratio method
% for guessing initial step sizes. Additionally a bunch of checks are made to
% make sure that exploration is taking place and that extrapolation will not
% be unboundedly large. The "length" gives the length of the run: if it is
% positive, it gives the maximum number of line searches, if negative its
% absolute gives the maximum allowed number of function evaluations. You can
% (optionally) give "length" a second component, which will indicate the
% reduction in function value to be expected in the first line-search (defaults
% to 1.0). The function returns when either its length is up, or if no further
% progress can be made (ie, we are at a minimum, or so close that due to
% numerical problems, we cannot get any closer). If the function terminates
% within a few iterations, it could be an indication that the function value
% and derivatives are not consistent (ie, there may be a bug in the
% implementation of your "f" function). The function returns the found
% solution "X", a vector of function values "fX" indicating the progress made
% and "i" the number of iterations (line searches or function evaluations,
% depending on the sign of "length") used.
%
% Usage: [X, fX, i] = fmincg(f, X, options, P1, P2, P3, P4, P5)
%
% See also: checkgrad
%
% Copyright (C) 2001 and 2002 by Carl Edward Rasmussen. Date 2002-02-13
%
%
% (C) Copyright 1999, 2000 & 2001, Carl Edward Rasmussen
%
% Permission is granted for anyone to copy, use, or modify these
% programs and accompanying documents for purposes of research or
% education, provided this copyright notice is retained, and note is
% made of any changes that have been made.
%
% These programs and documents are distributed without any warranty,
% express or implied.  As the programs were written for research
% purposes only, they have not been tested to the degree that would be
% advisable in any important application.  All use of these programs is
% entirely at the user's own risk.
%
% [ml-class] Changes Made:
% 1) Function name and argument specifications
% 2) Output display
%

% Read options
if exist('options', 'var') && ~isempty(options) && isfield(options, 'MaxIter')
  length = options.MaxIter;
else
  length = 100;
end


RHO = 0.01;
SIG = 0.5;
INT = 0.1;
EXT = 3.0;
MAX = 20;
RATIO = 100;

argstr = ['feval(f, X'];
for i = 1:(nargin - 3)
  argstr = [argstr, ',P', int2str(i)];
end
argstr = [argstr, ')'];

if max(size(length)) == 2, red=length(2); length=length(1); else red=1; end
S=['Iteration '];

i = 0;
ls_failed = 0;
fX = [];
[f1 df1] = eval(argstr);
i = i + (length<0);
s = -df1;
d1 = -s'*s;
z1 = red/(1-d1);

while i < abs(length)
  i = i + (length>0);
  
  X0 = X; f0 = f1; df0 = df1;
  X = X + z1*s;
  [f2 df2] = eval(argstr);
  i = i + (length<0);
  d2 = df2'*s;
  f3 = f1; d3 = d1; z3 = -z1;
  if length>0, M = MAX; else M = min(MAX, -length-i); end
  success = 0; limit = -1;
  while 1
    while ((f2 > f1+z1*RHO*d1) || (d2 > -SIG*d1)) && (M > 0)
      limit = z1;
      if f2 > f1
        z2 = z3 - (0.5*d3*z3*z3)/(d3*z3+f2-f3);
      else
        A = 6*(f2-f3)/z3+3*(d2+d3);
        B = 3*(f3-f2)-z3*(d3+2*d2);
        z2 = (sqrt(B*B-A*d2*z3*z3)-B)/A;
      end
      if isnan(z2) || isinf(z2)
        z2 = z3/2;
      end
      z2 = max(min(z2, INT*z3),(1-INT)*z3);
      z1 = z1 + z2;
      X = X + z2*s;
      [f2 df2] = eval(argstr);
      M = M - 1; i = i + (length<0);
      d2 = df2'*s;
      z3 = z3-z2;
    end
    if f2 > f1+z1*RHO*d1 || d2 > -SIG*d1
      break;
    elseif d2 > SIG*d1
      success = 1; break;
    elseif M == 0
      break;
    end
    A = 6*(f2-f3)/z3+3*(d2+d3);
    B = 3*(f3-f2)-z3*(d3+2*d2);
    z2 = -d2*z3*z3/(B+sqrt(B*B-A*d2*z3*z3));
    if ~isreal(z2) || isnan(z2) || isinf(z2) || z2 < 0
      if limit < -0.5
        z2 = z1 * (EXT-1);
      else
        z2 = (limit-z1)/2;
      end
    elseif (limit > -0.5) && (z2+z1 > limit)
      z2 = (limit-z1)/2;
    elseif (limit < -0.5) && (z2+z1 > z1*EXT)
      z2 = z1*(EXT-1.0);
    elseif z2 < -z3*INT
      z2 = -z3*INT;
    elseif (limit > -0.5) && (z2 < (limit-z1)*(1.0-INT))
      z2 = (limit-z1)*(1.0-INT);
    end
    f3 = f2; d3 = d2; z3 = -z2;
    z1 = z1 + z2; X = X + z2*s;
    [f2 df2] = eval(argstr);
    M = M - 1; i = i + (length<0);
    d2 = df2'*s;
  end
  
  if success
    f1 = f2; fX = [fX' f1]';
    s = (df2'*df2-df1'*df2)/(df1'*df1)*s - df2;
    tmp = df1; df1 = df2; df2 = tmp;
    d2 = df1'*s;
    if d2 > 0
      s = -df1;
      d2 = -s'*s;
    end
    z1 = z1 * min(RATIO, d1/(d2-realmin));
    d1 = d2;
    ls_failed = 0;
  else
    X = X0; f1 = f0; df1 = df0;
    if ls_failed || i > abs(length)
      break;
    end
    tmp = df1; df1 = df2; df2 = tmp;
    s = -df1;
    d1 = -s'*s;
    z1 = 1/(1-d1);
    ls_failed = 1;
  end
  if exist('OCTAVE_VERSION')
    fflush(stdout);
  end
end
