for i = 1:10
    dirname = int2str(i);
    cd(dirname);
    copyfile('../readDump.m','./');
    read_write_dump('300.lammpstrj');
    cd ..
    
end