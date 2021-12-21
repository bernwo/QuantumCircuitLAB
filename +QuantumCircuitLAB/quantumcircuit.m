function output = quantumcircuit(n_qubits)
% By bernwo on Github. Link: https://github.com/bernwo/
    assert( n_qubits >= 1 , 'The number of qubits must be at least 1!' );
    ket0 = [1 ; 0];
    output = ket0;
    for i = 2:n_qubits
        output = kron(output,ket0);
    end
    output = output*output';
end