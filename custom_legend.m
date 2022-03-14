function hF = custom_legend(labels, colors)

hF = figure('position', [1000         656         392         393]); 

hA = axes(hF, 'position', [0.1 0.1 0.5 0.9]); 
axes(hA); hold on;
set(hA, 'xcolor', 'none', 'ycolor', 'none');
c = colors; % color
l = labels; % label
m = 0.9; % margin factr
assert(length(c)==length(l));
for i = 1:length(c)
    if any(isnan(c(i, :)))
        rectangle(hA, 'position', [-1, -i, 1*m, 1*m], 'facecolor', 'none', 'edgecolor', 'none');
        text(hA, 0, -i+0.5, ['  ' l{i}], 'fontsize', 24, ...
            'horizontalalignment', 'left', ...
            'verticalalignment', 'middle');        
        continue;
    end
    
    rectangle(hA, 'position', [-1, -i, 1*m, 1*m], 'facecolor', c(i, :));
    text(hA, 0, -i+0.5, ['  ' l{i}], 'fontsize', 24, ...
        'horizontalalignment', 'left', ...
        'verticalalignment', 'middle');
end

% text(hA, 0, -(i+1)+0.5, sprintf('  clstr cutoff=%0.2f', cutoff), 'fontsize', 24, ...
%         'horizontalalignment', 'left', ...
%         'verticalalignment', 'middle');

hT = findobj(get(hA, 'children'), 'type', 'text'); 
pos = [get(hT, 'extent')];
pos = vertcat(pos{:});
pos = [pos(:, 1:2), pos(:, 1:2)+pos(:, 3:4)];
x = [pos(:, 1); pos(:, 3)]; 
y = [pos(:, 2); pos(:, 4)]; 

xl = xlim();
yl = ylim();
x = [x(:); xl(:)]; 
y = [y(:); yl(:)]; 

xlim([min(x), max(x)]);
ylim([min(y), max(y)]);