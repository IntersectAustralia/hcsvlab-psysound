function plotter(varargin)
infile = '';
fileIndex = '';
objIndex = '';
outfile = '';
currentArg = 0;
capture = 0;

for i = 1:length(varargin)
  % find which argument we are currently inspecting
  if strcmp(varargin{i}, '-i')
    currentArg = 1;
    capture = 0;
  elseif strcmp(varargin{i}, '-fi')
    currentArg = 2;
    capture = 0;
  elseif strcmp(varargin{i}, '-oi')
    currentArg = 3;
    capture = 0 ;
  elseif strcmp(varargin{i}, '-o')
    currentArg = 4;
    capture = 0;  
  else
    currentArg = currentArg;
    capture = 1;
  end

  if (currentArg == 1 && capture == 1) %infile
    infile = varargin{i};
  elseif (currentArg == 2 && capture == 1) %wChoices
    fileIndex = str2double(varargin{i});
  elseif (currentArg == 3 && capture == 1) %iChoices
    objIndex = str2double(varargin{i});  
  elseif (currentArg == 4 && capture == 1) %ignoreDelay
    outfile = varargin{i};  
  end  
end

infile 
fileIndex
objIndex
outfile 

execPlotter(infile, fileIndex, objIndex, outfile)
end


function execPlotter(infile, fileIndex, objIndex, outfile)

psysound3;

inTemp = 'plotterInput.mat';
copyfile(infile, inTemp);
load(inTemp);
try 
    objs
catch
    msg = ['The input file (' infile ') does not contain data objects named ''objs''. Use an audio analyer tool to create data objects.'];
    fprintf(2,msg);
    return
end

%check file exists
fileDims = length(objs);
if (fileIndex > fileDims)
	msg = ['File Index (' int2str(fileIndex) ') out of bounds. There are only ' int2str(fileDims) ' files.'];
	fprintf(2,msg);
	return;
end

file = objs{fileIndex}
objDims = size(file.output);

if (objIndex > objDims)
	msg = ['Object Index (' int2str(objIndex) ') out of bounds. The selected file has only ' int2str(objDims) ' objects.'];
	fprintf(2,msg);
	return;
end

obj = objs{fileIndex}.output{objIndex}
f=figure('visible','off')
plot(obj)

outTemp = 'plotterOutput.jpg';
saveas(f, outTemp);
close(f);
copyfile(outTemp, outfile)
delete(inTemp, outTemp)

end

