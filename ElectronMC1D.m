% Tyler Armstrong
% 101009324

N = 30; % Number of electrons
x = zeros(N,1); % x position, m
v = zeros(N,1); % x velocity, m/s
xlength = 200E-9; % Length of region in the x dimension, m
ylength = 100E-9; % Length of region in the x dimension, m
m = 9.11E-31; % Electron mass, kg
eps0 = 8.85E-12; % Free space permittivity, F/m
T = 1000; % Number of time steps
dt = 1E-15; % Time step, s
q = 1.602E-19; % Electron charge, C
E = 1E9; % Electric field, N/C
P = 0.05; % Scattering probability
roll = zeros(N,1); % 'die rolls' for scattering
xplot = zeros(min(N,5),T);
vplot = zeros(min(N,5),T);
driftplot = zeros(T,1);
tplot = linspace(0, T*dt, T);

y = -(ylength/2) + ylength*rand(N,1); % Randomly generate y positions
figure(1);
cla;
for t = 1:T
    x = x+(v*dt); % Update positions
    x = x + xlength*(x < -xlength/2); % Wrap around x boundaries
    x = x - xlength*(x > xlength/2);
    v = v + (E*q)/m*dt; % Increase velocity
    roll = rand(N,1); 
    v = v - v.*(roll < 0.05);
    clf;
    
    subplot(2,2,1);
    plot(x,y,'o', 'markerfacecolor', 'b');
    xlim([-xlength/2 xlength/2]);
    ylim([-ylength/2 ylength/2]);
    title('Electron positions');
    xlabel('x (m)');
    ylabel('y (m)');
    
    subplot(2,2,2);
    xplot(1:min(N,5),t) = x(1:min(N,5));
    plot(tplot, xplot);
    title('x position vs. Time')
    xlabel('t (s)');
    ylabel('x (m)');
    
    subplot(2,2,3);
    vplot(1:min(N,5),t) = v(1:min(N,5));
    plot(tplot, vplot);
    title('Velocity vs. Time');
    xlabel('t (s)');
    ylabel('v (m/s)');
    
    subplot(2,2,4);
    driftplot(t,1) = sum(v)/N;
    plot(tplot, driftplot);
    txt = sprintf('Drift Velocity = %e m/s', sum(v)/N);
    title(txt);
    xlabel('t (s)');
    ylabel('v (m/s)');
    
    pause(0.01)
end
