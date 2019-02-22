## Bear in mind that the hostname differs at Slides 21 and 31 each time.

# Slide 11
https://619884282345.signin.aws.amazon.com/console # For Fei
or
https://signin.aws.amazon.com/console # For you

# Slide 15
ami-06f4d4afd350f6e4c

# Slide 21
cd /r/AWS/
chmod 400 fei-aws-keypair.pem
ssh -i fei-aws-keypair.pem ubuntu@ec2-34-205-50-14.compute-1.amazonaws.com

# Slide 24
mkdir GC
cd GC
git clone https://github.com/geoschem/geos-chem Code.GC
git clone https://github.com/geoschem/geos-chem-unittest.git UT

# Slide 25
./gcCopyRunDirs

# Slide 26
make -j4 mpbuild NC_DIAG=y BPCH_DIAG=n TIMERS=1

# Slide 27
mkdir OutputDir

# Slide 29
for month in 07; do aws s3 cp --request-payer=requester --recursive s3://gcgrid/GEOS_2x2.5/GEOS_FP/2016/$month ~/ExtData/GEOS_2x2.5/GEOS_FP/2016/$month; done

# Slide 30
aws s3 cp --request-payer=requester --recursive s3://gcgrid/GEOS_2x2.5/GEOS_FP/2011/01/ ~/ExtData/GEOS_2x2.5/GEOS_FP/2011/01/
aws s3 cp --request-payer=requester s3://gcgrid/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.2x25_standard.nc ~/ExtData/GEOSCHEM_RESTARTS/v2018-11/
ln -s ~/ExtData/GEOSCHEM_RESTARTS/v2018-11/initial_GEOSChem_rst.2x25_standard.nc ~/GC/geosfp_2x25_standard/GEOSChem.Restart.20160701_0000z.nc4

# Slide 31
./geos.mp
# Following is subject to the time
Ctrl-c
cd
rm -rf ~/GC
aws s3 cp --recursive s3://fei-geoschem-run-directory/GC ~/GC

# Slide 32
Ctrl-d
ssh -i fei-aws-keypair.pem ubuntu@ec2-34-205-50-14.compute-1.amazonaws.com -L 8999:localhost:8999
source activate geo
jupyter notebook --NotebookApp.token='' --no-browser --port=8999 --notebook-dir ~/GC/geosfp_2x25_standard/OutputDir

%matplotlib inline
import matplotlib.pyplot as plt
import numpy as np
import xarray as xr
import cartopy.crs as ccrs
np.seterr(invalid='ignore'); # disable a warning from matplotlib + cartopy

ls # Run it in a seperate cell

ds = xr.open_dataset("GEOSChem.AerosolMass.20160701_0020z.nc4")
ds

ax = plt.axes(projection=ccrs.PlateCarree())
ax.coastlines()
ds['PM25'][0,0].plot(cmap='jet', ax=ax)
plt.title('PM25');

Ctrl-c
source deactivate

# Slide 33
aws s3 rm --recursive s3://fei-geoschem-run-directory/GC # For Fei
aws s3 mb s3://your_unique_bucket_name # For you

aws s3 cp --recursive ~/GC s3://fei-geoschem-run-directory/GC
aws s3 ls s3://fei-geoschem-run-directory/GC/

aws s3 cp --recursive s3://fei-geoschem-run-directory/GC ~/GC
chmod u+x ~/GC/geosfp_2x25_standard/geos.mp
for month in 07; do aws s3 cp --request-payer=requester --recursive s3://gcgrid/GEOS_2x2.5/GEOS_FP/2016/$month ~/ExtData/GEOS_2x2.5/GEOS_FP/2016/$month; done
aws s3 cp --request-payer=requester --recursive s3://gcgrid/GEOS_2x2.5/GEOS_FP/2011/01/ ~/ExtData/GEOS_2x2.5/GEOS_FP/2011/01/

# Slide 37
p3
aws configure

# Slide 38
spot_instance_linux

# Slide 41
ssh -X burn
p3
spot_instance_linux # change instance number to 2

# Slide 43
lsblk
sudo mkfs -t ext4 /dev/nvme1n1
mkdir new_disk
sudo mount /dev/nvme1n1 new_disk
df -h
sudo chown ubuntu new_disk
touch ~/new_disk/new_text

# Slide 44
sudo umount /dev/nvme1n1
rmdir new_disk
mkdir new_disk
sudo mount /dev/nvme1n1 new_disk
ls new_disk/

# Slide 45
sudo umount /dev/nvme1n1
rmdir new_disk











