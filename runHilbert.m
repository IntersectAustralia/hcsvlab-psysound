function runHilbert(varargin)
infile = ''
weighting = ''
outfile = ''
currentArg = 0
capture = 0

for i = 1:length(varargin)

  % find which argument we are currently inspecting
  if strcmp(varargin{i}, '-i')
    currentArg = 1
    capture = 0
  elseif strcmp(varargin{i}, '-w')
    currentArg = 2
    capture = 0
  elseif strcmp(varargin{i}, '-o')
    currentArg = 3
    capture = 0
  else
    currentArg = currentArg
    capture = 1
  end

  if (currentArg == 1 && capture == 1) %infile
    infile = varargin{i}
  elseif (currentArg == 2 && capture == 1) %analysers
    weighting = varargin{i}
  elseif (currentArg == 3 && capture == 1) %outfile    
    outfile = varargin{i}
  end  


end
  infile
  weighting
  outfile
  
execRunHilbert(infile, weighting, outfile)

end


function execRunHilbert(infile, weighting, outfile)

inTemp = './temp/runHilbertInput.mat'
copyfile(infile, inTemp)
load(inTemp);
fhs

disp('in file:');
disp(infile);
psysound3;

objs = cell(length(fhs), 1)
outputs = cell(2, 1) 

for i = 1:length(fhs)
   obj = Hilbert(fhs(i))
   obj.PreFilterWeighting = weighting;
   obj = process(obj, fhs(i), [])
   objs{i} = obj 
end

outTemp = './temp/runHilbertOutput.mat'

save ./temp/runHilbertOutput.mat objs % can't use a reference to outTemp here

copyfile(outTemp, outfile)

end

