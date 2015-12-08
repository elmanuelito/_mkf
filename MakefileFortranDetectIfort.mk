# --------------------------------------------------------------------------------
# --- Description 
# --------------------------------------------------------------------------------
# This Makefile perform checks for the gfortran compiler :
#  - If the compiler is available, the variable STATUS is set to 1
#  - The architecture the compiler will use to compile is set in ARCHI
#
# This makefile requires MakefileOS

# --------------------------------------------------------------------------------
# ---  Requirements
# --------------------------------------------------------------------------------
ifeq ($(ERR_TO_STD),)
    $(warning 'MakefileFortranDetectIfort needs MakefileOS' )
    ERR_TO_STD=2>&1
    GREP=grep
endif

# --------------------------------------------------------------------------------
# --- Intel Fortran  
# --------------------------------------------------------------------------------
IFORT_STATUS=X$(shell ifort -version $(ERR_TO_STD) | $(GREP) "Intel")
ifeq ($(IFORT_STATUS),X)
    IFORT_STATUS=0
else
    IFORT_STATUS=1
	# --- Detecting architecture for compilation
    IFORT_ARCHI=X$(shell ifort -version $(ERR_TO_STD) | $(GREP) "IA-32")
    ifneq ($(IFORT_ARCHI),X)
        IFORT_ARCHI=ia32
    else
        IFORT_ARCHI=X$(shell ifort -version $(ERR_TO_STD) | $(GREP) "64")
        ifneq ($(IFORT_ARCHI),X)
            IFORT_ARCHI=amd64
        else
            $(error('Cannot detect intel fortran architecture'))
        endif
    endif
endif
