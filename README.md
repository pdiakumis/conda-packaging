# Building conda packages

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
