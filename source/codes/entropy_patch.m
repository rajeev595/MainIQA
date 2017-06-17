function ent = entropy_patch(patch,no_bins)
    if(nargin < 2)
        if(~exist('no_bins','var'))
            no_bins = 64;
        end
    end
    [counts,binlocations] = imhist(patch,no_bins);
    prob = counts/sum(counts);
    ent = -prob.*log2(prob);
    ent(isnan(ent)) = [];
    ent = sum(ent);
end