function output = H(dm,qubits_indices)
% By bernwo on Github. Link: https://github.com/bernwo/
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( max(qubits_indices) <= bits , 'Invalid qubits_indices entered!' );
    single_h_gate = [1/sqrt(2) 1/sqrt(2);1/sqrt(2) -1/sqrt(2)];
    single_id_gate = eye(2);
    temp = zeros(bits, 2, 2);
    
    for k = 1:bits
        if ismember(k,qubits_indices)
            temp(k,:,:) = single_h_gate;
        else
            temp(k,:,:) = single_id_gate;
        end
    end
    
    projector = squeeze(temp(1,:,:));
    for j = 2:bits
        projector = kron(projector,squeeze(temp(j,:,:)));
    end
    
    output = projector * dm * projector';
end