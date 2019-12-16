function [ beta , Cov] = svm_dist( x,y,m,lambda,q,beta_0)
% USAGE: svm_dist(x,y,m,lambda,q,beta_0);
% 
% INPUTS:
% x: n by p covariate matrix
% y: n by 1 label vector, each element should be 1 or -1
% m: the local sample size on each machine
% lambda: the regularization parameter, the default lambda is 0
% q: the number of iterations used, the default number of iterations is 10
% 
% OUTPUTS:
% beta: the estimated SVM coefficient
% Cov: estimated limiting covariance 

warning('off', 'MATLAB:nearlySingularMatrix')
warning('off', 'MATLAB:illConditionedMatrix')
warning('off', 'MATLAB:singularMatrix')
if nargin <= 3
    lambda = 0;
end
if nargin <= 4
    q = 10;
end
n = length(y);
p = size(x,2)-1;
if nargin <= 2
    m = max(floor(sqrt(n)),p*4);
end
shuffle = 1;
if shuffle
    randind = randperm(n);
    x = x(randind,:);
    y = y(randind);
end

if nargin <= 5
    tic;
    fun = @(b) sum(max(1-y(1:m).*x(1:m,:)*b,0));
    b = fminsearch(fun,zeros(p+1,1));
    beta_0 = b;
end

dropoff = 0;
if dropoff
    x = x((m+1):end,:);
    y = y((m+1):end);
    n = n-m;
end

beta_all = zeros(p+1,q);
loss = zeros(1,20);
for ind = 1:20
    C = 2^(ind-10);
    beta0 = beta_0;
    for iter = 1:q
        h=C*max((n/p)^(-1/2),(m/p)^(-2^(iter-2)));
        temp = (1-y.*x*beta0)/h;
        Hstar = (x'*spdiags(dH(temp)/h,0,n,n)*x/n);
        beta0=Hstar\(((H(temp)+dH(temp)/h).*y)'*x/n-lambda*[0,beta0(2:end)'])';
        beta_all(:,iter) = beta0;
    end
    if isnan(beta0)
        loss(ind) = 1e10;
    else
        loss(ind) = sum(((1-y.*x*beta0)>0).*(1-y.*x*beta0))/n;
    end
end
beta_all = zeros(p+1,q);
beta0 = beta_0;
[~,ind] = min(loss);
C = 2^(ind-10);
for iter = 1:q
    h=C*max((n/p)^(-1/2),(m/p)^(-2^(iter-2)));
    temp = (1-y.*x*beta0)/h;
    Hstar = (x'*spdiags(dH(temp)/h,0,n,n)*x/n);
    beta0=Hstar\(((H(temp)+dH(temp)/h).*y)'*x/n)';
    beta_all(:,iter) = beta0;
end

temp = (1-y.*x*beta0)/h;
beta = beta0;
Hs = (x'*spdiags(dH(temp)/h,0,n,n)*x/n);
G = (x'*spdiags((temp >= 0),0,n,n)*x/n);
v = ones(p+1,1)/sqrt(p+1);
Cov  = ((Hs\G)/Hs)/n;
time = toc;
end

