% load('data.mat');
% select Li atoms

jump_labs = zeros(size(Li_atoms,1), size(Li_atoms,3));
dr = 0.1;
box = box_avg;
xmin = box(1,1);
xmax = box(1,2);
ymin = box(2,1);
ymax = box(2,2);
zmin = box(3,1);
zmax = box(3,2);
a = xmax - xmin;
b = ymax - ymin;
c = zmax - zmin;
Nx = floor(a/dr);
Ny = floor(b/dr);
Nz = floor(c/dr);

dx = a / Nx;
dy = b / Ny;
dz = c / Nz;
for i = 1:size(jump_labs,2)
    Li_atom = Li_atoms(:,:,i);
    Li_atom = correct_period(Li_atom, box);
    xlist = floor((Li_atom(:,1) - xmin + dx/2) / dx) +1;
    xlist(xlist>Nx) = xlist(xlist>Nx) - Nx;
    
    ylist = floor((Li_atom(:,2) - ymin + dy/2) / dy) +1;
    ylist(ylist>Ny) = ylist(ylist>Ny) - Ny;
    
    zlist = floor((Li_atom(:,3) - zmin + dz/2) / dz) +1;
    zlist(zlist>Nz) = zlist(zlist>Nz) - Nz;
    singleindex = (xlist-1) * Ny*Nz + (ylist-1)*Nz +zlist;
    jump_labs(:,i) = labs(int32(singleindex));
    
    
end
% save('jump_labs','data2','jump_labs')