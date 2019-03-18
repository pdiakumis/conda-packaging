# Building conda packages

## Setup

```
conda create -n cbuild -c conda-forge -c defaults conda-build anaconda-client conda-verify python=3.6
```

## Notes

* The `conda skeleton cran` command automatically pulls the latest tag. You can specify a different
  tag on the command line with `--git-tag`.

```
conda skeleton cran https://github.com/umccr/foo
conda build r-foo
anaconda upload /path/to/miniconda/envs/cbuild/conda-bld/linux-64/r-foo-0.0.1-r351_0.tar.bz2
conda convert -p osx-64 /path/to/miniconda/envs/cbuild/conda-bld/linux-64/r-foo-0.0.0.1-r351_0.tar.bz2 -o /path/to/miniconda/envs/cbuild/conda-bld -f
conda build purge # cleans up stuff
```
