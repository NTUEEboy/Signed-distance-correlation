method = {'correlation', 'TSNI', 'GRNVBEM', 'SINCERITIES'};

result_data(1, :) = {'data','sensitivity','specificity','f1 positive','f1 negative','auc', 'precision positive', 'precision negative'};
idx =2;

for i = 1:length(method)
    
    if i == 1
        
        load result.mat
        for l = 2:size(statistic_result,1)
            result_data{idx , 1} = statistic_result{l,1};
            result_data{idx , 2} = statistic_result{l,2};
            result_data{idx , 3} = statistic_result{l,3};
            result_data{idx , 4} = statistic_result{l,4};
            result_data{idx , 5} = statistic_result{l,5};
            result_data{idx , 6} = statistic_result{l,6};
            result_data{idx , 7} = statistic_result{l,7};
            result_data{idx , 8} = statistic_result{l,8};
            idx = idx + 1;
            
        end

    elseif i > 1
        mat_name = ['insilico_size100_1', '_', method{i},'.mat'];
        data_name = ['insilico_size100_1','_', method{i}];
        load(mat_name)
        
        result_data{idx , 1} = data_name;
        result_data{idx , 2} = statistic_result{2,1};
        result_data{idx , 3} = statistic_result{2,2};
        result_data{idx , 4} = statistic_result{2,3};
        result_data{idx , 5} = statistic_result{2,4};
        result_data{idx , 6} = statistic_result{2,5};
        result_data{idx , 7} = statistic_result{2,6};
        result_data{idx , 8} = statistic_result{2,7};
        idx = idx + 1;
        
    end
    
end


save('statistic_result.mat', 'result_data')
