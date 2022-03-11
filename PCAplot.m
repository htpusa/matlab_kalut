function PCAplot(X, labels, varargin)

% PCAplot(X, labels)
% PCAplot(X, labels, order)
%
% EXAMPLE
% load fisheriris
% PCAplot(meas,species)
% 
% load discrim
% PCAplot(ratings,group)

    if isempty(varargin)
        order = [];
    else
        order = varargin{1};
    end

    [~,score,~,~,explained] = pca(X);
    comps = reshape(1:8,2,4)';
    figure
    for i=1:floor(numel(explained)/2)
        subplot(2,2,i);
        gscatter(score(:, comps(i,1)), score(:, comps(i,2)), labels, ...
            lines(numel(unique(labels))))
        xlabel(sprintf('PC%d: %f %% of variance',...
            comps(i,1),explained(comps(i,1))))
        ylabel(sprintf('PC%d: %f %% of variance',...
            comps(i,2),explained(comps(i,2))))

        if ~isempty(order)
            legendEntries = get(gca,'legend');
            legendEntries = legendEntries.String;
            plotHandles = flip(get(gca,'children'));
            [~,legendOrder]=ismember(order,legendEntries);
            legend(plotHandles(legendOrder),legendEntries{legendOrder});
        end
    end