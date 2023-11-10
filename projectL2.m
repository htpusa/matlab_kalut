function xProj = projectL2(x,c)

% PROJECTL2 L_2-projection
%  xProj = projectL2(x,c)
%
%  EXAMPLE
%  x = rand(10,1);
%  xProj = projectL2(x,2);

xProj = c*x/norm(x,2);