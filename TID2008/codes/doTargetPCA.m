function doTargetPCA(distortion,data, PathToResults)

    if(data == 1)        
        if(distortion == 1)       
            mkdir(strcat(PathToResults,'LIVE/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/jp2k/PCA/');         % Path to PCA
            noImages = 227;
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'LIVE/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/jpeg/PCA/');         % Path to PCA
            noImages = 233;
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'LIVE/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/wn/PCA/');         % Path to PCA
            noImages = 174;
        else
            mkdir(strcat(PathToResults,'LIVE/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'LIVE/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'LIVE/gblur/PCA/');         % Path to PCA
            noImages = 174;
        end
    elseif(data == 2)
        if(distortion == 1)    
            mkdir(strcat(PathToResults,'TID/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'TID/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'TID/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/wn/PCA/');         % Path to PCA
        else
            mkdir(strcat(PathToResults,'TID/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'TID/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'TID/gblur/PCA/');         % Path to PCA
        end
    elseif(data == 3)
        if(distortion == 1)       
            mkdir(strcat(PathToResults,'CSIQ/jp2k'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/jp2k/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            mkdir(strcat(PathToResults,'CSIQ/jpeg'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/jpeg/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            mkdir(strcat(PathToResults,'CSIQ/wn'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/wn/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/wn/PCA/');         % Path to PCA
        else
            mkdir(strcat(PathToResults,'CSIQ/gblur'),'PCA');             % Directory for PCA
            PathToPatches = strcat(PathToResults,'CSIQ/gblur/patches/'); % Path to Patches
            PathToPCA = strcat(PathToResults,'CSIQ/gblur/PCA/');         % Path to PCA
        end
    end
   
    files = dir(strcat(PathToPatches, '*.mat'));
    
    for i = 1 : 100
        f = files(i).name;
        f = strcat(PathToPatches, f);           % Adding the path to the patch
        load(f);                                % Loading the patch
        clear f
        [t_coeff,t_score,~] = pca(Xt');         % Performing PCA
    % Saving the PCA
        f = strsplit(files(i).name, 'Patches_');
        f = strcat('PCA_', f(2));
        f = strcat(PathToPCA, f);
        f = f{1};
        save(f,'t_coeff','t_score');
    % Clearing the coefficients for next image
        clear f
        clear t_coeff
        clear t_score
    end
end