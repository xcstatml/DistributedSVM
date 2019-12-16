balance = 0.6;
n = 10000;
p = 2;
center = ones(1,p)/sqrt(p);
sigma = 1;
m = 100;

% true beta
fun = @(x) normpdf(x,sqrt(p),sigma*sqrt(p)).*x;
g = @(x) integral(fun,-inf,x);
G = @(u) balance*g(sqrt(p)+sigma*sqrt(p)*u)+(1-balance)*g(sqrt(p)+sigma*sqrt(p)*norminv(normcdf(u)*balance/(1-balance)));
%alpha = fzero(g,0)
u = fzero(G,norminv(0.5/(max(balance/(1-balance),(1-balance)/balance))));
A = sqrt(p)+sigma*sqrt(p)*u;
B = sqrt(p)+sigma*sqrt(p)*norminv(normcdf(u)*balance/(1-balance));
beta_true = [(B-A)/(A+B);ones(p,1)*2/(A+B)];

y = 2*(randn(n,1)>-norminv(balance))-1;
x = [ones(n,1),norm(center)*sigma*randn(n,p)+y*center];
[beta_dist,Cov] = svm_dist(x,y,m);
plot_svm(x,y,beta_dist)
disp("The true coefficient is:")
disp(beta_true)
disp("The estimated coefficient is:")
disp(beta_dist)