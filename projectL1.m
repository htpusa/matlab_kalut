function xProj = projectL1(x,c)

% PROJECTL1 L_1-projection from Duchi et al. 2008
%  xProj = projectL1(x,c)
%
%  EXAMPLE
%  x = rand(10,1);
%  xProj = projectL1(x,1);

%  Duchi, John, et al. "Efficient projections onto the l_1-ball for 
%   learning in high dimensions." Proceedings of the 25th international
%   conference on Machine learning. 2008.

u = sort(abs(x),'descend');
sv = cumsum(u);
rho = find(u > (sv - c) ./ (1:length(u))', 1, 'last');
if isempty(rho)
    %warning('Regularisation parameter value might be too small.')
    [~,ind] = max(abs(x));
    xProj = zeros(numel(x),1);
    xProj(ind) = sign(x(ind)) * c;
else
    theta = max(0, (sv(rho) - c) / rho);
    xProj = sign(x) .* max(abs(x) - theta, 0);
end