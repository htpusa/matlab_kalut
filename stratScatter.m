function stratScatter(Y,ID,g,order,varargin)

% stratScatter(Y,ID,g,order,varargin)
% 'titleStr'
% 'colours'
% 'markers'
% 
% EXAMPLE
% indVar = [normrnd(0,1,8,1); normrnd(2,1,8,1)];
% ID = string(repmat(1:8,2,1));
% ID = ID(:);
% categ = repmat(["a_1"; "a_2"; "b_1"; "b_2"],4,1);
% order = ["a_1"; "a_2"; "b_1"; "b_2"];
% colours = lines(4);
% colours = [colours(1,:);colours(1,:);colours(2,:);colours(2,:)];
% markers = '.*.*'
% 
% stratScatter(indVar, ID, categ, order, 'colours',colours,...
%         'markers',markers);
%

    titleStr = '';
    colours = [];
    markers = [];

     if ~isempty(varargin)
        if rem(size(varargin, 2), 2) ~= 0
			error('Check optional inputs.');
        else
            for i = 1:2:size(varargin, 2)
                switch varargin{1, i}
					case 'titleStr'
						titleStr = varargin{1, i+1};
                    case 'colours'
                        colours = varargin{1, i+1};
                    case 'markers'
                        markers = varargin{1, i+1};
                    otherwise
						error('Could not recognise optional input names.\nNo input named "%s"',...
							varargin{1,i});
                end
            end
        end
    end

    [uniID I] = unique(ID);
    IDorder = [];
    for i=1:numel(order)
        IDorder = [uniID(g(I)==order(i)); IDorder];
    end
    yval = zeros(numel(ID),1);
    for i=1:numel(ID)
        yval(i) = find(IDorder==ID(i));
    end
    
    defOrd = unique(g,'stable');
    [~,propOrd] = ismember(defOrd,order);
    if max(size(colours))==numel(order)
        colours = colours(propOrd,:);
    end
    if numel(markers)==numel(order)
        markers = markers(propOrd);
    end
    
    gscatter(Y,yval,g,colours,markers);
    axis([min(Y)-0.1 max(Y)+0.1 0 max(yval)+1]);
    xlabel('value');
    ylabel('ID');
    yticks(0:max(yval)+1)
    yticklabels(["";IDorder;""]);
    title(titleStr);
    
    legendEntries = get(gca,'legend');
    legendEntries = legendEntries.String;
    plotHandles = flip(get(gca,'children'));
    [~,legendOrder]=ismember(order,legendEntries);
    legend(plotHandles(legendOrder),legendEntries{legendOrder});
    grid on
    