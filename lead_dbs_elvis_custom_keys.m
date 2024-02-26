function [] = lead_dbs_elvis_custom_keys(hF)
%% Latane Bullock 2024 01 15--used as a lead_dbs modifier
% must have lead_dbs electrode-scene open 
% then, in command line, call lead_dbs_elvis_custom_keys(gcf)

set(hF, 'KeyPressFcn', @Key_Down);

    function Key_Down(src, event)
        d = getappdata(src);
        switch event.Key
            case 'r'
                disp('Keypress: r, rotate tool activate')
                set(d.uibjs.rotate3dtog, 'state', 'on')
            case 's'
                disp('Keypress: s, slide tool activate')
                set(d.uibjs.slide3dtog, 'state', 'on')
        end

    end

end