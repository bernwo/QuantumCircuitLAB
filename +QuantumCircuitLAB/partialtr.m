function output = partialtr(dm,qubits_to_traceout)
% By bernwo on Github. Link: https://github.com/bernwo/
    ket0 = [1;0];
    ket1 = [0;1];
    loclength = length(qubits_to_traceout);
    assert( loclength >= 1 , 'The given input for qubits_to_traceout is invalid!' );
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( loclength < bits , 'The given input for qubits_to_traceout is invalid!' );
    assert( max(qubits_to_traceout) <= bits , 'The given input for qubits_to_traceout is invalid!' );
    assert( min(qubits_to_traceout) >= 1 , 'The given input for qubits_to_traceout is invalid!' );
    single_id_gate = eye(2);
    sorted_loc = sort(qubits_to_traceout,'descend');
    
    output = dm;
    for counter = 1:loclength
        k_dim = bits+1-counter;
        if sorted_loc(counter) == 1
            k0_projector = ket0;
            k1_projector = ket1;
        else
            k0_projector = single_id_gate;
            k1_projector = single_id_gate;
        end
        for k = 2:k_dim
            if k == sorted_loc(counter)
                k0_projector = kron(k0_projector,ket0);
                k1_projector = kron(k1_projector,ket1);
            else
                k0_projector = kron(k0_projector,single_id_gate);
                k1_projector = kron(k1_projector,single_id_gate);
            end
        end
        b0_projector = k0_projector';
        b1_projector = k1_projector';
        
        output = b0_projector*output*k0_projector + b1_projector*output*k1_projector;
    end
end