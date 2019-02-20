function x = IWT3_PO(wc,L,qmf)
% IWT3_PO -- Inverse 3-d MRA wavelet transform (periodized, orthogonal)
%  Usage
%    x = IWT3_PO(wc,L,qmf)
%  Inputs
%    wc    3-d wavelet transform [n by n by n array, n dyadic]
%    L     coarse level
%    qmf   quadrature mirror filter
%  Outputs
%    x     3-d signal reconstructed from wc
%
%  Description
%    If wc is the result of a forward 3d wavelet transform, with
%    wc = FWT3_PO(x,L,qmf), then x = IWT3_PO(wc,L,qmf) reconstructs x
%    exactly if qmf is a nice qmf, e.g. one made by MakeONFilter.
%
%  See Also
%    FWT3_PO, MakeONFilter
%
	[n,J] = cubelength(wc);
	x = wc; 
	nc = 2^(L+1);
	for jscal=L:J-1,
		top = (nc/2+1):nc; bot = 1:(nc/2); all = 1:nc;
		for iy=1:nc,
            for iz=1:nc,
            x(all,iy,iz) = UpDyadLo(x(bot,iy,iz),qmf)...
			             + UpDyadHi(x(top,iy,iz),qmf); 
            
            end
		end
 %---------------------------------------------------------------------
		for ix=1:nc,
            for iy=1:nc,
			x(ix,iy,all) = UpDyadLo(x(ix,iy,bot),qmf)'  ... 
					     + UpDyadHi(x(ix,iy,top),qmf)';
            end     
		end
 %----------------------------------------------------------------------
        for ix=1:nc,
            for iz=1:nc,
			x(ix,all,iz) = UpDyadLo(x(ix,bot,iz),qmf)  ... 
					     + UpDyadHi(x(ix,top,iz),qmf);
            end
        end
%-------------------------------------------------------------------------
        nc = 2*nc;
	end
    
     
% 
% Copyright (c) 1993. David L. Donoho
%     
% 3-D Modification Vicki Yang and Brani Vidakovic
%                  ISyE, GaTech 2002.
    

    