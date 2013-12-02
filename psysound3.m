function psysound3
% PSYSOUND3
% 
% This wrapper function checks to make sure PsySound3 is
% installed and then opens the GUI

% Check to see if PsySound3 is on the path
p = path;

if ~exist('temp', 'dir')
  mkdir('temp');
end

if ~isempty(findstr(p, 'psysound3')) 
  try
    getPsysound3Prefs; % CHECK IF PREFERENCES ARE THERE (May not be if PsySound paths added manually)
  catch
    configPsySound3;
  end
  disp('Starting PsySound3. ');
  disp('Please read README File distributed with Software.');
  disp('PsySound is BETA Software. Use at your own risk.');
  
  %PsySoundGUI;
else
  fprintf(['PsySound3 does not seem to be configured, configuring before proceeding.\n']);
  configPsySound3;
  %PsySoundGUI;
end


function configPsySound3
% CONFIGPSYSOUND3
% 
% Adds appropriate PsySound3 directories to the path and checks Matlab
% version. You only need to do this once.
%
% Note: You MUST be in the PsySound3 directory for this function to
%       work
% This finds the path of the configPsySound3 MFILE
folderpath = fileparts(mfilename('fullpath'));

% If not the same then move to correct directory
if ~strcmp(pwd,folderpath) 
    cd (folderpath)
end
    

% Add the PsySound3 dir
addpath(pwd);

try  
    prefs = getPsysound3Prefs;
    fprintf('Preferences already set up.\n');
catch
    prefs.dataDir = [folderpath filesep 'PsySoundData'];
    fprintf('Setting up Preferences...\n');
    fprintf(['Setting data folder to: \t'  [folderpath filesep 'PsysoundData'] '\nYou can change this using File>>Preferences in the PsySound3 GUI.\n']);
    prefs.showWaitBar= 0;
    prefs.multiChannelType= 1;
    prefs.multiChannelSelect= 1;
    prefs.combineChannels= 1;
    prefs.calibrationIndex= {1; 0; 0};
    prefs.calibrationLvl = '70';
    setPsysound3Prefs(prefs);
end
    


% Subfunction to parser the version string. This is based on the
% verLessThan.m file in Matlab 7.4
function parts = getParts(V)
parts = sscanf(V, '%d.%d.%d')';
    if length(parts) < 3
      parts(3) = 0; % zero-fills to 3 elements
    end
    

