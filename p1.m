%%Setup

%First, we need to set our constants for use in the entire rest of
%the project

%Beam is a constant 2 meters long
L= 2;

%Gravitational constant
g = 9.81;

%Beam is a constant 30cm wide
w = 0.3;

%Beam is a constant 3cm thick
d = 0.03;

%Young's modulus and the area moment of inertia - always used together
EI = (1.3 * 10^10) * (w * d^3 / 12);


%%
%%Part 1

% Define a matrix which allows us to solve for the displacements using n=10 grid steps.

noload = @(x) -480 * w * d * g;

y = eulermx(10, noload)

%%
%%Part 2

% Plot the solution from Part 1 against the known correct formula
% for a Euler Beam with no load

noloadc = @(x) (noload(x) / (24*EI)) * x^2 * (x^2 - 4*L*x + 6*L^2);

plotcompare(10, noload, noloadc);
xlabel({'Position','(M)'});
ylabel({'Beam Deflection','(M)'});

%%
%%Part 3

% Rerun the calculation for a number of exponentially increasing n
% values, comparing and plotting the error for each value

n = 10;
k = 11;

ns = n * arrayfun(@(x) 2.^x, (0:k))';
e = errorcomp(ns, noload, noloadc);
c = condcomp(ns);

errortable(ns, e, c)
loglog(ns, e);
xlabel('Number of Segments');
ylabel({'Error','(M)'});

%%
%%Part 4

% Proove that the given formula for a sinusoidal load properly
% fulfills all requirements for a Euler Beam

%%
%%Part 5

% Calculate error values for the sinusoidal load and use them to
% determine the optimal value of n to get maximum accuracy

sinload = @(x) noload(x) - 100 * g * sin(pi * x / L);

sinloadc = @(x) noloadc(x) - (100 * g * L / (EI * pi)) * (L^3 / pi^3 * sin(pi / L * x) - x^3 / 6 + L / 2 * x^2 - L^2 / pi^2 * x);

e = errorcomp(ns, sinload, sinloadc);

errortable(ns, e, c)
loglog(ns, e);
xlabel('Number of Segments');
ylabel({'Error','(M)'});

%%

loglog(ns, e/sinloadc(2));
xlabel('Number of Segments');
ylabel({'Error','(%)'});

%%
%%Part 6

% Replace the sinusoidal load with a 70kg diver on the last 20cm
% and plot the resulting Euler Beam

n = 1280;

diverload = @(x) noload(x) - ((x >= 1.8) * 70 / 0.2 * g);

h = L/n;
x = (h:h:L)';
y1 = eulermx(n, noload);
y2 = eulermx(n, sinload);
y3 = eulermx(n, diverload);

max_deflection = [y1(end) y2(end) y3(end)]'
plot(x, y1, 'r', x, y2, 'g', x, y3, 'k');
xlabel({'Position','(M)'});
ylabel({'Beam Deflection','(M)'});
legend('no load','sinusoidal pile','70kg diver');

%%
%%Part 7

% Modify the coefficient matrix to fulfill conditions for a
% clamped-clamped beam, then repeat part 5 for this beam

sinloadbc = @(x) (noload(x) / (24 * EI())) * x^2 * (L - x)^2 - (100 * 9.81 * L^2 / (pi^4 * EI())) * (L^2 * sin(pi / L * x) + pi * x * (x - L));

y1 = bridgemx(n, sinload);
y2 = eulerfn(n, sinloadbc);

plot(x, y1, 'r', x, y2, 'b');

n = 10;
k = 17;

ns = n * arrayfun(@(x) 2.^x, (0:k))';
e = bridgeerrorcomp(ns, sinload, sinloadbc);
c = condcomp(ns);

errortable(ns, e, c)

loglog(ns, e);
xlabel('Number of Segments');
ylabel({'Error','(M)'});

%%

loglog(ns, e/sinloadbc(2));
xlabel('Number of Segments');
ylabel({'Error','(%)'});