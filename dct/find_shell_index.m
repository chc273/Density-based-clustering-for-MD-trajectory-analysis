function idx_found = find_shell_index( density, id, N )
% dim is the dimension
% id is the starting index
% N is the Nth shell
msize = size(density);
dim = max(size(msize));
% list index to the dimensional index
%     if dim == 2
%         a = msize(1);
%         b = msize(2);
%         idx(2) = mod(id,b);
%         idx(1) = (id - idx(2))/b +1;
%         xmin = shift_position(idx(1) - N,a );
%         xmax = shift_position(idx(1) + N,a);
%         ymin = shift_position(idx(2) -N, b);
%         ymax = shift_position(idx(2) +N, b);
%     end
    if dim ==3
        a = msize(1);
        b = msize(2);
        c = msize(3);
        idx(3) = mod(id, c);
        idx(2) = mod((id-idx(3))/c, b)+1;
        idx(1) = (id - idx(3) - (idx(2)-1)*c)/b/c+1;
        xmin = shift_position(idx(1) - N,a );
        xmax = shift_position(idx(1) + N,a);
        ymin = shift_position(idx(2) -N , b);
        ymax = shift_position(idx(2) +N ,b);
        zmin = shift_position(idx(3)-N,c);
        zmax = shift_position(idx(3) +N,c);
        
        idx_found = [];
        xindex = generate_continuum_list(xmin, xmax, a);
        yindex = generate_continuum_list(ymin, ymax, b);
        zindex = generate_continuum_list(zmin, zmax, c);
        
        cubic_out = combvec(xindex, yindex, zindex)';
        cubic_in = combvec(xindex(2:(end-1)), yindex(2:(end-1)), zindex(2:(end-1)))';
        idx_found = cubic_out(~ismember(cubic_out, cubic_in, 'rows'),:);
        idx_found = (idx_found(:,1)-1) * b*c + (idx_found(:,2)-1)*c +idx_found(:,3);
    end


end


function x0 = shift_position(x,a)
    if x <= 0
        x0 = x+ a;
    elseif x >a
        x0 = x-a;

    else
        x0 = x;
    end
end

function x0 = generate_continuum_list(xmin, xmax, a)
    if xmax < xmin
        x0 = [xmin:a, 1:xmax];
    else
        x0 = xmin:xmax;
    end
end