load('density');

% 
% labs = compute_clusterNo(density, cutoff);
NOISE = -1;
index = 1:size(labs,1);
noise_index = index(labs == NOISE);
labs_store = labs;
for i = 1:numel(noise_index)
    if mod(i,10000) ==0
        fprintf('%d/%d\n',i,numel(noise_index))
    end
    noise_point = noise_index(i);
    Nshell = 2;
    neighbor_flag = 0;
    while ~neighbor_flag
        idx_found = find_shell_index(density, noise_point, Nshell);
        shell_labs = labs_store(idx_found); % has to be compared to the original cluster labs
        if any(shell_labs >0 )
           valid_labs = shell_labs(shell_labs>0);
           labs(noise_point) = valid_labs(1); % update the labs
           neighbor_flag = 1;
        else
            Nshell = Nshell+1;
        end
    end
end