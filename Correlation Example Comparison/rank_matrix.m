function rank_x = rank_matrix(x)
r = sort(x(:));
rank_x = [];
for i = 1:size(x,1)
    for j = 1:size(x,2)
        idx = find(r == x(i,j));
        if length(idx) == 1
            rank_x(i,j) = idx;
        else
            rank_x(i,j) = sum(idx)/length(idx);
        end
    end
end
end