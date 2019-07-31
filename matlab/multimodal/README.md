## Standard MCMC and HMC methods

This repository contains MatLab scripts to perform standard MCMC and HMC exercises. These scripts are mainly devoted to better understand the way they work.

Both scripts test_mcmc.m and test_hmc.m need to define a probability function. While for the MCMC this function allows to compare current and new proposals, the HMC requires to define a potential energy function given as the negative logarithm of the probability function. In this repository, the probability function is given as a closed form (an example) by prob.m. The HMC technique requires, in addition, the gradient of the potential energy function. That gradient is computed by grad.m.

If you want to run the MCMC exploration, run the script test_mcmc.m, run test_hmc.m to do the exploration using the HMC approach.

Some of the plots are performed with MatLab, others required Python.

To contact me for any doubt:
hugo.geofisica@gmail.com
or 
hugo.sanchez-reyes@univ-grenoble-alpes.fr

![alt text](https://github.com/hugosanrocks/mcmc_methods/blob/master/matlab/multimodal/MCMC_vs_HMC_multimodal.png)
