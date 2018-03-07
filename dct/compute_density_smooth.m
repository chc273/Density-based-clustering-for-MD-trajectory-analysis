function density_matrix = compute_density_smooth(atoms, box, dr)
%COMPUTE_DENSITY 
%   atoms is a N*3*T matrix that records the coordinates of N atoms in T
%   timesteps
%   box is the boundary of the simulation box, a 3*2 matrix
%   dr is the bin size. I usually take it as 0.1

sizes = size(atoms);
T = size(atoms,3);
atoms = permute(atoms, [1,3,2]);
atoms = reshape(atoms, [sizes(1)*sizes(3), sizes(2)]);

fprintf('Converted to 2d matrix!\n');

atoms = correct_period(atoms, box);
% min(atoms(:,1)), max(atoms(:,1))
% size(atoms)
clear atoms_new
%% bins
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

%% peiodic boundaries
 Nx = Nx + 1; 
 Ny = Ny + 1;
 Nz = Nz + 1; 

density_matrix = zeros(Nx,Ny, Nz);

list = 1:size(atoms,1);

xshell_idx = list(atoms(:,1) >= (xmax - dx/2));
yshell_idx = list(atoms(:,2) >= (ymax - dy/2));
zshell_idx = list(atoms(:,3) >= (zmax - dz/2));
% size(atoms)
% single side
if ~isempty(xshell_idx)
    atoms = [atoms; [atoms(xshell_idx,1)-a, atoms(xshell_idx,2), atoms(xshell_idx,3)]];
end
if ~isempty(yshell_idx)
    atoms = [atoms; [atoms(yshell_idx,1),atoms(yshell_idx,2)-b, atoms(yshell_idx,3)]];
end
if ~isempty(zshell_idx)
    atoms = [atoms; [atoms(zshell_idx,1),atoms(zshell_idx,2), atoms(zshell_idx,3)-c]];
end
% double side
xyshell_idx = intersect(xshell_idx, yshell_idx);
yzshell_idx = intersect(yshell_idx, zshell_idx);
xzshell_idx = intersect(xshell_idx, zshell_idx);
if ~isempty(xyshell_idx)
    atoms = [atoms; [atoms(xyshell_idx, 1) -a,atoms(xyshell_idx, 2) -b,  atoms(xyshell_idx,3)]];
end
if ~isempty(yzshell_idx)
    atoms = [atoms; [atoms(yzshell_idx, 1) ,atoms(yzshell_idx, 2) -b,  atoms(yzshell_idx,3)-c]];
end
if ~isempty(xzshell_idx)
    atoms = [atoms; [atoms(xzshell_idx, 1) -a,atoms(xzshell_idx, 2) ,  atoms(xzshell_idx,3)-c]];
end
% triple side 
xyzshell_idx = intersect(xshell_idx, intersect(yshell_idx, zshell_idx));
if ~isempty(xyzshell_idx)
    atoms = [atoms, [atoms(xyzshell_idx, 1)-a ,atoms(xyzshell_idx, 2) -b,  atoms(xyzshell_idx,3)-c]];
end

xlist = floor((atoms(:,1) - xmin + dx/2) / dx) +1;
ylist = floor((atoms(:,2) - ymin + dy/2) / dy) +1;
zlist = floor((atoms(:,3) - zmin + dz/2) / dz) +1;

for i = 1:size(xlist,1)
    density_matrix(xlist(i),ylist(i), zlist(i)) = density_matrix(xlist(i),ylist(i), zlist(i))+1;
end

density_matrix = density_matrix(1:(end-1), 1:(end-1), 1:(end-1)) / dx/dy/dz/T;

% smooth
fprintf('Smoothing begins\n')
density_matrix = (density_matrix + ...
    circshift(density_matrix, [1,0,0]) + circshift(density_matrix, [-1,0,0]) + ...
    circshift(density_matrix, [0,1,0]) + circshift(density_matrix, [0,-1,0]) + ...
    circshift(density_matrix, [0,0,1]) + circshift(density_matrix, [0,0,-1]))/7;

 
end

