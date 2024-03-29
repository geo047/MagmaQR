pkgname <- "MagmaQR"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('MagmaQR')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("MagmaQR")
### * MagmaQR

flush(stderr()); flush(stdout())

### Name: MagmaQR
### Title: MagmaQR - provides a fast replacement for the qr() function,
###   using GPU based MAGMA library routine.
### Aliases: MagmaQR
### Keywords: MagmaQR, magma, MAGMA, QR, GPU

### ** Examples

# setup

# setup
set.seed(101)
n <- 6000
ngpu <- 1
res  <- matrix(sample(1:1000, n*n, TRUE ), nrow=n)
#res  <- tcrossprod(K)
print(res[1:5,1:5])

# CPU based
 library(MagmaQR)
 MagmaQR::RunServer( matrixMaxDimension=n,  numGPUsWanted=ngpu, memName="/syevd_mem", semName="/syevd_sem", print=0)

  qGPU  <- MagmaQR::qr_mgpu(res, printInfo=TRUE)

 ## CPU 
# qCPU  <- qr.Q(qr(res))


   print(qGPU[1:5, 1:5])
   print("---------------------")
   print(qCPU[1:5, 1:5])


   print(c("Test Sum = ", sum(qGPU - qCPU) ))

 
  StopServer()  # Client signals to server to terminate
  




### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
