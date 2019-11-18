##############################################################################
#                                                                            #
#                   Image Communication on Short Waves                       #
#                                                                            #
#  Author  : Martin Bruchanov, OK2MNM                                        #
#  Contact : bruchy gmail.com                                                #
#  Source  : https://github.com/BruXy/sstv-handbook                          #
#                                                                            #
#                Published at: http://sstv-handbook.com                      #
#                                                                            #
##############################################################################

# Book is written in ConTeXt, use following tutorial for installation:
#
# ConTeXt URL: https://wiki.contextgarden.net/ConTeXt_Standalone

.SUFFIXES: .pdf .ctex
.PHONY: all book clean backup veryclean upload publish

# Implicit rule for .pdf creation:
%.pdf: %.ctex
	context $(patsubst %.pdf,%.ctex,$(@))

# List of files for each chapter
# ------------------------------
CHAPTERS=$(wildcard sstv_*.ctex)

CH01 = sstv/uvod.ctex

CH02 = sstv/sstv_start.ctex

CH03 = sstv/modern_sstv.ctex \
       sstv/charakteristika.ctex

CH04 = sstv/bw_mode.ctex \
       sstv/color.ctex \
       sstv/hi-res.ctex \
       sstv/experiment.ctex

CH05 = sstv/list.ctex

CH06 = sstv/zarizeni.ctex

CH07 = software/konfig.ctex \
       software/win32soft.ctex

CH08 = ostatni/provoz.ctex \
       ostatni/satelit.ctex

CH09 = dsstv/dsstv_uv.ctex \
       dsstv/komunikace.ctex \
       dsstv/code.ctex \
       dsstv/komprese.ctex

CH10 = dsstv/rdft.ctex \
       dsstv/hamdrm.ctex \
       dsstv/qam_ofdm.ctex \
       dsstv/spojeni.ctex \
       dsstv/waterfall.ctex

CH11 = fax/fax.ctex \
       fax/fax_sat.ctex \
       fax/fax_amateri.ctex \
       fax/fax_standard.ctex

CH12 = fax/stations.ctex \
       fax/fax_stanice.ctex

CH13 = ostatni/pcgfx.ctex

all: $(CHAPTERS:.ctex=.pdf)

book: sstv-handbook.pdf

sstv_01.pdf: $(CH01)

sstv_02.pdf: $(CH02)

sstv_03.pdf: $(CH03)

sstv_04.pdf: $(CH04)

sstv_05.pdf: $(CH05)

sstv_06.pdf: $(CH06)

sstv_07.pdf: $(CH07)

sstv_08.pdf: $(CH08)

sstv_09.pdf: $(CH09)

sstv_10.pdf: $(CH10)

sstv_11.pdf: $(CH11)

sstv_12.pdf: $(CH12)

sstv_13.pdf: $(CH13)

sstv-handbook.pdf: $(CH01) $(CH02) $(CH03) $(CH04) \
                   $(CH05) $(CH06) $(CH07) $(CH08) \
                   $(CH09) $(CH10) $(CH11) $(CH12) \
                   $(CH13)

# File transfering to web-site
# ----------------------------

USERNAME  = bruxy-aws
SITE      = sstv-handbook.com
FILE_LIST = $(shell pwd)/sstv*.pdf
DEST_DIR  = /home/$(USERNAME)/websites/$(SITE)/download/
OPTIONS   = --verbose --no-perms --stats \
            --progress --recursive -z -e ssh --inplace --partial --times

upload: publish

publish:
	rsync $(OPTIONS) $(FILE_LIST) $(USERNAME)@$(SITE):$(DEST_DIR)

clean:
	@rm -f *.aux *.bbl *.blg *.log *-mpgraph.mp *.top *.tmp *.tuc *.tui *.tuo

veryclean: clean
	@rm -f sstv*.pdf
