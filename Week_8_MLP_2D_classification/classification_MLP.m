%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Master in Robotics
%                    Applied Artificial Intelligence
%
% Assinment 5.1:  Classification Error
% Student: Josep Barbera Civera
% ID: 17048
% Date: 09/04/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3. Plot in the Z space all possible three values calculated on 
%   previous section, writing the number of the associated zone. 
%   Also write the desired final classification output for each 
%   zone (i.e. zero or one) in brackets beside the zone number.
% 4. Plot in the Z space the plane that should define the output
%   neuron to solve the classification problem (i.e. providing 
%   the desired one or zero for points in each zone)


% Define 3D points from NN outputs
x1 = [1, 0, 0, 0, 1, 1, 1];
y1 = [1, 1, 0, 0, 0, 0, 1];
z1 = [1, 1, 1, 0, 0, 1, 0];
zone = [1, 2, 3, 4, 5 ,6 ,7];
class = [1, 0, 0, 0, 0, 0, 0];

% Plot the points
figure
plot3(x1, y1, z1, 'bo', 'MarkerSize', 10, 'MarkerFaceColor', 'b');
xlabel('X');
ylabel('Y');
zlabel('Z');
title('3D Plot');

grid on;

for i = 1:numel(x1)
    text(x1(i), y1(i), z1(i), sprintf('(%d, %d, %d), [%d: %d]', ...
         x1(i), y1(i), z1(i), zone(i), class(i)), 'FontSize', 12);
end


% Define the point on the plane and the normal vector
point = [1, 1, 0.4];  
normal_vector = [1, 1, 1];
% Normalize the normal vector
normal_vector = normal_vector / norm(normal_vector);

% Find the constant D
D = -dot(normal_vector, point);

% Define a grid of points
[x, y] = meshgrid(-5:0.1:5, -5:0.1:5);

% Evaluate the plane equation for each point in the grid
z = (-normal_vector(1) * x - normal_vector(2) * y - D) / normal_vector(3);

% Plot the plane
hold on;
surf(x, y, z, 'FaceAlpha', 0.1);

% Set the limits for the axes
xlim([0, 1.1]);
ylim([0, 1.1]);
zlim([0, 1.1]);
