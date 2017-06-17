function spearmanScore(distortion,data,PathToResults)

    if(data == 1)
        load('Database/LIVE/dmos.mat');
        if(distortion == 1)
        % Path to Correlation Scores
            pathToScores = strcat(PathToResults,'LIVE/jp2k/');
            dmos = dmos(1 : 227);
            orgs = orgs(1 : 227);
        elseif(distortion == 2)
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'LIVE/jpeg/');
            dmos = dmos(228 : 460);
            orgs = orgs(228 : 460);
        elseif(distortion == 3)
        % Path to Correlation Scores        
            pathToScores = strcat(PathToResults,'LIVE/wn/');
            dmos = dmos(461 : 634);
            orgs = orgs(461 : 634);
        else
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'LIVE/gblur/');
            dmos = dmos(635 : 808);
            orgs = orgs(635 : 808);
        end
    elseif(data == 2)
        if(distortion == 1)        
        % Path to Correlation Scores
            pathToScores = strcat(PathToResults,'TID/jp2k/');
        % Loading DMOS for jp2k
            load('../../Database/TID/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'TID/jpeg/');
       % Loading DMOS for jpeg
            load('../../Database/TID/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
        % Path to Correlation Scores        
            pathToScores = strcat(PathToResults,'TID/wn/');
            load('../../Database/TID/DMOS/dmos_WN.mat');
        else
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'TID/gblur/');
            load('../../Database/TID/DMOS/dmos_GBLUR.mat');
        end
    elseif(data == 3)
        if(distortion == 1)        
        % Path to Correlation Scores
            pathToScores = strcat(PathToResults,'CSIQ/jp2k/');
        % Loading DMOS for jp2k
            load('../results/CSIQ/DMOS/dmos_JP2K.mat');
        elseif(distortion == 2)
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'CSIQ/jpeg/');
       % Loading DMOS for jpeg
            load('../results/CSIQ/DMOS/dmos_JPEG.mat');
        elseif(distortion == 3)
        % Path to Correlation Scores        
            pathToScores = strcat(PathToResults,'CSIQ/wn/');
            load('../results/CSIQ/DMOS/dmos_AWGN.mat');
        else
        % Path to Correlation Scores            
            pathToScores = strcat(PathToResults,'CSIQ/gblur/');
            load('../results/CSIQ/DMOS/dmos_BLUR.mat');
        end
    end

% DMOS values for only distorted images
    f = strcat(pathToScores,'QualityScores.mat');   % Adding Path to scores name
    load(f);                                        % Loading the Scores
    
    scores_FS = scores(:,1);        % Fubini Study Scores
    scores_c2 = scores(:,2);        % Chordal 2-norm metric
    scores_g = scores(:,3);         % Geodesic metric
    scores_c = scores(:,4);         % Chordal metric
    scores_p2 = scores(:,5);        % p2 norm metric
    scores_G = scores(:,6);         % Global scores
    
    sroccEnergy_FS = corr(scores_FS, dmos, 'Type', 'Spearman');
    sroccEnergy_c2 = corr(scores_c2, dmos, 'Type', 'Spearman');
    sroccEnergy_g  = corr(scores_g, dmos, 'Type', 'Spearman');
    sroccEnergy_c  = corr(scores_c, dmos, 'Type', 'Spearman');
    sroccEnergy_p2 = corr(scores_p2, dmos, 'Type', 'Spearman');
    sroccEnergy_G = corr(scores_G, dmos, 'Type', 'Spearman');
    
    saveCorr = strcat(pathToScores, 'CorrelationScores.mat');
    save(saveCorr, 'sroccEnergy_FS','sroccEnergy_c2','sroccEnergy_g',...
        'sroccEnergy_c','sroccEnergy_p2','sroccEnergy_G');
end