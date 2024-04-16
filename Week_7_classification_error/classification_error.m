%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           Master in Robotics
%                    Applied Artificial Intelligence
%
% Assinment 4.1:  Classification Error
% Student: Josep Barbera Civera
% ID: 17048
% Date: 06/04/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 0. Complete the code in order to evaluate the classification
% errors (both training and test) using a Bayesian classifier for an
% increasing number of training samples. 
% 1. Draw the resulting figure.


load data_D2_C2.mat;

[D, N] = size(p.value); 
[D, Nt] = size(t.value);

ns = 10:10:N;
nt2a = 400;
for i = 1:length(ns)
    nsi = ns(i);
    for j = 1:nt2a
        ind_rand = randperm(N); 
        ind = ind_rand(1:nsi);
        while ( (length(find(p.class(:,ind) == 1)) < 3) || ...
                (length(find(p.class(:,ind) == 2)) < 3) )
            ind_rand = randperm(N); 
            ind = ind_rand(1:nsi); 
        end
        bayMdl = fitcnb( p.value(:,ind)', p.class(:,ind)' );
        bayclass_train = predict( bayMdl, p.value(:, ind)');
        bayclass_test = predict( bayMdl, t.value');
        error_train(j,i)=length(find(bayclass_train' ~= p.class(:, ind)));
        error_test(j,i) = length(find(bayclass_test' ~= t.class ));
    end
    error_train_m(i) = mean(error_train(:,i)) / nsi;
    error_test_m(i) = mean(error_test(:,i)) / Nt;
end

plot(ns, error_train_m, 'b', ns, error_test_m, 'g');
legend('train error', 'test error');
xlabel('# of training samples');
 saveas(gca, "trainin_and_test_error.png");


