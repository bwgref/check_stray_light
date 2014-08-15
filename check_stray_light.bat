!quiet=1

.run check_stray_light.pro

ra = getenv('CHECK_RA')
dec = getenv('CHECK_DEC')
pa = getenv('CHECK_PA')

check_stray_light, ra, dec, pa
 

exit


