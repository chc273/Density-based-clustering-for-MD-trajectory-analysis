## Density-based Clustering of Trajectories

This algorithm is based on the idea of density-based spatial clustering of applications with Noise (DBSCAN).

Instead of computing individual particles, here we first convert the particle trajectories into spatial densities. Then, we select a density cutoff $$\rho_0$$ as a hypersurface to cut the spatial domains. 

$$\rho_0$$ is selected such that half of the particles are within the surface and the remaining are outside the surface. We can also tune the fraction to achieve better results.

The code is organized as follows:

1. `compute_density_smooth(atoms, box, dr)` calculates a density matrix from `atoms` trajectories, (M*3*T tensor), lattice `box`, and spatial resolution `dr`.
2. `determine_sigma_in_density(density, fraction)`  determines a density value for cutting the spatial domain `density` so that the a `fraction` of the particles are within the surface. 
3. `compute_cluster_number(density, cutoff)` cluster the voxels and labels the voxel in density with the corresponding cluster.
4. `read_dump(filename)` reads lammps dump file that has a specific format "id, type, xu, yu, zu"
5. `write_density(density, box, file)`, write `density` and its corresponding `box` to a `file` for vesta visualization. 
    
## Reference
[1] Chen, C., Lu, Z., & Ciucci, F. (2017). Data mining of molecular dynamics data reveals Li diffusion characteristics in garnet Li7La3Zr2O12. Scientific reports, 7, 40769.
