%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Master in Robotics
%         Applied Artificial Intelligence
%
% Assinment 1.2: Plotting 2D Input Data
% Student: Josep Barbera Civera
% ID: 17048
% Date: 03/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load data_D2_C3_O1.mat
% 
% % Plot data with a color depending on the class
% x = p.value(1,:);
% y = p.value(2, :);
% 
% red = true;
% blue = true;
% green = true;
% 
% figure;
% legendHandles = cell(1, 3);
% 
% for i = 1:length(x)
%     disp(i)
% 
%     if p.class(i) == 1
%         h = plot(x(i),y(i),'ro');
%         if red
%             legendHandles{1} = h;
%             red = false;
%         end
%     elseif p.class(i) == 2
%         h = plot(x(i),y(i),'go');
%         if green
%             legendHandles{2} = h;
%             green = false;
%         end
%     elseif p.class(i) == 3
%         h = plot(x(i),y(i),'bo');
%         if blue
%             legendHandles{3} = h;
%             blue = false;
%         end
%     else
%         disp("There are more than 3 labels!")
%     end
%     hold on;
% 
% end
% 
% title('Plottin 2D Input Data');
% xlabel('X-axis');
% ylabel('Y-axis');
% legend([legendHandles{:}], 'Location', 'Best');
% saveas(gcf, 'my_plot.png');

load data_D2_C3_O1.mat

x = p.value(1,:);
y = p.value(2, :);

colors = {'ro', 'go', 'bo'};
labels = {'Class 1', 'Class 2', 'Class 3'};

figure;

for i = 1:length(x)
    if p.class(i) > 0 && p.class(i) <= 3
        plot(x(i), y(i), colors{p.class(i)});
        hold on;
    else
        disp("Invalid class label detected!");
    end
end

title('2D Input Data Plot');
xlabel('X-axis');
ylabel('Y-axis');
legend(labels, 'Location', 'Best');
saveas(gcf, 'my_plot.png');

