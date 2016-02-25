# image_proc
Scripts used in imagic to speed up processing of raw .tif files

occasionally modified to fit the parameters for the data they're used on.

Start with quickproc.sh to process raw tifs, unblur images and convert them to .mrc's.
Append_mrc.sh of all mrc files to create a single stack.
Open stack in tigris, manually or auto-pick single particles, and from the resulting .plt file, run it through plt2fre.sh
to create a frealign parameter file.
