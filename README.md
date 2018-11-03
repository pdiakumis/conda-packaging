# Building conda packages

## Setup

```
conda create -n cbuild -c conda-forge -c defaults conda-build anaconda-client conda-verify python=3.6
```

## Weird Packages

### r-rock

* Need to specify conda channels to build this one. Either use `conda build -c channel r-rock` or put this in
  your `~/.condarc` file:

```
channels:
  - pdiakumis
  - conda-forge
  - bioconda
  - defaults
```

* The `conda skeleton cran` command automatically pulls the latest tag. You can specify a different
  tag on the command line with `--git-tag`.

```
conda skeleton cran https://github.com/umccr/rock
# edit the bioconductor packages in meta.yaml e.g. `r-genomicranges` to `bioconductor-genomicranges`
# use `r-base=3.4.1` for now
conda build r-rock
anaconda upload /data/cephfs/punim0010/extras/pdiakumis/miniconda/envs/conda-bld/conda-bld/linux-64/r-rock-0.0.1-r341_0.tar.bz2
```

### r-rcpptoml

This one is already on conda-forge, but only for R3.4. The R3.5 branch keeps failing with Travis. So I have simply pulled
the recipe from conda-forge which passed for R3.4, and build a version for R3.5 on my channel. Only hiccup was that I
needed an updated g++ version on Raijin (default is 4.3 from 2010 or something), 
so I simply did `conda install -c conda-forge gcc` and it pulled version 4.8.5.


```
# wget just the passed recipe from conda-forge
conda build -c conda-forge -c bioconda -c defaults r-rcpptoml/
```

### r-configr

Requires r-rcpptoml, which I built above.

