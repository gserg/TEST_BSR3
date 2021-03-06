#  test run for LS photoionization calculations
#  for hv + C- problem (~ 10 min)
#
#  suppose that independent MCHF calculations were carried out
#  for 2s2_2p2, 2s_2p3 and 2s2_2p3s configurations 
#  and we have corresponding w- and c-files
#  Now we are going to prepare target states in
#  BSR-format 
#
#  if the unformatted-file structure is uncompatable,
#  first get w-files from the ASCII frm-files for radial functions
#  (see subfolder "frm")

#  convolute the w-files to the bsw-format

w_bsw 2p2_3P.w
w_bsw 2p3s_3Po.w
w_bsw 2p3_3Do.w
w_bsw 2p3_3Po.w
w_bsw 2p3_3So.w
w_bsw 2p3_5So.w
w_bsw 2p4_3P.w

# prepare  target_sub.bsw  from 2p3s_3Po.bsw  using bsw123 utility
# (or prepare first  target_sub.w from 2p3s_3Po.w using w123)

#  BSR calculations

#  note rather big  eps_phys = 0.5 in the bsr_par for this case
#  of extreme configuration mixing

bsr_prep3
bsr_conf3

bsr_breit3 klsp1=1 klsp2=2
bsr_mat3 klsp1=1 klsp2=2

bsr_hd3 klsp1=1 itype=-1 msol=1
bsr_hd3 klsp1=2 itype=1

mult3 cfg.001 cfg.002 E1 > mult.log
bsr_dmat3 cfg.001 cfg.002 b p

#  photionization calculations

bsr_phot3 

#  final results are the photodatachment
#  cross sections in the file  photo.002
#  To check if the test runs correctly
#  compare the cross sections with data in
#  file photo.test

#  fc photo.002 photo.test > check_diff
diff photo.002 photo.test > check_diff

