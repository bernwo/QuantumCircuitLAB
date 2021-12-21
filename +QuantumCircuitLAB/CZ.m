function output = CZ(dm,ctrl,targ)
% By bernwo on Github. Link: https://github.com/bernwo/
    assert( ctrl ~= targ , 'The control and the target qubit must be different!' );
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( max(ctrl,targ) <= bits , 'Invalid control or target index entered!' );
    function out = applyCZ(dm,bits)
        single_cz_gate = [1 0 0 0;0 1 0 0;0 0 1 0;0 0 0 -1];
        cz_projector = kron( single_cz_gate , eye(2^(bits-2)) );
        out = cz_projector*dm*cz_projector';
    end
    swap_projector = getswap(ctrl,targ,bits);
    output = swap_projector' * applyCZ(swap_projector * dm * swap_projector',bits) * swap_projector;
end

function swap_projector = getswap(ctrl,targ,bits)
    % Reference for constructing swap gate: https://arxiv.org/pdf/1711.09765.pdf
    % Constructing swap gate between ctrl qubit and the 1st qubit in the density
    % matrix.
    P0 = [1 0; 0 0]; % ket0*bra0
    L1 = [0 0; 1 0]; % ket1*bra0
    L0 = [0 1; 0 0]; % ket0*bra1
    P1 = [0 0; 0 1]; % ket1*bra1
    
    n_ctrl = ctrl; % this is 'n' in the reference paper linked above this file.
    n_minus_one_factor_ctrl = 2^(n_ctrl-1-1); % n_minus_one_factor = 1 means swap one time the qubits which are adjacent to each other.
    
    if n_minus_one_factor_ctrl < 1
        ctrl_swap = 1;
    else
        ctrl_dim = 2^n_ctrl;
        ctrl_swap = zeros(ctrl_dim);
        P0_ctrl = kron( eye(n_minus_one_factor_ctrl) , P0 );
        L1_ctrl = kron( eye(n_minus_one_factor_ctrl) , L1 );
        L0_ctrl = kron( eye(n_minus_one_factor_ctrl) , L0 );
        P1_ctrl = kron( eye(n_minus_one_factor_ctrl) , P1 );

        ctrl_swap(1:ctrl_dim/2 , 1:ctrl_dim/2) = P0_ctrl;
        ctrl_swap(ctrl_dim/2+1:ctrl_dim , 1:ctrl_dim/2) = L0_ctrl;
        ctrl_swap(1:ctrl_dim/2 , ctrl_dim/2+1:ctrl_dim) = L1_ctrl;
        ctrl_swap(ctrl_dim/2+1:ctrl_dim , ctrl_dim/2+1:ctrl_dim) = P1_ctrl;
        ctrl_swap = kron(ctrl_swap,eye(2^(bits-n_ctrl)));
    end

    % Constructing swap gate between target qubit and the 2nd qubit in the density
    % matrix.
    if targ == 1
        n_targ = ctrl - 2 + 1; % this is 'n' in the reference paper linked above this file.
    else
        n_targ = targ - 2 + 1; % this is 'n' in the reference paper linked above this file.
    end
    n_minus_one_factor_targ = 2^(n_targ-1-1); % n_minus_one_factor = 1 means swap one time the qubits which are adjacent to each other.

    if n_minus_one_factor_targ < 1
        targ_swap = 1;
    else
        targ_dim = 2^n_targ;
        targ_swap = zeros(targ_dim);
        P0_targ = kron( eye(n_minus_one_factor_targ) , P0 );
        L1_targ = kron( eye(n_minus_one_factor_targ) , L1 );
        L0_targ = kron( eye(n_minus_one_factor_targ) , L0 );
        P1_targ = kron( eye(n_minus_one_factor_targ) , P1 );

        targ_swap(1:targ_dim/2 , 1:targ_dim/2) = P0_targ;
        targ_swap(targ_dim/2+1:targ_dim , 1:targ_dim/2) = L0_targ;
        targ_swap(1:targ_dim/2 , targ_dim/2+1:targ_dim) = L1_targ;
        targ_swap(targ_dim/2+1:targ_dim , targ_dim/2+1:targ_dim) = P1_targ;
        targ_swap = kron( eye(2) , targ_swap );
        targ_swap = kron(targ_swap,eye(2^(bits-n_targ-1)));
    end
    swap_projector = targ_swap*ctrl_swap;
end