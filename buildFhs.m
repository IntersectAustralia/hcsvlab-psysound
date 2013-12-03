
function buildFhs(varargin)
%interpret the args as arrays: infiles, coeffs, outfile

infiles = {};
outfile = '';
coeffs = {};
currentArg = 0;
capture = 0;

for i = 1:length(varargin)
  % find which argument we are currently inspecting
  if strcmp(varargin{i}, '-i')
    currentArg = 1;
    capture = 0;
  elseif strcmp(varargin{i}, '-c')
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
    infiles{length(infiles) + 1} = varargin{i};
  elseif (currentArg == 2 && capture == 1) %coeffs
    coeffs{length(coeffs) + 1} = str2double(varargin{i});
  elseif (currentArg == 3 && capture == 1) %outfile    
    outfile = varargin{i};
  end  
end

infiles
coeffs
outfile
execBuildFhs(infiles, coeffs, outfile)
end


function execBuildFhs(infiles, coeffs, outfile)

psysound3;
outTemp = 'buildFhsOutput.mat';

fhs = readData(infiles);
for i = 1:length(coeffs)
  fhs(i).calCoeff = coeffs{i}
end

save buildFhsOutput.mat fhs
copyfile(outTemp, outfile);
delete(outTemp);

end
