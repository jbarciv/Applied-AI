%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Master in Robotics
%         Applied Artificial Intelligence
%
% Assinment 1.3: Printing Digits
% Student: Josep Barbera Civera
% ID: 17048
% Date: 03/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Given a 784x10000 matrix, where each column represents a 28x28 image of
% handwritten digits. We iterete until finding two different images of the
% same number. For x diferent numbers.

load Trainnumbers.mat


image = Trainnumbers.image;
labels = Trainnumbers.label;

% The handwritten digits go from 0 to 9.
times = 4; % define here the number of digits to be displayed.

already_seen = zeros(1,times) + 10;
my_numbers = zeros(1,2*times) + 10;

% Vectors init
already_seen(1) = labels(1);
my_numbers(1) = 1;

k = 2;
l = 1;
for i = 1:times
    for j = k:length(labels)
        if labels(j) == already_seen(i)
            my_numbers(2*i) = j;
            break;
        end
    end
    for k = l:length(labels)
        if already_seen(i) == labels(k)
            continue;
        else
            break;
        end
    end
    if i == 4
        break;
    end
    already_seen(i+1) = labels(k);
    my_numbers(2*i+1) = k;
    k = k + 1;
    l = k;
end

figure;
for a = 1:length(my_numbers)
    subplot(2,4,a);
    for i = 1:28
        for j = 1:28
            digit(i,j) = image((i-1)*28+j,my_numbers(a));
        end
    end
    imshow(digit);
    title(['Image ' num2str(my_numbers(a)) ' with number ' num2str(labels(my_numbers(a)))]);
end

sgtitle('Displaying 4 repeated numbers from the Matrix');

spacing = 0.02; % You can adjust this value
set(gcf, 'Position', get(0, 'Screensize')); % Maximize the figure
set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
set(gcf, 'Units', 'Normalized', 'InnerPosition', [spacing spacing 1-2*spacing 1-2*spacing]);

saveas(gcf, 'output_figure.png');

