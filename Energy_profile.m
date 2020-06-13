%all angles are in degrees
% Defining ground state (Considering the plane state as ground state)
L_ab = input('Length of AB = ');
alpha = input('Angle Alpha = ');
gamma = input('Angle Gamma = ');
EA = input('Axial rigidity = ');
n_sides = input('No. of sides = ');

%Calculate other sides and angles
beta = 180 - alpha - gamma;
L_bc = sind(alpha)*L_ab/sind(gamma);
L_ca = sind(beta)*L_ab/sind(gamma);

%Defining other important parameters
radius = L_ab;
height = L_ca*sind(alpha);

%functions for new lengths as a function of h, n and phi
%phi corresponsds to clockwise rotation of upper hexagon wrt lower one
l_ab = @(h, r, phi, n) 2*r*sind(180/n);
l_bc = @(h, r, phi, n) sqrt((h^2) - (2*(r^2)*cosd(phi)) + (2*(r^2)));
l_ca = @(h, r, phi, n) sqrt((h^2) - (2*(r^2)*cosd((360/n)+phi)) + (2*(r^2)));

%function for strains in members
epsilon_ab = @(h, r, phi, n) (l_ab(h, r, phi, n)-L_ab)/L_ab;
epsilon_bc = @(h, r, phi, n) (l_bc(h, r, phi, n)-L_bc)/L_bc;
epsilon_ca = @(h, r, phi, n) (l_ca(h, r, phi, n)-L_ca)/L_ca;

%function for total energy of one hexagonal cell
energy = @(h, r, phi, n) n*EA*((L_ab*((epsilon_ab(h, r, phi, n))^2))+(L_bc*((epsilon_bc(h, r, phi, n))^2))+(L_ca*((epsilon_ca(h, r, phi, n))^2)))/2;

%energy tables
e_table = zeros(11, 181);
for i = 0 : 10
    for j = 0 : 180
        e_table(i+1, j+1) = energy(i*0.1*height, radius, j, n_sides);
    end
end

plot(e_table');
%individual graphs are obtained by plotting the individual rows of e_table

