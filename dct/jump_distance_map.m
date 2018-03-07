load('jump_labs.mat');
jump_distance = zeros(448, 5000);
for i = 2:5000
    B = Li_atoms(:,:,i) - Li_atoms(:,:,i-1);
    jump_distance(:,i) = sqrt(sum(B.^2,2)); 
end


MSD = zeros(448,5000);
for i = 2:5000
    B = Li_atoms(:,:,i ) - Li_atoms(:,:,1);
    MSD(:,i) = sqrt(sum(B.^2, 2));
end