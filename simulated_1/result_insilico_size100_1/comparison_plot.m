function comparison_plot(result)
result = 'statistic_result.mat';
load(result)
data = 'insilico_size100_1';
method = {'Pearson','Spearman','SDC-P','SDC-S','TSNI','GRNVBEM','SINCERITIES'};
statistics_properties = {'Sensitivity', 'Specificity', 'F1-Score positive', 'F1-Score negative', 'AUC', 'Precision-positive', 'Precision-negative'};

y = [];
for j = 2:size(result_data,2)
    measure = [];
    for i = 2:length(result_data)
        measure = [measure result_data{i,j}];
    end
    y = [y;measure];
end

max_v = [];
max_idx = [];
for q = 1:size(y,1)
    m = max(y(q,:));
    max_v = [max_v, m];
    m_idx = find(y(q,:) == m);
    max_idx = [max_idx, m_idx];
end

x = 1:7;
h = bar(x,y);
ylim([0 1])
legend(method,'Location', 'southoutside','Orientation','horizontal');
set(gca, 'XTickLabel', statistics_properties, 'Fontsize', 15);

for t=1:7
    
    text(t+h(max_idx(t)).XOffset,max_v(t)+0.02,num2str(round(max_v(t),2)), ...
        'VerticalAlignment','bottom','horizontalalign','center','Fontsize',15)
    
    if t == 5
        text(t+h(max_idx(t)).XOffset,max_v(t)+0.07,method{max_idx(t)}, ...
            'VerticalAlignment','bottom','horizontalalign','center','Fontsize',15)
    end
end


hold on

t = suptitle('Simulated data 1');
set(t,'FontSize',30);


end