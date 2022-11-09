function s = shorten(s,n)

% Shorten an array of strings

for i=1:numel(s)
    tmp = char(s(i));
    if length(tmp)>=n
        s(i) = [tmp(1:n-3) '...'];
    end
end