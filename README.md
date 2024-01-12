## Introduction
Tucker decomposition is a higher-order variant of Principal Component Analysis, it is often used to find hidden factors and elicit the intrinsic structure of multi-way data. In this paper, we focus on a sparse nonnegative  Tucker decomposition  model with $\ell_0$-constraints ($\ell_0$-SNTD) to enhance its effectiveness and interpretability, as the $\ell_0$ norm provides the most intuitive representation of sparsity. However, due to the nonconvex, nonsmooth and NP-hard nature of the $\ell_0$-norm and the nonconvexity of Tucker decomposition, directly minimizing $\ell_0$-SNTD is difficult. To tackle these challenges, we propose the Inertial Block Proximal Alternating Linearized method (IBPL) to solve the $\ell_0$-SNTD problem, IBPL can accurately ensure the nonnegativity and sparsity of the solution while developing a practical convergent scheme. Additionally, we demonstrate that IBPL ensures the convergence of the objective function in the $\ell_0$-SNTD model. Furthermore, we prove that IBPL is globally convergent to a first-order critical point and establish its convergence rate. 

This package contains code for the sparse nonnegative  Tucker decomposition  model with $\ell_0$-constraints ($\ell_0$-SNTD) problem in the paper[<sup>1</sup>](#refer-id). 

## Matlab code
A toy example explains how to use the L0SNTD function. 

For "L0SNTD", before running it, first add the toolbox 'tensortoolbox'[<sup>2</sup>](#refer-id) (www.tensortoolbox.org) to the running path of matlab, and then run the function 'main_Run_me'. 
 

## Reference
<div id="refer-id"></div>
[1] Yang W, Min W, et.al. An Accelerated Alternating Proximal method for Sparse Nonnegative Tucker Decomposition with $\ell_0$-constraints.

[2] Brett W. Bader and Tamara G. Kolda. 2006. Algorithm 862: MATLAB tensor classes for fast algorithm prototyping. ACM Trans. Math. Softw. 32, 4 (December 2006), 635–653. https://doi.org/10.1145/1186785.1186794
