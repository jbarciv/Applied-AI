%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%               Master in Robotics
%         Applied Artificial Intelligence
%
% Assinment 2.1: Scatter Matrices
% Student: Josep Barbera Civera
% ID: 17048
% Date: 12/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% load data_D2_C2
% - Compute the scatter matrices S1, S2, SW, SB, ST and their traces
% - Compute the same matrices for the normalized data and their traces

load data_D2_C2.mat

%% Plotting Data
% plot(p.value(1,1:100),p.value(2,1:100),'+'); hold all;
% plot(p.value(1,101:300),p.value(2,101:300),'+');

%% Accesing Data
pvalues = p.value;
plabels = p.class;
tvalues = t.value;
tlabels = t.class;
%% Not normalized data
disp("------------------------ Not Normalized Data ------------------------")
disp("----- P Values -----")
pmatrices = Scatter_matrices(pvalues, plabels);
S1 = pmatrices{1}
trace1 = trace(S1)
S2 = pmatrices{2}
trace2 = trace(S2)
Sw = pmatrices{3}
trace_Sw = trace(Sw)
Sb = pmatrices{4}
trace_Sb = trace(Sb)
St = pmatrices{5}
trace_St = trace(St)

disp("----- T Values -----")
tmatrices = Scatter_matrices(tvalues, tlabels);
S1 = tmatrices{1}
trace1 = trace(S1)
S2 = tmatrices{2}
trace2 = trace(S2)
Sw = tmatrices{3}
trace_Sw = trace(Sw)
Sb = tmatrices{4}
trace_Sb = trace(Sb)
St = tmatrices{5}
trace_St = trace(St)

%% Normalized data
disp("------------------------ Normalized Data ------------------------")
[~, N] = size(pvalues);
[~, Nt] = size(tvalues);
meanp = mean(pvalues')';
stdp = std(pvalues')';
for i = 1:N
    pn(:,i) = (pvalues(:,i) - meanp)./stdp;
end
meant = mean(tvalues')';
stdt = std(tvalues')';
for i = 1:Nt
    tn(:,i) = (tvalues(:,i) - meant)./stdt;
end

disp("----- P Values -----")
pmatrices = Scatter_matrices(pn, plabels);
S1 = pmatrices{1}
trace1 = trace(S1)
S2 = pmatrices{2}
trace2 = trace(S2)
Sw = pmatrices{3}
trace_Sw = trace(Sw)
Sb = pmatrices{4}
trace_Sb = trace(Sb)
St = pmatrices{5}
trace_St = trace(St)

disp("----- T Values -----")
tmatrices = Scatter_matrices(tn, tlabels);
S1 = tmatrices{1}
trace1 = trace(S1)
S2 = tmatrices{2}
trace2 = trace(S2)
Sw = tmatrices{3}
trace_Sw = trace(Sw)
Sb = tmatrices{4}
trace_Sb = trace(Sb)
St = tmatrices{5}
trace_St = trace(St)

% Scatter_matrices waits a struct with a vector of data points (i.e. 2x100)
% (coordinates) and a vector with a label associated to this vector 
% (i.e. 1x100).

function matrix_cell = Scatter_matrices(values, labels)
        % first we compute the number of labels
        unique_labels = unique(labels);
        N = length(unique_labels);
        % now we create as many vectors as labels: with cell arrays
        vectors_cell = cell(1, N);
        matrix_cell = cell (1, N+3);

        for i = 1:N
            label = unique_labels(i);
            indices = labels == label; % Find indices corresponding to the current label
            vectors_cell{i} = values(:, indices); % Store coordinates associated with the label
        end
        % Scatter matrix for each group is computed
        for i = 1:N
            data = vectors_cell{i};
            Sc = cov(data')*(length(data)-1);
            matrix_cell{i} = Sc;
        end
        % Scatter matrix within the groups is computed
        Sw = zeros(N);
        for i = 1:N
            Sw = Sw + matrix_cell{i};
        end
        s = N + 1;
        matrix_cell{s} = Sw;
        % Scatter matrix between the groups is computed
        Sb = zeros(N);
        m_x = mean(values(1,:));
        m_y = mean(values(2,:));
        m = [m_x; m_y];
        for i = 1:N
            data = vectors_cell{i};
            m_c_x = mean(data(1,:));
            m_c_y = mean(data(2,:));
            m_c = [m_c_x; m_c_y];
            Sb = Sb + length(data)*(m_c-m)*(m_c-m).';
        end
        s = s + 1;
        matrix_cell{s} = Sb;
        % Total Scatter matrix is computed
        St = (values - m)*(values - m).';
        s = s + 1;
        matrix_cell{s} = St;
end


