function output = depolarisingchannel(dm,targ,error_rate)
% By bernwo on Github. Link: https://github.com/bernwo/
    dim = size(dm);
    assert( length(dim) == 2 , 'The input given is not a square matrix!' );
    assert( dim(1) == dim(2) , 'The input given is not a square matrix!' );
    bits = ceil(log2(dim(1)));
    assert( targ <= bits , 'Invalid target index entered!' );
    single_x_gate = [0 1;1 0];
    single_y_gate = [0 -1i;1i 0];
    single_z_gate = [1 0;0 -1];
    single_id_gate = eye(2);
    temp = zeros(bits, 2, 2);
    
    for k = 1:bits
        if k == targ
            temp(k,:,:) = single_x_gate;
        else
            temp(k,:,:) = single_id_gate;
        end
    end
    x_projector = squeeze(temp(1,:,:));
    for j = 2:bits
        x_projector = kron(x_projector,squeeze(temp(j,:,:)));
    end
    
    for l = 1:bits
        if l == targ
            temp(l,:,:) = single_y_gate;
        else
            temp(l,:,:) = single_id_gate;
        end
    end
    y_projector = squeeze(temp(1,:,:));
    for m = 2:bits
        y_projector = kron(y_projector,squeeze(temp(m,:,:)));
    end
    
    for a = 1:bits
        if a == targ
            temp(a,:,:) = single_z_gate;
        else
            temp(a,:,:) = single_id_gate;
        end
    end
    z_projector = squeeze(temp(1,:,:));
    for b = 2:bits
        z_projector = kron(z_projector,squeeze(temp(b,:,:)));
    end
    
    output = (1-error_rate)*dm + (error_rate/3)*( ...
             (x_projector*dm*x_projector') + ...
             (y_projector*dm*y_projector') + ...
             (z_projector*dm*z_projector') );
end