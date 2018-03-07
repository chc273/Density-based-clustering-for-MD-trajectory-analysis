function labs = compute_cluster_number(pointsT, cutoff)
    msize = size(pointsT)

    UNCLASSIFIED = 0 ;
    NOISE = -1;
    dim = numel(msize)
    if dim ==2
        M = size(pointsT, 1);
        N = size(pointsT, 2);
        L = M * N;
        points = zeros(L, 3);
        pointsnew = zeros(L, 3);
        for i = 1:M
            for j = 1:N
                index = (i-1) * N +j;
                points(index, :) = [ pointsT(i,j),i,j];  
            end
        end
    end

    if dim ==3
        M = size(pointsT, 1);
        N = size(pointsT, 2);
        K = size(pointsT, 3);
        L = M*N*K;
        points = zeros(L, 4);
        pointsnew = zeros(L, 4);
        for i = 1:M
            for j = 1:N
                for l = 1:K
                    index = (i-1) * N*K +(j-1)*K +l;
                    points(index, :) = [ pointsT(i,j,l),i,j,l];  
                end
            end
        end    
    end

fprintf('\n***************************\ndata conversion completed!\n***************************\n')
labs = UNCLASSIFIED*ones(L,1);
index = 1:L;
noise = points(:,1) <cutoff & points(:,1) >0;
zero_value = points(:,1) ==0;

indexvalue = index(~(noise|zero_value));
fprintf('Entries greater than cutoff: %d \n', numel(indexvalue));
pointsnew(:,:) = points(:,:); % store the original data

labs(noise, :) = NOISE;
labs(zero_value, :) = UNCLASSIFIED;

% searched = [indexnoise; indexzero];
% begin = indexvalue;
clab = 1;
while ~isempty(indexvalue)
    start = indexvalue(1);
    fprintf('%d th cluster begin\n',clab);
    tic
    found = find_all_neighbors_stack(pointsnew, start, msize, dim, cutoff);
    indexvalue = setdiff(indexvalue, found);
    labs(found) = clab;
    fprintf('%d th cluster found\n', clab);
    fprintf('size is %d\n', length(found));
    toc
    clab = clab + 1;
    
end


end


function seedssearched = find_all_neighbors_stack(pointsnew, pidx, msize, dim, cutoff ) 

    seedsstart = pidx;
    seedssearched = [];
    count = 1;
    while ~isempty(seedsstart)
        start = seedsstart(1);
        idx_out = find_neighbor(start, msize, dim);
        idx_new = idx_out(find(pointsnew(idx_out,1)>cutoff));

        if ~isempty(idx_new)
            idx_new(ismember(idx_new, seedssearched)) = [];  
            idx_new(ismember(idx_new, seedsstart)) = [];  
        end
        seedsstart(1) = [];
        seedsstart = [idx_new; seedsstart];
        seedssearched = [seedssearched; start];
        if mod(count,1000) ==0
            fprintf('To search size %d \n',length(seedsstart));
            fprintf('Cluster size %d \n',length(seedssearched));
        end
%         fprintf('*********************\n NEW\n *************************\n')
        count = count+1;
    end
    

end


function neighbor = find_neighbor(id, msize, dim)
    % idx is the index of the point, it is a vector.
    % msize is the size of the matrix
    % dim is the dimension, 2 or 3.
    
    if dim == 2
        a = msize(1);
        b = msize(2);
        idx(2) = mod(id,b);
        idx(1) = (id - idx(2))/b +1;
        xmin = shift_position(idx(1) - 1,a );
        xmax = shift_position(idx(1) + 1,a);
        ymin = shift_position(idx(2) -1 , b);
        ymax = shift_position(idx(2) +1 ,b);
        
        neighbor = combvec([xmin, idx(1), xmax], [ymin, idx(2), ymax])';
        neighbor(5,:) = [];
        neighbor = (neighbor(:,1)-1) * b + neighbor(:,2);
    end
    if dim ==3
        a = msize(1);
        b = msize(2);
        c = msize(3);
        idx(3) = mod(id, c);
        idx(2) = mod((id-idx(3))/c, b)+1;
        idx(1) = (id - idx(3) - (idx(2)-1)*c)/b/c+1;
        xmin = shift_position(idx(1) - 1,a );
        xmax = shift_position(idx(1) + 1,a);
        ymin = shift_position(idx(2) -1 , b);
        ymax = shift_position(idx(2) +1 ,b);
        zmin = shift_position(idx(3)-1,c);
        zmax = shift_position(idx(3) +1,c);
        neighbor = combvec([xmin, idx(1), xmax], [ymin, idx(2), ymax], [zmin, idx(3), zmax])';
        neighbor(14,:) = [];
        neighbor = (neighbor(:,1)-1) * b*c + (neighbor(:,2)-1)*c +neighbor(:,3);
    end
    
end

function x0 = shift_position(x,a)
    if x ==0
        x0 = a;
    elseif x >a
        x0 = x-a;
    else
        x0 = x;
    end
end
