clear
for i = 900:100:1200
    cd([int2str(i),'K']);
    filename = [int2str(i),'.lammpstrj']
    main;
    cd ..
end