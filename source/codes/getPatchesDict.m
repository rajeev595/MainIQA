function P = getPatchesDict(I,w,entropy_thresh)
% This function extracts small patches from an image using a sliding window
% Input:    I = image
%           w = patch size

% Output:   P = image patches (as vectors)
% mean not removed.
    
%     tic

% Size of the image
    [m, n] = size(I);
    stride = 4;
    
    % patch locations
    x = w/2 : stride : m -(w/2);
    y = w/2 : stride : n -(w/2);
    [dY, dX] = meshgrid(y, x);
    [r, c] = size(dX);
    
    % extract the patches
    P = [];
    % Converting to double
    I = im2double(I);
    
    for i=1 : r
        for j=1 : c
            px = dX(i, j);
            py = dY(i, j);
            p = I(px - (w/2) + 1 : px + (w/2), py - (w/2) + 1 : py + (w/2));
            
            % Excluding the patches with entropy less than threshold
            if(entropy_patch(p) > entropy_thresh)
                P = [P reshape(p, w^2 , 1)];               
            end
        end
    end
    
%     toc
end



