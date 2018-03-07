function readDump(filename)

    count = 0;  
    fid = fopen(filename,'r');

    while ~feof(fid)
       a = fgetl(fid);
       if strcmp(a,'ITEM: TIMESTEP')
           timestep(count+1) = str2num(fgetl(fid));
           count =count+1;
       end

       if strcmp(a,'ITEM: NUMBER OF ATOMS')
           N = str2num(fgetl(fid));
       end   
       if strcmp(a,'ITEM: BOX BOUNDS pp pp pp')
          if count==1
          box = textscan(fid,'%f %f',3);
          box = cell2mat(box);
          end
       end
       if strcmp(a,'ITEM: ATOMS id type xu yu zu ')
           A = textscan(fid,'%f %f %f %f %f');
           C1=cell2mat(A);
           [id, idindex] = sort(C1(:,1));

           atoms(:,:,count) =C1(idindex,:);
       end   
       if count>5000
            break;
       end
    end
 
save('data','atoms','timestep','box');
fprintf('Data has been processed!\n');
end