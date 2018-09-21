% 
%    path='G:\fyproject\jaffeimages\jaffe'
%    ListOfImageNames = {};
%    ImagesToSave = struct();
%    ImageFiles = dir([path '\*.*']); % Get all files.
% %    length(ImageFiles)
%    for Index = 3:length(ImageFiles)-1
%        baseFileName = ImageFiles(Index).name;
%        [folder, name, extension] = fileparts(baseFileName);
%        extension = upper(extension);
%        
%        % Let's save just those we are interested in:
%        switch lower(extension)
%            case {'.png', '.bmp', '.jpg', '.tiff','.tif', '.avi'}
%                % Allow only PNG, TIF, JPG, or BMP image
%                s2=strcat(path,'\',baseFileName)
%                ListOfImageNames = [ListOfImageNames baseFileName];
%                ImagesToSave.(name) = imread(s2);
%            otherwise
%        end
%    end
%      save('G:\fyproject\jaffeimages\testimagebase.mat','-struct','ImagesToSave');

for K = 1 : 215
  filename = sprintf('G:\\fyproject\\jaffeimages\\jaffe\\%d.tiff', K);
  I = imread(filename);
  imgs(K).image = I;
end
save('G:\fyproject\jaffeimages\ImageDatabase.mat', 'imgs');
% load('G:\fyproject\jaffeimages\ImageDatabase.mat');


% happy emotions mat files
for h = 1 : 41
  filename = sprintf('G:\\fyproject\\jaffeimages\\happy\\1 (%d).tiff',h);
  I_h = imread(filename);
  imgs_h(h).image = I_h;
end
save('G:\fyproject\jaffeimages\HappyDatabase.mat', 'imgs_h');
load('G:\fyproject\jaffeimages\HappyDatabase.mat');


%sad emotions mat files
for s = 1 : 174
  filename = sprintf('G:\\fyproject\\jaffeimages\\sad\\2 (%d).tiff',h);
  I_s = imread(filename);
  imgs_s(s).image = I_s;
end
save('G:\fyproject\jaffeimages\SadDatabase.mat', 'imgs_s');
% load('G:\fyproject\jaffeimages\SadDatabase.mat');


imDir = fullfile(matlabroot,'toolbox','vision','visiondata','happy');
addpath(imDir)

negativeFolder = fullfile(matlabroot,'toolbox','vision','visiondata','sad');

% trainCascadeObjectDetector('emotionDetector.xml',negativeFolder,'FalseAlarmRate',0.2,'NumCascadeStages',5);
