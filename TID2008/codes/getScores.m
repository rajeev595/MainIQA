function getScores(w,distortion, data, PathToData, PathToResults)
    if(data == 1)        
        if(distortion == 1)
            PathToScores = strcat(PathToResults,'LIVE/jp2k/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/jp2k/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/jp2k/PCA/');         % Path to PCA
            noImages = 227;
        elseif(distortion == 2)
            PathToScores = strcat(PathToResults,'LIVE/jpeg/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/jpeg/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/jpeg/PCA/');         % Path to PCA
            noImages = 233;
        elseif(distortion == 3)
            PathToScores = strcat(PathToResults,'LIVE/wn/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/wn/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/wn/PCA/');         % Path to PCA
            noImages = 174;
        else
            PathToScores = strcat(PathToResults,'LIVE/gblur/');          % Path to Scores
            PathToPatches = strcat(PathToData,'LIVE/gblur/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'LIVE/gblur/PCA/');         % Path to PCA
            noImages = 174;
        end
    elseif(data == 2)
        if(distortion == 1)
            PathToScores = strcat(PathToResults,'TID/jp2k/');          % Path to Scores
            PathToPatches = strcat(PathToData,'TID/jp2k/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'TID/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            PathToScores = strcat(PathToResults,'TID/jpeg/');          % Path to Scores
            PathToPatches = strcat(PathToData,'TID/jpeg/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'TID/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            PathToScores = strcat(PathToResults,'TID/wn/');          % Path to Scores
            PathToPatches = strcat(PathToData,'TID/wn/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'TID/wn/PCA/');         % Path to PCA
        else
            PathToScores = strcat(PathToResults,'TID/gblur/');          % Path to Scores
            PathToPatches = strcat(PathToData,'TID/gblur/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'TID/gblur/PCA/');         % Path to PCA
        end
    elseif(data == 3)
        if(distortion == 1)
            PathToScores = strcat(PathToResults,'CSIQ/jp2k/');          % Path to Scores
            PathToPatches = strcat(PathToData,'CSIQ/jp2k/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'CSIQ/jp2k/PCA/');         % Path to PCA
        elseif(distortion == 2)
            PathToScores = strcat(PathToResults,'CSIQ/jpeg/');          % Path to Scores
            PathToPatches = strcat(PathToData,'CSIQ/jpeg/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'CSIQ/jpeg/PCA/');         % Path to PCA
        elseif(distortion == 3)
            PathToScores = strcat(PathToResults,'CSIQ/wn/');          % Path to Scores
            PathToPatches = strcat(PathToData,'CSIQ/wn/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'CSIQ/wn/PCA/');         % Path to PCA
        else
            PathToScores = strcat(PathToResults,'CSIQ/gblur/');          % Path to Scores
            PathToPatches = strcat(PathToData,'CSIQ/gblur/patches/'); % Path to Patches        
            PathToPCA = strcat(PathToData,'CSIQ/gblur/PCA/');         % Path to PCA
        end
    end
    
    f = sprintf('W%d/Source_PCA.mat',w);
    f = strcat('E:/MATLABe/GeoPath/DataForScores/', f);
    d = load(f);
    Ps = d.s_coeff;
    
    files = dir(strcat(PathToPatches, '*.mat'));
    scores = [];
   
    for i = 1 : 100
%% Local Score calculation
        f = files(i).name;
        f = strcat(PathToPatches, f);
        load(f);
        
        [Pt, alpha, ~] = pca(Xt');
                        
        theta = angle(Ps,Pt)*10^9;                   % Angle of rotation from Ps to Pt
        thetaE = alpha .* repmat(theta', [size(alpha,1),1]);    % Effective Angles of rotation
    % All metrics
        score_FS = mean(acos(prod(cos(thetaE),2)));     % Fubini-Study metric
        Ac2 = 2*sin(thetaE/2);                          % Chordal 2-norm Matrix
        score_c2 = mean(sqrt(diag(Ac2*Ac2')));          % Chordal 2-norm metric
        score_g = mean(sqrt(diag(thetaE*thetaE')));     % Geodesic metric
        Ac = sin(thetaE);                               % Chordal Matrix   
        score_c = mean(sqrt(diag(Ac*Ac')));             % Chordal Metric
        score_p2 = mean(max(sin(thetaE),[],2));         % Projection 2-norm Metric
        
%% Global Score calculation
        G = GFK(Ps, Pt);
        [U, Gamma, ~] = svd(G); % SVD of GFK
        M = U*(Gamma.^0.5);     % Interaction Matrix        
        
        scoreG = norm(M(:), 1);        
        
        scores = [scores; score_FS, score_c2, score_g, score_c, score_p2, scoreG];
        
        str = sprintf('%d/100 images completed \n', i);
        disp(str);
    end
% Saving the Scores
    saveScore = strcat(PathToScores, 'QualityScores.mat');
    save(saveScore, 'scores');
end