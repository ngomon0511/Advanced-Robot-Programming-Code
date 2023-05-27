% Clear the command window and all variables
clc
clear

syms l1 l2 l3 l4 t1 t2 t3 t4 pi
n = input('Enter the number of Dof: ');

% Initialize the transformation matrix to the identity matrix
T = eye(4);

% Loop over each coordinate system
for i = 1:n
    t = input('Theta: ');
    l = input('l: ');
    alpha = input('Alpha: ');
    d = input('d: ');
    A = [cos(t) -sin(t)*cos(alpha) sin(t)*sin(alpha) l*cos(t); sin(t) cos(t)*cos(alpha) cos(t)*sin(alpha) l*sin(t); 0 sin(alpha) cos(alpha) d; 0 0 0 1];

    % Update the transformation matrix with the new transformation
    T = T * A;
    fprintf("\n")
end

simplify(T)
