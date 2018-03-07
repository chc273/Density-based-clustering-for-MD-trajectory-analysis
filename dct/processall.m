dr = 0.1;
box_store = zeros(3,2,10);
for i = 1:10
    dirname = int2str(i);
    cd(dirname);
    load('data.mat');
    box_store(:,:,i) = box(:,:,end);
    cd ..
end
box_avg = mean(box_store,3);

% Rescale Atom Coord

for i = 1:10
    dirname = int2str(i);
    copyfile('compute_density_smooth.m', dirname);
    cd(dirname);
    load('data.mat');
    Li_atoms = atoms(atoms(:,2)==1,3:5,:);
    Li_atoms(:,1,:) = (Li_atoms(:,1,:) - box(1,1)) * (box_avg(1,2) - box_avg(1,1))/ (box(1,2) - box(1,1)) + box_avg(1,1);
    Li_atoms(:,2,:) = (Li_atoms(:,2,:) - box(2,1)) * (box_avg(2,2) - box_avg(2,1))/ (box(2,2) - box(2,1)) + box_avg(2,1);
    Li_atoms(:,3,:) = (Li_atoms(:,3,:) - box(3,1)) * (box_avg(3,2) - box_avg(3,1))/ (box(3,2) - box(3,1)) + box_avg(3,1);
    
    density_temp = compute_density_smooth(Li_atoms, box_avg, dr);
    save('data2.mat','Li_atoms','density_temp','box_avg');
    if i==1
        density = density_temp/10;
    else
        density = density + density_temp/10;
    end
    cd ..
end
save('density','density','box_avg');


