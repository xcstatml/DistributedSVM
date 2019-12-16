Linear Support Vector Machine Solver

USAGE: svm_dist(x,y,m,lambda,q,beta_0);

INPUTS:
x: n by p covariate matrix, the first column of x should be all one
y: n by 1 label vector, each element should be 1 or -1
m: the local sample size on each machine
lambda: the regularization parameter, the default lambda is 0
q: the number of iterations used, the default number of iterations is 10

OUTPUTS:
beta: the estimated SVM coefficient

OTHER PROGRAMS:
test_svm.m: A simple test script which illustrates how the main function is used.
plot_svm.m: A function which helps visulizing the result in the two dimensional case (i.e., p=3)

Please cite the the following paper if the package was used

Wang, Xiaozhou and Yang, Zhuoyi and Chen, Xi and Liu, Weidong. Distributed Inference for Linear Support Vector Machine. Journal of Machine Learning Research (forthcoming), 2019.

@article{wang2019distributed,
  title={Distributed Inference for Linear Support Vector Machine},
  author={Wang, Xiaozhou and Yang, Zhuoyi and Chen, Xi and Liu, Weidong},
  journal={Journal of Machine Learning Research (forthcoming)},
  year={2019}
}