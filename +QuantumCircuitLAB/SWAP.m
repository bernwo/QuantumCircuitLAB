function output = SWAP(dm,qubits_indices)
% By bernwo on Github. Link: https://github.com/bernwo/
    % Reference for constructing swap gate: https://arxiv.org/pdf/1711.09765.pdf
    % Constructing swap gate between qubits_indices(1) and the qubits_indices(2) in the density
    % matrix.
    assert( length(qubits_indices) == 2 , 'Invalid qubits entered! Please enter only 2 qubits to swap.' );
    assert( qubits_indices(1) ~= qubits_indices(2) , 'Invalid qubits entered! The 2 qubits must be different for them to swap with each other.' );
    dim = size(dm);
    assert( (length(dim) == 2) && (dim(1) == dim(2)) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( bits >= 2 , 'Need more than 1 qubit!' );
    assert( (max(qubits_indices) <= bits) && (min(qubits_indices) >= 1) , 'Invalid qubits entered! Please valid qubits within range only.' );
    P0 = [1 0; 0 0]; % ket0*bra0
    L1 = [0 0; 1 0]; % ket1*bra0
    L0 = [0 1; 0 0]; % ket0*bra1
    P1 = [0 0; 0 1]; % ket1*bra1
    
    sorted_qubits_indices = sort(qubits_indices);
    
    n = sorted_qubits_indices(2) - sorted_qubits_indices(1) + 1; % this is 'n' in the reference paper linked above this file.
    n_minus_one_factor = 2^(n-1-1); % n_minus_one_factor = 1 means swap one time the qubits which are adjacent to each other.
    
    if n_minus_one_factor < 1
        swap_projector = 1;
    else
        swap_projector_dim = 2^n;
        swap_projector = zeros(swap_projector_dim);
        P0_padded = kron( eye(n_minus_one_factor) , P0 );
        L1_padded = kron( eye(n_minus_one_factor) , L1 );
        L0_padded = kron( eye(n_minus_one_factor) , L0 );
        P1_padded = kron( eye(n_minus_one_factor) , P1 );

        swap_projector(1:swap_projector_dim/2 , 1:swap_projector_dim/2) = P0_padded;
        swap_projector(swap_projector_dim/2+1:swap_projector_dim , 1:swap_projector_dim/2) = L0_padded;
        swap_projector(1:swap_projector_dim/2 , swap_projector_dim/2+1:swap_projector_dim) = L1_padded;
        swap_projector(swap_projector_dim/2+1:swap_projector_dim , swap_projector_dim/2+1:swap_projector_dim) = P1_padded;
        swap_projector = kron( eye(2^(sorted_qubits_indices(1)-1)) , swap_projector );
        swap_projector = kron(swap_projector,eye(2^(bits-n-(sorted_qubits_indices(1)-1))));
    end
    output = swap_projector*dm*swap_projector';
end