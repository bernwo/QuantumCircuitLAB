function output = densitymatrix(varargin)
% By bernwo on Github. Link: https://github.com/bernwo/
    output = QuantumCircuitLAB.ket(varargin{:})*QuantumCircuitLAB.ket(varargin{:})';
end