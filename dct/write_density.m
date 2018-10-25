function flag = write_density(density, box, file)
    %write a CHGCAR-like file for visualization in vesta
    %  density, M*N*D density tensor
    %  box, 3*2, lattice
    %  file, filename
    fid = fopen(file, 'w');
    count = 0;

    % write header
    fprintf(fid, 'LLZO\n 1.0\n %f 0.0 0.0\n 0.0 %f 0.0 \n 0.0 0.0 %f\n O\n1\n Direct\n 0.5 0.5 0.5\n\n', box(1,2)-box(1,1), box(2,2)-box(2,1), box(3,2) - box(3,1));
    fprintf(fid, '%d %d %d\n', size(density));
    for k = 1:size(density,3)
        for j = 1:size(density,2)
            for i = 1:size(density,1)
                count = count+1;

                fprintf(fid,'%5.6e ',density(i,j,k));
                if mod(count,5) == 0
                    fprintf(fid,'\n');
                end
            end
        end
    end
    % fprintf(fid, '%f ', matrix );
    fclose(fid);
    flag = 1;

end

