check_stray_light
=================
- Ultra-lightweight version of nuplan.pro and nustar_stray_light.pro which allows for a quick determination of whether stray light is an issue.
- Full independent of other IDL distros.
- Note: Uses readfits.pro, sxpar.pro, and sphdist.pro (along with
  their dependencies) from the IDL AstoLib. These files are duplicated
  here in order to allow for portability of this git.
- Note: When using on your local machine, edit the check_stray_light.sh script and change CHECK_DIR to be the location where you've cloned this repo. Since this is a stand-alone distro, this prevents any other libraries that you may usually load from interfereing with IDL. This isn't the cleanest way to do it, but it's the best that I can think of.
- Tested on IDL7.0 and IDL8.2.

- Last updated: 2014/08/15 by Brian Grefenstette

==================


usage: ./check_stray_light.sh RA DEC PA

All values must be in decimal degrees.

Returns: The coverage of FPMA/B det0, whichever is higher.

Example:
check_stray_light.sh 204.254 -29.8654 10

Returns to stdout:

35.16

