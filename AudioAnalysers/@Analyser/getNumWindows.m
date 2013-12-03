function num = getNumWindows(obj, varargin)
% GETNUMWINDOWS Calculates the total number of windows that we will
%               slide.

% xxx - make sure every case is covered
samples = obj.samples;

if nargin > 1
  wl = varargin{1};
  ov = varargin{2};
else
  wl = get(obj, 'windowLength');
  ov = obj.overlap
  if isnumeric(ov) == 0
      ov = ov.size
  end    
end 
    

num = ceil((samples+wl/2)./(wl - ov));

%
