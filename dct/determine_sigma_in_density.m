load('density');
cutoffs = linspace(0.01,10,1000);
values = zeros(size(cutoffs));

values = zeros(size(cutoffs));
for i = 1:numel(values)
    values(i) = sum(sum(sum(density(density>cutoffs(i)))));
end
values = values/(sum(sum(sum((density(density>0))))));
% figure 
% plot(cutoffs, values);
% xlabel('Cutoff density');
% ylabel('Value percentage');
value_sort = abs(values-0.5);
[~, index_sort] = sort(value_sort, 'ascend');
cutoff = cutoffs(index_sort(1))
