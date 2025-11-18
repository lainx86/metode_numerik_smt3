t0 = 0;
tfinal = 15;
p0 = [50; 50];
[t,p] = ode45(@lotkaODE,[t0 tfinal],p0);
plot(t,p)
title('Predator/Prey Populations Over Time')
xlabel('t')
ylabel('Population')
legend('Prey','Predators')
plot(p(:,1),p(:,2))
title('Phase Plot of Predator/Prey Populations')
xlabel('Prey')
ylabel('Predators')
y0 = 10:10:400;
for k = 1:length(y0)
    [t,p] = ode45(@lotkaODE,[t0 tfinal],[50 y0(k)]);
    plot(p(:,1),p(:,2))
    hold on
end
title('Phase Plot of Predator/Prey Populations')
xlabel('Prey')
ylabel('Predators')
hold off
n = length(y0);
p0_all = [50*ones(n,1) y0(:)]';
[t,p] = ode45(@(t,p) lotkasystem(t,p,n),[t0 tfinal],p0_all);
p = reshape(p,[],n);
nt = length(t);
for k = 1:n
    plot(p(1:nt,k),p(nt+1:end,k))
    hold on
end
title('Predator/Prey Populations Over Time')
xlabel('t')
ylabel('Population')
hold off