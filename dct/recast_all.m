for i = 1:10
    copyfile('recast_to_jumps.m', [int2str(i),'/']);
    cd(int2str(i));
    load('data2.mat')
    recast_to_jumps;
    save('jump_labs','jump_labs');
    cd ..
end