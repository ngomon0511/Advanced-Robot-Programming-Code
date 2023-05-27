% Clear the command window and all variables
clc
clear

% Declare symbolic variables for length arm robot and rotation angle
syms l1 l2 t1 t2

% Prompt the user to enter the number of coordinate systems
num_coord = input('Enter the number of coordinate systems: ');

% Initialize the transformation matrix to the identity matrix
trans_mat = eye(4);

% Loop over each coordinate system
for i = 1:num_coord
    % Prompt the user to enter the type of transformation (translation or rotation)
    disp(['Coordinate system ', num2str(i)])
    trans_type = input('Enter the type of transformation (0: translation, 1: rotation): ');

    % Apply the transformation matrix for the corresponding displacement parameters
    if trans_type == 0
        % Translation
        dx = input('Enter the displacement along the x-axis: ');
        dy = input('Enter the displacement along the y-axis: ');
        dz = input('Enter the displacement along the z-axis: ');
        trans_mat_i = [1 0 0 dx; 0 1 0 dy; 0 0 1 dz; 0 0 0 1];
    elseif trans_type == 1
        % Rotation
        axis = input('Enter the axis of rotation (x, y, or z): ', 's');
        angle = input('Enter the angle of rotation: ');
        if axis == 'x'
            trans_mat_i = [1 0 0 0; 0 cos(angle) -sin(angle) 0; 0 sin(angle) cos(angle) 0; 0 0 0 1];
        elseif axis == 'y'
            trans_mat_i = [cos(angle) 0 sin(angle) 0; 0 1 0 0; -sin(angle) 0 cos(angle) 0; 0 0 0 1];
        elseif axis == 'z'
            trans_mat_i = [cos(angle) -sin(angle) 0 0; sin(angle) cos(angle) 0 0; 0 0 1 0; 0 0 0 1];
        else
            error('Invalid axis of rotation. Must be x, y, or z.')
        end
    else
        error('Invalid type of transformation. Must be 0 or 1.')
    end

    % Update the transformation matrix with the new transformation
    trans_mat = trans_mat * trans_mat_i;
end

% Simplify the resulting transformation matrix
simplified_mat = simplify(trans_mat*[0; 0; 0; 1]);
disp(simplified_mat)
