% 1 readAllData from Dumpfile
read_all_data
% 2 compute the density
processall
% 3 select the density iso value
determine_sigma_in_density
% 4 cluster the density
labs = compute_cluster_number(density, cutoff);
write_density(density, box_avg, 'POSCAR');
% 5 label all points to clusters
label_all_points
save('labs','labs')
% 6 recast the clusters into label trajectories
recast_all


