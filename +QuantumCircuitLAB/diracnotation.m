function output = diracnotation(dm)
% By bernwo on Github. Link: https://github.com/bernwo/
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits1 = ceil(log2(dim(1)));
    bits2 = ceil(log2(dim(2)));
    temp = strings([1,nnz(dm)]);
    counter = 1;
    for k = 1:dim(1)
       for l = 1:dim(2)
           if dm(k,l) ~= 0+0i
               temp(1,counter) = ['(' char(string(dm(k,l))) ')' '|' dec2bin(k-1,bits1) '⟩⟨' dec2bin(l-1,bits2) '|'];
               counter = counter + 1;
           end
       end
    end
    output = strjoin(temp,'+');
end