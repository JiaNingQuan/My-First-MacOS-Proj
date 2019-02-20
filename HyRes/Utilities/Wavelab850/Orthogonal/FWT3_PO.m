function wc = FWT3_PO(x,L,qmf)
% FWT3_PO -- 3-d MRA wavelet transform (periodized, orthogonal)
%  Usage
%    wc = FWT3_PO(x,L,qmf)
%  Inputs
%    x     3-d object (n by n by n array, n dyadic)
%    L     coarse level
%    qmf   quadrature mirror filter
%  Outputs
%    wc    3-d wavelet transform
%
%  Description
%    A three-dimensional Wavelet Transform is computed for the
%    array x.  To reconstruct, use IWT3_PO.
%
%  See Also
%    IWT3_PO, MakeONFilter
%
[n,J] = cubelength(x);
wc = x;
nc = n;
for jscal=J-1:-1:L,
    top = (nc/2+1):nc;    bot = 1:(nc/2);
    for ix=1:nc,
        for iy = 1:nc,
            row = wc(ix,iy,1:nc);
            rowsq=squeeze(row)';
            wc(ix,iy,bot) = DownDyadLo(rowsq,qmf)';
            wc(ix,iy,top) = DownDyadHi(rowsq,qmf)';
        end
    end
    %----------------------------------------
    for ix=1:nc,
        for iz = 1:nc,
            row = wc(ix,1:nc,iz);
            wc(ix,top,iz) = DownDyadHi(row,qmf);
            wc(ix,bot,iz) = DownDyadLo(row,qmf);
        end
    end
    %----------------------------------------
    for iy=1:nc,
        for iz = 1:nc,
            row = wc(1:nc,iy,iz)';
            wc(top,iy,iz) = DownDyadHi(row,qmf)';
            wc(bot,iy,iz) = DownDyadLo(row,qmf)';
        end
    end
    %-----------------------------------------
    nc = nc/2;
end

%
% Copyright (c) 1993. David L. Donoho
%
% 3-D Modification Vicki Yang and Brani Vidakovic
%                  ISyE, GaTech 2002.
