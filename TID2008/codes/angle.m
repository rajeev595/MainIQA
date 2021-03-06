function theta = angle(Ps, Pt)
    [U1,Gam,V1] = svd(Ps'*Pt);   
    theta = real(acos(diag(Gam)));    
end