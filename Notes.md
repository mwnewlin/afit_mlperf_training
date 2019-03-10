The repository contains [submodules](https://git-scm.com/book/en/v2/Git-Tools-Submodules) so you'll need to do a recursive clone.

The specific flag depends on the git version.

On the DL/ML boxes clone the repository with:
```bash
git clone --recurse-submodules -j8 git@github.com:mark-e-deyoung/afit_mlperf_training.git
```

On mustang you'll need to clone the repository with:
```bash
git clone --recursive -j8 git@github.com:mark-e-deyoung/afit_mlperf_training.git
```
