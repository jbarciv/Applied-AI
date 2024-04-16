%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Master in Robotics
%                    Applied Artificial Intelligence
%
% Assinment 5.2:  Function Generalization - MLP
% Student: Josep Barbera Civera
% ID: 17048
% Date: 14/04/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1.- Choose an adequate MLP structure and training set. 
%   Plot in the same figure the training set, the output of the MLP
%   for the test set, and the ground truth sin function.
% 
% Evaluate the evolution of the train error, the test error and 
%   the ground truth error in the following cases:
% 
% 2.- Changing the training parameters:  
%   initial values, (# of epochs, optimization algorithm)
% 
% 3.- Changing the training data: 
%   # of samples (order of samples)
% 
% 4.- Changing the net structure: 
%   # of neurons

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1. Training set, MLP structure and initial plots
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
generate_data = false;              %%%%% <- change here as needed! %%%%%
plot_specific_MLP_training = false; %%%%% <- change here as needed! %%%%%
if(generate_data)
    %% Training data (N_train, x_train, y_train)
    N_train = 50;
    x_train = linspace(0, 2*pi, N_train); 
    for i = 1:N_train
         y_train(i) = sin(x_train(i)) + normrnd(0, 0.1);
    end
    
    %% Test data (N_test, x_test, y_test, y_gtruth)
    N_test = 1000;
    x_test = linspace(0, 2*pi, N_test);
    y_gtruth = sin(x_test); % ground truth
    for i = 1:N_test
         y_test(i) = y_gtruth(i) + normrnd(0, 0.1);
    end
end

if(plot_specific_MLP_training)
    %% MLP structure
    trainFcn = 'trainlm';
    hiddenSizes = 4;
    net = feedforwardnet (hiddenSizes, trainFcn);
    %% MLP training
    [net, tr] = train(net, x_train, y_train);
    %% MLP testing
    % Test error
    MLP_test = net(x_test); 
    perf_test = perform(net,y_test, MLP_test);
    % Train error
    MLP_train = net(x_train);
    perf_train = perform(net,y_train,MLP_train );
    % Ground truth error
    perf_gtruth = perform(net, y_gtruth, MLP_test);
    
    
    %% Plot data
    % Plot training data
    plot(x_train, y_train, 'b.', 'DisplayName', "training data"); 
    hold on;
    % Plot test data
    s1 = scatter(x_test, y_test, 5,'DisplayName', "test data", ...
                'MarkerFaceColor','g','MarkerEdgeColor','g');
    alpha(s1,.1)
    hold on;
    % Plot truth data
    plot(x_test, y_gtruth, 'r-', 'DisplayName', "Sin(x)");
    hold on;
    % Plot MLP output for test data
    plot(x_test, MLP_test, 'k-', 'DisplayName', "MLP output");
    title("MLP training");
    my_subtitle = sprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f", ...
                            perf_test, perf_train, perf_gtruth);
    subtitle(my_subtitle);
    xlabel("x");
    ylabel("y");
    legend("training data", "test data", "Sin(x)", "MLP output");
    figure_name = sprintf("test_error_%.3g_train_error_%.3g_gtruth_error_%.3g.png", ...
                            perf_test, perf_train, perf_gtruth);
    saveas(gcf, figure_name);
    hold off;
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 2. Net structure
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder_name = "net_structure";
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

generate_data_2 = false; %%%%% <- change here as needed! %%%%%

if(generate_data_2)
    %% Training data (N_train, x_train, y_train)
    N_train = 50;
    x_train = linspace(0, 2*pi, N_train); 
    for i = 1:N_train
         y_train(i) = sin(x_train(i)) + normrnd(0, 0.1);
    end
    
    %% Test data (N_test, x_test, y_test, y_gtruth)
    N_test = 1000;
    x_test = linspace(0, 2*pi, N_test);
    y_gtruth = sin(x_test); % ground truth
    for i = 1:N_test
         y_test(i) = y_gtruth(i) + normrnd(0, 0.1);
    end
end

test_net_structure = false; %%%%% <- change here as needed! %%%%%
neurons = 1:50;
if (test_net_structure)
    for i = 1:numel(neurons)
        fprintf("Training with %d neurons in the hidden layer\n", neurons(i));
        trainFcn = 'trainlm';
        net = feedforwardnet (neurons(i), trainFcn);
        net.trainParam.epochs = 1000;
        
        for j = 1:5
            [net, tr] = train(net, x_train, y_train);
            % Test error
            MLP_test = net(x_test); 
            error_t(j) = mean((y_test-MLP_test).^2);
            % per_error_t = perform(net, y_test, MLP_test);
            % Train error
            MLP_train = net(x_train);
            error_tr(j) = mean((y_train-MLP_train).^2);
            % per_error_tr = perform(net, y_train, MLP_train);
            % Ground truth error
            error_gt(j) = mean((y_gtruth-MLP_test).^2);
            % per_error_gt = perform(net, y_gtruth, MLP_test);
            % fprintf(['Error_t: %f, Percent Error_t: %f, Error_tr: %f, ' ...
            %     'Percent Error_tr: %f, Error_gt: %f, Percent Error_gt: %f\n'], ...
            %     error_t(j), per_error_t, error_tr(j), per_error_tr, ...
            %     error_gt(j), per_error_gt);
        end
        test_error(i) = mean(error_t);
        train_error(i) = mean(error_tr);
        gtruth_error(i) = mean(error_gt);
        % Plot training data
        plot(x_train, y_train, 'b.', 'DisplayName', "training data"); 
        hold on;
        % Plot test data
        s1 = scatter(x_test, y_test, 5,'DisplayName', "test data", ...
                     'MarkerFaceColor','g','MarkerEdgeColor','g');
        alpha(s1,.1)
        hold on;
        % Plot truth data
        plot(x_test, y_gtruth, 'r-', 'DisplayName', "Sin(x)");
        hold on;
        % Plot MLP output for test data
        plot(x_test, MLP_test, 'k-', 'DisplayName', "MLP output");
        my_title = sprintf("%d neurons", neurons(i));
        title(my_title);
        my_subtitle = sprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f", ...
                              test_error(i), train_error(i), gtruth_error(i));
        subtitle(my_subtitle);
        xlabel("x");
        ylabel("y");
        legend("training data", "test data", "Sin(x)", "MLP output");
        hold off;
        figure_name = sprintf("/%d_neurons_in_MLP.png", neurons(i));
        saveas(gcf, strcat(folder_name, figure_name));
        fprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f\n", ...
                test_error(i), train_error(i), gtruth_error(i));
        disp("***********************************");
    end
    % Plot errors
    plot(neurons, test_error, 'g-', 'LineWidth', 2, 'DisplayName', 'Test Error');
    hold on;
    plot(neurons, train_error, 'b-', 'LineWidth', 2, 'DisplayName', 'Train Error');
    plot(neurons, gtruth_error, 'r-', 'LineWidth', 2, 'DisplayName', 'Ground Truth Error');
    
    % Title and labels
    title('Errors vs. Number of Neurons in Hidden Layer');
    xlabel('Number of Neurons');
    ylabel('Error');
    legend('Location', 'best');
    
    % Adjust figure
    grid on;
    figure_name = sprintf("/error_plot.png");
    saveas(gcf, strcat(folder_name, figure_name));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 3. Number of samples
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder_name = "samples_number";
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

test_samples_number = false; %%%%% <- change here as needed! %%%%%
if (test_samples_number)

    %% Test data (N_test, x_test, y_test, y_gtruth) (only once)
    N_test = 1000;
    x_test = linspace(0, 2*pi, N_test);
    y_gtruth = sin(x_test); % ground truth
    for i = 1:N_test
         y_test(i) = y_gtruth(i) + normrnd(0, 0.1);
    end
    
    %% Net structure
    trainFcn = 'trainlm';
    net = feedforwardnet (5, trainFcn);
    net.trainParam.epochs = 50;
    net.trainParam.min_grad = 1e-10;
    net.trainParam.max_fail = 50;
    net.trainParam.goal = 0;
    net.trainParam.showWindow = false;

    data_number = 5:5:100;
    for i = 1:numel(data_number)
        %% Training data (N_train, x_train, y_train)
        N_train = data_number(i);
        disp(N_train)
        x_train = linspace(0, 2*pi, N_train); 
        for k = 1:N_train
             y_train(k) = sin(x_train(k)) + normrnd(0, 0.1);
        end

        fprintf("Training with %d samples\n", data_number(i));

        for j = 1:5
            [net, tr] = train(net, x_train, y_train);
            % Test error
            MLP_test = net(x_test); 
            error_t(j) = mean((y_test - MLP_test).^2);
            % Train error
            MLP_train = net(x_train);
            error_tr(j) = mean((y_train - MLP_train).^2);
            % Ground truth error
            error_gt(j) = mean((y_gtruth - MLP_test).^2);
        end

        test_error(i) = mean(error_t);
        train_error(i) = mean(error_tr);
        gtruth_error(i) = mean(error_gt);
        % Plot training data
        plot(x_train, y_train, 'b.', 'DisplayName', "training data"); 
        hold on;
        % Plot test data
        s1 = scatter(x_test, y_test, 5,'DisplayName', "test data", ...
                     'MarkerFaceColor','g','MarkerEdgeColor','g');
        alpha(s1,.1)
        hold on;
        % Plot truth data
        plot(x_test, y_gtruth, 'r-', 'DisplayName', "Sin(x)");
        hold on;
        % Plot MLP output for test data
        plot(x_test, MLP_test, 'k-', 'DisplayName', "MLP output");
        my_title = sprintf("%d samples", data_number(i));
        title(my_title);
        my_subtitle = sprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f", ...
                              test_error(i), train_error(i), gtruth_error(i));
        subtitle(my_subtitle);
        xlabel("x");
        ylabel("y");
        legend("training data", "test data", "Sin(x)", "MLP output");
        hold off;
        figure_name = sprintf("/%d_samples_in_MLP.png", data_number(i));
        saveas(gcf, strcat(folder_name, figure_name));
        fprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f\n", ...
                test_error(i), train_error(i), gtruth_error(i));
        disp("***********************************");
    end
    % Plot errors
    plot(data_number, test_error, 'g-', 'LineWidth', 2, 'DisplayName', 'Test Error');
    hold on;
    plot(data_number, train_error, 'b-', 'LineWidth', 2, 'DisplayName', 'Train Error');
    plot(data_number, gtruth_error, 'r-', 'LineWidth', 2, 'DisplayName', 'Ground Truth Error');
    
    % Title and labels
    title('Errors vs. Number of Samples in the Training Set');
    xlabel('Number of Training Samples');
    ylabel('Error');
    legend('Location', 'best');
    
    % Adjust figure
    grid on;
    figure_name = sprintf("/error_plot.png");
    saveas(gcf, strcat(folder_name, figure_name));
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 4. Initial Values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
folder_name = "initial_values";
if ~exist(folder_name, 'dir')
    mkdir(folder_name);
end

test_initial_values = true; %%%%% <- change here as needed! %%%%%
if (test_initial_values)
    %% Training data (N_train, x_train, y_train)
    N_train = 50;
    disp(N_train)
    x_train = linspace(0, 2*pi, N_train); 
    for i = 1:N_train
         y_train(i) = sin(x_train(i)) + normrnd(0, 0.1);
    end
    %% Test data (N_test, x_test, y_test, y_gtruth) (only once)
    N_test = 1000;
    x_test = linspace(0, 2*pi, N_test);
    y_gtruth = sin(x_test); % ground truth
    for i = 1:N_test
         y_test(i) = y_gtruth(i) + normrnd(0, 0.1);
    end
    
    %% Net structure
    trainFcn = 'trainlm';
    net = feedforwardnet (5, trainFcn);
    net.trainParam.epochs = 50;
    net.trainParam.min_grad = 1e-10;
    net.trainParam.max_fail = 50;
    net.trainParam.goal = 0;
    net.trainParam.showWindow = false;
    initial_values = 1:100;
    for i = 1:numel(initial_values)
        fprintf("Training in the %d iteration\n", initial_values(i));
        [net, tr] = train(net, x_train, y_train);
        % Test error
        MLP_test = net(x_test); 
        test_error(i) = mean((y_test - MLP_test).^2);
        % Train error
        MLP_train = net(x_train);
        train_error(i) = mean((y_train - MLP_train).^2);
        % Ground truth error
        gtruth_error(i) = mean((y_gtruth - MLP_test).^2);

        % Plot training data
        plot(x_train, y_train, 'b.', 'DisplayName', "training data"); 
        hold on;
        % Plot test data
        s1 = scatter(x_test, y_test, 5,'DisplayName', "test data", ...
                     'MarkerFaceColor','g','MarkerEdgeColor','g');
        alpha(s1,.1)
        hold on;
        % Plot truth data
        plot(x_test, y_gtruth, 'r-', 'DisplayName', "Sin(x)");
        hold on;
        % Plot MLP output for test data
        plot(x_test, MLP_test, 'k-', 'DisplayName', "MLP output");
        my_title = sprintf("Training number %d", initial_values(i));
        title(my_title);
        my_subtitle = sprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f", ...
                              test_error(i), train_error(i), gtruth_error(i));
        subtitle(my_subtitle);
        xlabel("x");
        ylabel("y");
        legend("training data", "test data", "Sin(x)", "MLP output");
        hold off;
        figure_name = sprintf("/%d_initial_values_in_MLP.png", initial_values(i));
        % saveas(gcf, strcat(folder_name, figure_name));
        fprintf("test error: %.4f, train error: %.4f, gtruth error: %.4f\n", ...
                test_error(i), train_error(i), gtruth_error(i));
        disp("***********************************");
    end
    % Plot errors
    plot(initial_values, test_error, 'g-', 'LineWidth', 2, 'DisplayName', 'Test Error');
    hold on;
    plot(initial_values, train_error, 'b-', 'LineWidth', 2, 'DisplayName', 'Train Error');
    plot(initial_values, gtruth_error, 'r-', 'LineWidth', 2, 'DisplayName', 'Ground Truth Error');
    
    % Title and labels
    title('Errors vs. Initial values sets');
    xlabel('Initial values sets');
    ylabel('Error');
    legend('Location', 'best');
    
    % Adjust figure
    grid on;
    figure_name = sprintf("/error_initial_values.png");
    saveas(gcf, strcat(folder_name, figure_name));
end

