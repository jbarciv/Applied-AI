%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Master in Robotics
%                    Applied Artificial Intelligence
%
% Assinment 3.1:  k-nn and Bayesian Classifier
% Student: Josep Barbera Civera
% ID: 17048
% Date: 11/03/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 0. Load data_D2_C2: p.value and t.value
% 1. Use the nn-classifier for computing the number of 
%   missclassifications errors on p.value and on t.value, 
%   using in both cases p.value as the learning data.
% 2. Same as before using the Bayesian classifier
% 3. Compute the miss-classification error on t.value when
%   using a Bayessian classifier with following a priori
%   probabilities: [1 0.1], [1 2] & [1 10]. Discuss the results.

load data_D2_C2.mat

%% Accesing Data
pvalues = p.value;
plabels = p.class;
tvalues = t.value;
tlabels = t.class;

[Mp, Np] = size(pvalues);
[Mt, Nt] = size(tvalues);

%% Models Trainning
% knn = fitcknn(pvalues', plabels');
% bayes = fitcnb(pvalues', plabels');
% prior = [1 0.1];
% prior = [1 2];
prior = [1 10];
bayes= fitcnb(pvalues', plabels','Prior', prior);

%% Model Prediction: training set
for i=1:Np
    % predKnn(:,i) = predict(knn, pvalues(:,i)');
    predBayes(:,i) = predict(bayes, pvalues(:,i)');
end
pred = predBayes;
%% Confusion matrix plotting
C = confusionmat(plabels',pred');
confusionchart(C);
set(gcf, 'Color', 'white');
saveas(gcf, 'confusion_chart_pvalues_bayes_prior_3.png'); % do not forget to change the name!

%% Model Prediction: test set
for i=1:Nt
    % predKnn(:,i) = predict(knn, tvalues(:,i)');
    predBayes(:,i) = predict(bayes, tvalues(:,i)');
end
pred = predBayes;
%% Confusion matrix plotting
C = confusionmat(tlabels',pred');
confusionchart(C);
set(gcf, 'Color', 'white');
saveas(gcf, 'confusion_chart_tvalues_bayes_prior_3.png'); % do not forget to change the name!

%% pvalues prediction map vs predicted values
% model = knn; 
model = bayes;
x1 = min(pvalues(1,:)):0.01:max(pvalues(1,:));
x2 = min(pvalues(2,:)):0.01:max(pvalues(2,:));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)];
allPred = predict(model,XGrid);

figure
gscatter(XGrid(:,1),XGrid(:,2),allPred,[0.8500 0.3250 0.0980;0 0.4470 0.7410])
hold on

X = pvalues';
y = plabels';

h1 = plot(X(y == 1, 1), X(y == 1, 2), '.', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', "w");
hold on;
h2 = plot(X(y == 2, 1), X(y == 2, 2), '*', 'MarkerSize', 5, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', "w");

xlabel('x')
ylabel('y')
title('{\bf knn classifier - tvalues (validation set)}')
legend([h1, h2], {'Label 1', 'Label 2'}, 'Location', 'best');
legend_box = findobj(gcf, 'Type', 'legend');
set(legend_box, 'Color', [0.8 0.8 0.8]); % Gray background color
axis tight
hold off
set(gcf, 'Color', 'white');
saveas(gcf, 'prediction_map_pvalues_bayes_prior_3.png'); % do not forget to change the name!


%% tvalues prediction map vs predicted values
% model = knn; 
model = bayes;
x1 = min(tvalues(1,:)):0.01:max(tvalues(1,:));
x2 = min(tvalues(2,:)):0.01:max(tvalues(2,:));
[x1G,x2G] = meshgrid(x1,x2);
XGrid = [x1G(:),x2G(:)];
allPred = predict(model,XGrid);

figure
gscatter(XGrid(:,1),XGrid(:,2),allPred,[0.8500 0.3250 0.0980;0 0.4470 0.7410])
hold on

X = tvalues';
y = tlabels';

h1 = plot(X(y == 1, 1), X(y == 1, 2), '.', 'MarkerSize', 10, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', "w");
hold on;
h2 = plot(X(y == 2, 1), X(y == 2, 2), '*', 'MarkerSize', 5, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', "w");

xlabel('x')
ylabel('y')
title('{\bf knn classifier - tvalues (validation set)}')
legend([h1, h2], {'Label 1', 'Label 2'}, 'Location', 'best');
legend_box = findobj(gcf, 'Type', 'legend');
set(legend_box, 'Color', [0.8 0.8 0.8]); % Gray background color
axis tight
hold off
set(gcf, 'Color', 'white');
saveas(gcf, 'prediction_map_tvalues_bayes_prior_3.png'); % do not forget to change the name!


