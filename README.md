check_stray_light
=================
- Full independent of other IDL distros.
- Note: Uses readfits.pro, sxpar.pro, and sphdist.pro (along with
  their dependencies) from the IDL AstoLib. These files are duplicated
  here in order to allow for portability of this git.

usage: ./check_stray_light.sh RA DEC PA

All values must be in decimal degrees.

Returns: The coverage of FPMA/B det0, whichever is higher.

Example:
check_stray_light.sh 204.254 -29.8654 10

Returns to stdout:

35.16

