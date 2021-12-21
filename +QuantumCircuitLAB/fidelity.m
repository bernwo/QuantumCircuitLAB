function F = fidelity(rho_0,rho_1)
% By bernwo on Github. Link: https://github.com/bernwo/
% fidelity calculation for arbitrary states rho_0 and rho_1 as seen in https://www.tandfonline.com/doi/pdf/10.1080/09500349414552171?needAccess=true

sqrt_rho_0 = rho_0^(1/2);
a = sqrt_rho_0*rho_1*sqrt_rho_0;
F = real( trace(a^(1/2))^2 );

end
