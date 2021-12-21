# QuantumCircuitLAB - A quantum computing MATLAB Package

`QuantumCircuitLAB` is a basic quantum computing package written in `MATLAB`. It is basic in the sense that it does not have advanced features such as noisy gates or built-in quantum algorithm examples. The user is encouraged to build those advanced features on top of the existing basic framework by themselves. The user is expected to be well-read in linear algebra and quantum information theory.

Advantage of this package is that the user would be able to leverage the computational speed of `MATLAB` compared to using other languages such as `Python`. In my own experience, I've found that the speed of doing similar computations in `Python` *(even with `Numba`)* is way too slow.

*Warning: The package does not automatically check if you have enough RAM, so don't try to initialise a density matrix that has size ~100 qubits. It will most likely freeze your PC.:)*

## How to use this package?

Download the `+QuantumCircuitLAB` folder and put it in your current working directory of your `MATLAB`.

Then, to make sure that you don't have to type the namespace `QuantumCircuitLAB.somefunction`, you can import all the functions in the package by placing this line of code at the top of your `MATLAB` script:
```MATLAB
import QuantumCircuitLAB.*

% Your code...
```

The examples shown below assumes that you have performed the above importing line.

## Functions and their usage

The functions that are provided by this package are as listed below (in no particular order):

* `ket`
    * *Example #1*
        > ```MATLAB
        > % Initialise statevector |000⟩.
        > a = ket(0,0,0);
        > ```
    * *Example #2*
        > ```MATLAB
        > % Initialise statevector |0+-⟩.
        > a = ket(0,'+','-');
        > ```
* `bra`
    * *Example #1*
        > ```MATLAB
        > % Initialise statevector ⟨000|.
        > a = bra(0,0,0);
        > ```
    * *Example #2*
        > ```MATLAB
        > % Initialise statevector ⟨0+-|.
        > a = bra(0,'+','-');
        > ```
* `quantumcircuit` - *Initialise (|0⟩⟨0|)^(⊗n)*.
    * *Example*
        > ```MATLAB
        > % Initialise density matrix of state (|0⟩⟨0|)^(⊗n) where n is the number of qubits.
        > n = 5;
        > a = quantumcircuit(n);
        > ```
* `densitymatrix` - *Initialise arbitrary density matrix*.
    * *Example*
        > ```MATLAB
        > % Initialise density matrix of state |010+-⟩⟨010+-|.
        > a = densitymatrix(0,1,0,'+','-');
        > ```
* `depolarisingchannel` - *(see equation (8) in [10.1103/PhysRevX.10.021071](https://doi.org/10.1103/PhysRevX.10.021071))*.
    * *Example*
        > ```MATLAB
        > % Applying depolarisingchannel on a single qubit of a multi-qubit system.
        > qubits = [1 2 3]; % qubits' indices.
        > error = 0.5; % 0 <= error <= 1.
        > a = densitymatrix(0,0,0);
        > b = depolarisingchannel(a,qubits(1),error); % apply depolarisingchannel on the 1st qubit.
        > ```
* `resetchannel` - *Resets target qubit back to state |0⟩*.
    * *Example*
        > ```MATLAB
        > % Applying resetchannel on a single qubit of a multi-qubit system.
        > qubits = [1 2]; % qubits' indices.
        > a = densitymatrix(1,'+'); % state |1+⟩⟨1+|.
        > b = resetchannel(a,qubits(2)); % apply resetchannel on the 2nd qubit. b is now |10⟩⟨10|.
        > ```
* `fidelity`
    * *Example*
        > ```MATLAB
        > % Compute the fidelity given two arbitrary density matrices.
        > qubits = [1 2]; % qubits' indices.
        > a = densitymatrix(1,'+'); % state |1+⟩⟨1+|.
        > b = depolarisingchannel(a,qubits(1),0.01);
        > f = fidelity(a,b); % compute the fidelity of a against b.
        > ```
* `partialtr` - *Partial trace*.
    * *Example*
        > ```MATLAB
        > % Take partial trace of a over some qubit(s).
        > qubits = [1 2 3]; % qubits' indices.
        > a = densitymatrix(1,1,0); % state |1+⟩⟨1+|.
        > b = partialtr(a,[qubits(1) qubits(3)]); % apply partial trace over qubits 1 and 3. Resulting density matrix is of dimension 2×2 since two qubits have been thrown away.
        > ```
* `diracnotation`
    * *Example*
        > ```MATLAB
        > % Using diracnotation to display the density matrix.
        > a = densitymatrix(1,1,0); % state |110⟩⟨110|.
        > a_string = diracnotation(a);
        > disp(a_string);
        > ```

        > Output: `(1)|110⟩⟨110|`
* `X` - *Single-qubit Pauli X gate*.
    * *Example*
        > ```MATLAB
        > % Using diracnotation to display the density matrix.
        > qubits = [1 2 3]; % qubits' indices.
        > a = densitymatrix(1,1,0); % state |110⟩⟨110|.
        > b = X(a,[qubits(1) qubits(3)]); % state |011⟩⟨011|.
        > ```
* `Y` - *Single-qubit Pauli Y gate*.
    * *Example*
        > Similar to X.
* `Z` - *Single-qubit Pauli Z gate*.
    * *Example*
        > Similar to X.
* `H` - *Single-qubit Hadamard gate*.
    * *Example*
        > Similar to X.
* `CX` - *Two-qubit controlled-NOT gate*.
    * *Example*
        > ```MATLAB
        > % Using controlled-NOT gate.
        > qubits = [1 2 3]; % qubits' indices.
        > a = densitymatrix(1,1,0); % state |110⟩⟨110|.
        > b = CX(a,qubits(1),qubits(3)); % state |111⟩⟨111|.
        > c = CX(a,qubits(3),qubits(1)); % state |110⟩⟨110|.
        > ```
* `CY` - *Two-qubit controlled-Y gate*.
    * *Example*
        > Similar to CX.
* `CZ` - *Two-qubit controlled-Phase gate*.
    * *Example*
        > Similar to CX.
* `SWAP` - *Two-qubit controlled-Phase gate*.
    * *Example*
        > ```MATLAB
        > % Using diracnotation to display the density matrix.
        > qubits = [1 2 3]; % qubits' indices.
        > a = densitymatrix(1,1,0); % state |110⟩⟨110|.
        > b = SWAP(a,[qubits(1) qubits(3)]); % swaps qubits 1 and 3.
        > ```