function output = ket(varargin)
% By bernwo on Github. Link: https://github.com/bernwo/
    h = [1 1;1 -1]./sqrt(2);
    ket0 = [1;0];
    ket1 = [0;1];
    ketp = h*ket0;
    ketn = h*ket1;
    if (varargin{1} == 0) || (varargin{1} == '0')
        output = ket0;
    elseif (varargin{1} == 1) || (varargin{1} == '1')
        output = ket1;
    elseif (varargin{1} == '+')
        output = ketp;
    elseif (varargin{1} == '-')
        output = ketn;
    end
    for i = 2:nargin
        if (varargin{i} == 0) || (varargin{i} == '0')
            output = kron(output,ket0);
        elseif (varargin{i} == 1) || (varargin{i} == '1')
            output = kron(output,ket1);
        elseif (varargin{i} == '+')
            output = kron(output,ketp);
        elseif (varargin{i} == '-')
            output = kron(output,ketn);
        end
    end
end