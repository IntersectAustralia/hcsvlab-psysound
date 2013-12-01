function psysound_galaxy(funcName, varargin)
    if strcmp(funcName, 'buildFhs')
        disp('running buildFhs')
        buildFhs(varargin{:})
    elseif strcmp(funcName, 'runHilbert')
        disp('running runHilbert')
        runHilbert(varargin{:})   
    elseif strcmp(funcName, 'runSLM')
        disp('running runSLM')
        runSLM(varargin{:})
    elseif strcmp(funcName, 'plotter')
        disp('running plotter')
        plotter(varargin{:}) 
    else
        disp('unknown function')
    end
end 


