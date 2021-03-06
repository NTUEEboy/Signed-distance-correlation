%sim_data = {'insilico_size100_1','insilico_size100_2','insilico_size100_3','insilico_size100_4','insilico_size100_5'};
sim_data = {'insilico_size100_5'};
SDC = {'SDCP','SDCS'};
method = {'TSNI','GRNVBEM','SINCERITIES'};

table = [];

fig_idx = 1;
figure


for i = 1:length(sim_data)
    
    Pear = [sim_data{i},'_','Pearson.mat'];
    Spear = [sim_data{i},'_','Spearman.mat'];
    SDCP = [sim_data{i},'_','SDCP.mat'];
    SDCS = [sim_data{i},'_','SDCS.mat'];
    TSNI = [sim_data{i},'_','TSNI.mat'];
    GRNVBEM = [sim_data{i},'_','GRNVBEM.mat'];
    SINCERITIES = [sim_data{i},'_','SINCERITIES.mat'];
    
    load(TSNI)
    auc_tsni = ((sum([resultsU{2:end,5}])/(length(resultsU)-1))+(sum([resultsD{2:end,5}])/(length(resultsD)-1)))/2;
    
    
    load(GRNVBEM)
    auc_grnvbem = ((sum([resultsU{2:end,5}])/(length(resultsU)-1))+(sum([resultsD{2:end,5}])/(length(resultsD)-1)))/2;
    
    
    load(SINCERITIES)
    auc_sincerities = ((sum([resultsU{2:end,5}])/(length(resultsU)-1))+(sum([resultsD{2:end,5}])/(length(resultsD)-1)))/2;
    
    
    load(SDCP)
    auc_sdcp = ((sum([resultsU{2:end,5}])/(length(resultsU)-1))+(sum([resultsD{2:end,5}])/(length(resultsD)-1)))/2;
    
    
    load(SDCS)
    auc_sdcs = ((sum([resultsU{2:end,5}])/(length(resultsU)-1))+(sum([resultsD{2:end,5}])/(length(resultsD)-1)))/2;
    
    
    m = [auc_tsni auc_grnvbem auc_sincerities];
    [~,r] = sort(m,'descend');
    
    
    if auc_sdcp > auc_sdcs
        [Z_corr_U,Z_corr_D] = zoneArea(Pear,Spear,SDCP);
        [Z_method_U,Z_method_D] = zoneArea(SDCP,[sim_data{i},'_',method{find(r==1)},'.mat'],[sim_data{i},'_',method{find(r==2)},'.mat']);
    else
        [Z_corr_U,Z_corr_D] = zoneArea(Pear,Spear,SDCS);
        [Z_method_U,Z_method_D] = zoneArea(SDCS,[sim_data{i},'_',method{find(r==1)},'.mat'],[sim_data{i},'_',method{find(r==2)},'.mat']);
    end
    
    
    subplot(1,4,fig_idx)
    venn(Z_corr_U./sum(Z_corr_U))
    axis off
    fig_idx = fig_idx + 1;
    
    subplot(1,4,fig_idx)
    venn(Z_corr_D./sum(Z_corr_D))
    axis off
    fig_idx = fig_idx + 1;
    
    subplot(1,4,fig_idx)
    venn(Z_method_U./sum(Z_method_U))
    axis off
    fig_idx = fig_idx + 1;
    
    subplot(1,4,fig_idx)
    venn(Z_method_D./sum(Z_method_D))
    axis off
    fig_idx = fig_idx + 1;
    
end

t = suptitle('Simulated data 5');
set(t,'FontSize',30);