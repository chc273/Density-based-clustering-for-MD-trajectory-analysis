function flag = write_density( matrix, box, file)
%WRITE_DENSITY Summary of this function goes here
%   Detailed explanation goes here
fid = fopen(file, 'w');
count = 0;

% write header
fprintf(fid, 'LLZO\n 1.0\n %f 0.0 0.0\n 0.0 %f 0.0 \n 0.0 0.0 %f\n O\n1\n Direct\n 0.5 0.5 0.5\n\n', box(1,2)-box(1,1), box(2,2)-box(2,1), box(3,2) - box(3,1));
fprintf(fid, '%d %d %d\n', size(matrix));
for k = 1:size(matrix,3)
    for j = 1:size(matrix,2)
        for i = 1:size(matrix,1)
            count = count+1;
            
            fprintf(fid,'%5.6e ',matrix(i,j,k));
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

