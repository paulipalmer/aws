#!/usr/bin/env python
"""
mmarvin 20190318

This Python script uses the xesmf package to regrid GEOS-Chem input/output files.
The particular example shown here resamples a global 4x5 restart file onto the
nested AS 0.5x0.625 grid.

Adapted from: https://github.com/geoschem/GEOSChem-python-tutorial/blob/master/Chapter03_regridding.ipynb

"""

import numpy as np
import xarray as xr
import xesmf as xe

infilename = 'GEOSChem.Restart.20160101_0000z.Global_4x5.nc4'
outfilename = 'GEOSChem.Restart.20160101_0000z.Nested_AS_05x0625.nc4'

# Nested grid: 0.5x0.625 AS
neststridelat = 0.5
neststridelon = 0.625

nestminlat = -11
nestmaxlat = 55
nestnlat = 133

nestminlon = 60
nestmaxlon = 150
nestnlon = 145

# Global grid: 4x5
globstridelat = 4
globstridelon = 5

globminlat = -90
globmaxlat = 90
globnlat = 46

globminlon = -180
globmaxlon = 175
globnlon = 72

result_list = [] # an empty list to hold regridding result

ds = xr.open_dataset(infilename)

# Regridding method: conservative
nested_grid_with_bounds = {'lon': np.linspace(nestminlon, nestmaxlon, nestnlon),
                           'lat': np.linspace(nestminlat, nestmaxlat, nestnlat),
                           'lon_b': np.linspace(nestminlon-neststridelon/2, nestmaxlon+neststridelon/2, nestnlon+1),
                           'lat_b': np.linspace(nestminlat-neststridelat/2, nestmaxlat+neststridelat/2, nestnlat+1),
                          }

global_grid_with_bounds = {'lon': ds['lon'].values,
                           'lat': ds['lat'].values,
                           'lon_b': np.linspace(globminlon-globstridelon/2, globmaxlon+globstridelon/2, globnlon+1),
                           'lat_b': np.linspace(globminlat-globstridelat/2, globmaxlat+globstridelat/2, globnlat+1).clip(-90, 90), # fix half-polar cells
                          }

regridder_conserve = xe.Regridder(global_grid_with_bounds, nested_grid_with_bounds, method='conservative')

# Regrid all variables with lat/lon dimensions
for varname, dr in ds.data_vars.items():
    if len(dr.dims) < 2:
        dr_temp = dr
        result_list.append(dr_temp)
    else:
        dr_temp = regridder_conserve(dr) # temporary variable for the current tracer
        result_list.append(dr_temp)  # add the current result to the list

ds_result = xr.merge(result_list)  # merge a list of DataArray to a single Dataset
ds_result.to_netcdf(outfilename)

# Clean-up: remove the regridder "cache" if you don't need it next time
regridder_conserve.clean_weight_file()
