function runHilbert(varargin)
infile = '';
weighting = '';
outfile = '';
currentArg = 0;
capture = 0;

for i = 1:length(varargin)
  % find which argument we are currently inspecting
  if strcmp(varargin{i}, '-i')
    currentArg = 1;
    capture = 0;
  elseif strcmp(varargin{i}, '-w')
    currentArg = 2;
    capture = 0;
  elseif strcmp(varargin{i}, '-o')
    currentArg = 3;
    capture = 0;
  else
    currentArg = currentArg;
    capture = 1;
  end

  if (currentArg == 1 && capture == 1) %infile
    infile = varargin{i};
  elseif (currentArg == 2 && capture == 1) %analysers
    weighting = varargin{i};
  elseif (currentArg == 3 && capture == 1) %outfile    
    outfile = varargin{i};
  end  
end
  infile
  weighting
  outfile
  
execRunHilbert(infile, weighting, outfile)
end


function execRunHilbert(infile, weighting, outfile)

psysound3;

inTemp = 'runHilbertInput.mat';
copyfile(infile, inTemp);
load(inTemp);
try 
    fhs
catch
    msg = ['The input file does not contain a fileset named ''fhs''. Use the ''Build Input Dataset'' tool to create a fileset.'];
    fprintf(2,msg);
    return
end

objs = '';
for i = 1:length(fhs)
   obj = Hilbert(fhs(i));
   obj.PreFilterWeighting = weighting;
   obj = process(obj, fhs(i), [])
   objs{i} = obj;
end

outTemp = 'runHilbertOutput.mat';

save runHilbertOutput.mat objs;

copyfile(outTemp, outfile);

delete(inTemp, outTemp);

end

