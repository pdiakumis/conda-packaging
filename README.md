# Building conda packages

## r-rock

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

## r-pebbles

```
conda skeleton cran https://github.com/umccr/pebbles
conda build r-pebbles
anaconda upload /data/cephfs/punim0010/extras/pdiakumis/miniconda/envs/conda-bld/conda-bld/linux-64/r-pebbles-0.0.1-r350_0.tar.bz2
```

## r-pctGCdata

```
conda skeleton cran https://github.com/mskcc/pctGCdata
conda build r-pctgcdata
anaconda upload /data/cephfs/punim0010/extras/pdiakumis/miniconda/envs/conda-bld/conda-bld/linux-64/r-pctgcdata-0.2.0-r350_0.tar.bz2
```
