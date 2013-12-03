function runSLM(varargin)
infile = '';
wChoices = '';
iChoices = '';
ignoreDelay = true;
outfile = '';
currentArg = 0;
capture = 0;

for i = 1:length(varargin)
  % find which argument we are currently inspecting
  if strcmp(varargin{i}, '-i')
    currentArg = 1;
    capture = 0;
  elseif strcmp(varargin{i}, '-wc')
    currentArg = 2;
    capture = 0;
  elseif strcmp(varargin{i}, '-ic')
    currentArg = 3;
    capture = 0 ;
  elseif strcmp(varargin{i}, '-d')
    currentArg = 4;
    capture = 0;
  elseif strcmp(varargin{i}, '-o')
    currentArg = 5;
    capture = 0;
  else
    currentArg = currentArg;
    capture = 1;
  end

  if (currentArg == 1 && capture == 1) %infile
    infile = varargin{i};
  elseif (currentArg == 2 && capture == 1) %wChoices
    wChoices = varargin{i};
  elseif (currentArg == 3 && capture == 1) %iChoices
    iChoices{length(iChoices) + 1} = varargin{i};  
  elseif (currentArg == 4 && capture == 1) %ignoreDelay
    ignoreDelay = varargin{i};
  elseif (currentArg == 5 && capture == 1) %outfile    
    outfile = varargin{i};
  end  
end

%split into array on commas.
wChoices = strrep(wChoices, ',', '');
wChoices = strrep(wChoices, ' ', '');

%split into array on commas.
iChoices1 = '';
iChoices2 = '';

if (length(iChoices) > 0)
  iChoices1 = regexp(iChoices{1},',','split');
end 
if (length(iChoices) > 1)
  iChoices2 = regexp(iChoices{2},',','split');
end  
iChoices = horzcat(iChoices1, iChoices2); %make iChoices a string

infile
wChoices
iChoices
ignoreDelay
outfile
  
execRunSLM(infile, wChoices, iChoices, ignoreDelay, outfile)
end


function execRunSLM(infile, wChoices, iChoices, ignoreDelay, outfile)

psysound3;

inTemp = 'runSLMInput.mat';
copyfile(infile, inTemp);
load(inTemp);
try 
    fhs
catch
    msg = ['The input file does not contain a fileset named ''fhs''. Use the ''Build Input Dataset'' tool to create a fileset.'];
    fprintf(2,msg);
    return
end

for i = 1:length(fhs)
fh = fhs(i);
slmObj = SLM(fh);
slmObj = setIgnoreDelay(slmObj, ignoreDelay);
slmObj.wChoices = wChoices';
slmObj.iChoices = iChoices;
slmObj = process(slmObj, fh, [])
objs{i} = slmObj ;
end

outTemp = 'runSLMOutput.mat';
save runSLMOutput.mat objs;

copyfile(outTemp, outfile);

delete(inTemp, outTemp);

end
