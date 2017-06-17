function getTargetPatches(w,no_target_patches,entropy_thresh,distortion,data, PathToResults)
  
    if(data == 1)    
        mkdir(PathToResults,'LIVE');                                    % Directory for results on LIVE
        if(distortion == 1)        
            mkdir(strcat(PathToResults,'LIVE'),'jp2k');                 % Directory for jp2k        
            mkdir(strcat(PathToResults,'LIVE/jp2k'),'patches');         % Directory for patches            
            PathToImgs = '../../Database/LIVE/data/jp2k/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'LIVE/jp2k/patches/'); % Path to Patches            
            noImages = 227;
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'LIVE'),'jpeg');                 % Directory for jpeg        
            mkdir(strcat(PathToResults,'LIVE/jpeg'),'patches');         % Directory for patches            
            PathToImgs = '../../Database/LIVE/data/jpeg/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'LIVE/jpeg/patches/'); % Path to Patches
            noImages = 233;            
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'LIVE'),'wn');                 % Directory for wn        
            mkdir(strcat(PathToResults,'LIVE/wn'),'patches');         % Directory for patches            
            PathToImgs = '../../Database/LIVE/data/wn/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'LIVE/wn/patches/'); % Path to Patches
            noImages = 174;
        else
            mkdir(strcat(PathToResults,'LIVE'),'gblur');                 % Directory for gblur
            mkdir(strcat(PathToResults,'LIVE/gblur'),'patches');         % Directory for patches            
            PathToImgs = '../../Database/LIVE/data/gblur/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'LIVE/gblur/patches/'); % Path to Patches
            noImages = 174;
        end
    elseif(data == 2)
        mkdir(PathToResults,'TID');                                    % Directory for results on LIVE
        if(distortion == 1)        
            mkdir(strcat(PathToResults,'TID'),'jp2k');                 % Directory for jp2k        
            mkdir(strcat(PathToResults,'TID/jp2k'),'patches');         % Directory for patches            
            PathToImgs = 'Database/TID/data/jp2k/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'TID/jp2k/patches/'); % Path to Patches            
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'TID'),'jpeg');                 % Directory for jpeg        
            mkdir(strcat(PathToResults,'TID/jpeg'),'patches');         % Directory for patches            
            PathToImgs = 'Database/TID/data/jpeg/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'TID/jpeg/patches/'); % Path to Patches          
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'TID'),'wn');                 % Directory for wn        
            mkdir(strcat(PathToResults,'TID/wn'),'patches');         % Directory for patches            
            PathToImgs = 'Database/TID/data/wn/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'TID/wn/patches/'); % Path to Patches
        else
            mkdir(strcat(PathToResults,'TID'),'gblur');                 % Directory for gblur
            mkdir(strcat(PathToResults,'TID/gblur'),'patches');         % Directory for patches            
            PathToImgs = 'Database/TID/data/gblur/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'TID/gblur/patches/'); % Path to Patches
        end
    elseif(data == 3)
        mkdir(PathToResults,'CSIQ');                                    % Directory for results on LIVE
        if(distortion == 1)        
            mkdir(strcat(PathToResults,'CSIQ'),'jp2k');                 % Directory for jp2k        
            mkdir(strcat(PathToResults,'CSIQ/jp2k'),'patches');         % Directory for patches            
            PathToImgs = 'Database/CSIQ/data/jp2k/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'CSIQ/jp2k/patches/'); % Path to Patches            
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'CSIQ'),'jpeg');                 % Directory for jpeg        
            mkdir(strcat(PathToResults,'CSIQ/jpeg'),'patches');         % Directory for patches            
            PathToImgs = 'Database/CSIQ/data/jpeg/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'CSIQ/jpeg/patches/'); % Path to Patches          
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'CSIQ'),'wn');                 % Directory for wn        
            mkdir(strcat(PathToResults,'CSIQ/wn'),'patches');         % Directory for patches            
            PathToImgs = 'Database/CSIQ/data/wn/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'CSIQ/wn/patches/'); % Path to Patches
        else
            mkdir(strcat(PathToResults,'CSIQ'),'gblur');                 % Directory for gblur
            mkdir(strcat(PathToResults,'CSIQ/gblur'),'patches');         % Directory for patches            
            PathToImgs = 'Database/CSIQ/data/gblur/';              % Path to Images        
            PathToPatches = strcat(PathToResults,'CSIQ/gblur/patches/'); % Path to Patches
        end
    end
  
    for i=1:noImages
        Xt = [];                                    % Initializing the target data to empty matrix
        img = sprintf('img%d.bmp',i);               % Reading the image name
        img = strcat(PathToImgs,img);               % Adding path of image to name   
        I = imread(img);                            % Reading the image  
        I = rgb2gray(I);                            % Converting the Color image to Grayscale
        P = getPatchesDict(I,w,entropy_thresh);     % Extracting the patches from the image   
        noPatches = size(P,2);                      % Extracting the no of patches    
    % Selecting the patches randomly
        if(noPatches < no_target_patches)
            patchIndcs = randsample(noPatches,noPatches);
        else
            patchIndcs = randsample(noPatches,no_target_patches);
        end    
        Xt = [Xt P(:,patchIndcs)];                  % Adding the Patches to target data matrix
    % Saving the patches
        Patches = sprintf('Patches_img%d.mat',i);        
        Patches = strcat(PathToPatches,Patches);
        save(Patches,'Xt');
    end
end