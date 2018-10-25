function atom = correct_period(atom, box )
    %Wrap atom positions to a periodic box
    %   atom, a N*3 matrix for coordinates
    %   box, a 3*2 matrix for box vector
    xmin = box(1,1);
    xmax = box(1,2);
    ymin = box(2,1);
    ymax = box(2,2);
    zmin = box(3,1);
    zmax = box(3,2);
    atom(:,1) = xmin + mod(atom(:,1), xmax-xmin);
    atom(:,2) = ymin + mod(atom(:,2), ymax-ymin);
    atom(:,3) = zmin + mod(atom(:,3), zmax-zmin);

end

