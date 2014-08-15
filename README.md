check_stray_light
=================
- Full independent of other IDL distros.
- Note: Uses readfits.pro, sxpar.pro, and sphdist.pro (along with
  their dependencies) from the IDL AstoLib. These files are duplicated
  here in order to allow for portability of this git.

usage: ./check_stray_light.sh RA DEC PA

All values must be in decimal degrees.

Output:

Col 1: PA

Col2: FPMA Total Loss

Col3: FPMB Total Loss

Col4: FPMA Det0 Total Loss

Col5: FPMB Det0 Total Loss:

Example:
check_stray_light.sh 204.254 -29.8654 10

Returns to stdout:

10.00   23.00   23.00   35.16   35.16

