function output = resetchannel(dm,targ)
% By bernwo on Github. Link: https://github.com/bernwo/
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( targ <= bits , 'Invalid target index entered!' );
    M0 = kron( kron( eye(2^(targ-1)) , [1 0;0 0] ) , eye(2^(bits-targ)) );
    M1 = kron( kron( eye(2^(targ-1)) , [0 1;0 0] ) , eye(2^(bits-targ)) );
    M1ct = kron( kron( eye(2^(targ-1)) , [0 0;1 0] ) , eye(2^(bits-targ)) );
    output = M0*dm*M0 + M1*dm*M1ct;
end