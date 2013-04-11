# Martin Bruchanov, OK2MNM
# http://sstv-handbook.com
#

.SUFFIXES: .pdf .ctex

SWF_OUT = ./web/download/
SWF_DOCS = $(SWF_OUT)sstv_01.swf \
           $(SWF_OUT)sstv_02.swf \
           $(SWF_OUT)sstv_02.swf \
           $(SWF_OUT)sstv_03.swf \
           $(SWF_OUT)sstv_04.swf \
           $(SWF_OUT)sstv_05.swf \
           $(SWF_OUT)sstv_06.swf \
           $(SWF_OUT)sstv_07.swf \
           $(SWF_OUT)sstv_08.swf \
           $(SWF_OUT)sstv_09.swf \
           $(SWF_OUT)sstv_10.swf \
           $(SWF_OUT)sstv_11.swf \
           $(SWF_OUT)sstv_12.swf \
           $(SWF_OUT)sstv_13.swf \
           $(SWF_OUT)sstv-handbook.swf 
	

PDF_OUT = ./
PDF_DOCS = $(PDF_OUT)sstv_01.pdf \
           $(PDF_OUT)sstv_02.pdf \
           $(PDF_OUT)sstv_03.pdf \
           $(PDF_OUT)sstv_04.pdf \
           $(PDF_OUT)sstv_05.pdf \
           $(PDF_OUT)sstv_06.pdf \
           $(PDF_OUT)sstv_07.pdf \
           $(PDF_OUT)sstv_08.pdf \
           $(PDF_OUT)sstv_09.pdf \
           $(PDF_OUT)sstv_10.pdf \
           $(PDF_OUT)sstv_11.pdf \
           $(PDF_OUT)sstv_12.pdf \
           $(PDF_OUT)sstv_13.pdf 

all: $(PDF_DOCS) $(SWF_DOCS)

TEX = @rm -f $(SWF_OUT)$(patsubst %.pdf,%.swf,$(@)); \
      context $(patsubst %.pdf,%.ctex,$(@)); \
	  cp $@ $(SWF_OUT)
		
sstv_01.pdf: sstv/uvod.ctex 
	$(TEX)

sstv_02.pdf: sstv/sstv_start.ctex
	$(TEX)

sstv_03.pdf: sstv/modern_sstv.ctex sstv/charakteristika.ctex
	$(TEX)

sstv_04.pdf: sstv/bw_mode.ctex sstv/color.ctex sstv/hi-res.ctex sstv/experiment.ctex
	$(TEX)

sstv_05.pdf: sstv/list.ctex
	$(TEX)

sstv_06.pdf: sstv/zarizeni.ctex 
	$(TEX)

sstv_07.pdf: software/konfig.ctex software/win32soft.ctex
	$(TEX)

sstv_08.pdf: ostatni/provoz.ctex ostatni/satelit.ctex
	$(TEX)

sstv_09.pdf: dsstv/dsstv_uv.ctex dsstv/komunikace.ctex dsstv/code.ctex dsstv/komprese.ctex
	$(TEX)

sstv_10.pdf: dsstv/rdft.ctex dsstv/hamdrm.ctex dsstv/qam_ofdm.ctex dsstv/spojeni.ctex dsstv/waterfall.ctex
	$(TEX)

sstv_11.pdf: fax/fax.ctex fax/fax_sat.ctex fax/fax_amateri.ctex fax/fax_standard.ctex
	$(TEX)

sstv_12.pdf: fax/stations.ctex fax/fax_stanice.ctex
	$(TEX)

sstv_13.pdf: ostatni/pcgfx.ctex
	$(TEX)

sstv-handbook.pdf: sstv/uvod.ctex sstv/sstv_start.ctex sstv/modern_sstv.ctex sstv/charakteristika.ctex sstv/bw_mode.ctex sstv/color.ctex sstv/hi-res.ctex sstv/experiment.ctex sstv/list.ctex sstv/zarizeni.ctex software/konfig.ctex software/win32soft.ctex ostatni/provoz.ctex ostatni/satelit.ctex dsstv/dsstv_uv.ctex dsstv/komunikace.ctex dsstv/code.ctex dsstv/komprese.ctex dsstv/rdft.ctex dsstv/hamdrm.ctex dsstv/qam_ofdm.ctex dsstv/spojeni.ctex dsstv/waterfall.ctex fax/fax.ctex fax/fax_sat.ctex fax/fax_amateri.ctex fax/fax_standard.ctex fax/stations.ctex fax/fax_stanice.ctex ostatni/pcgfx.ctex ostatni/testchart.ctex
	$(TEX)

.SUFFIXES: .pdf .ctex
#      context $(patsubst %.pdf,%.ctex,$(@)); \

$(SWF_OUT)%.swf: %.pdf
	pdf2swf -s zoom=144 --viewer ./web/rfxview.swf $< -o $@

################################################################################

.PHONY: all clean backup veryclean

#
# File transfering to web-site
#
USERNAME = bruxy
SITE     = www.rado1.sk
INPUT_DIR = $(shell pwd)/*
DIR      = /home/bruxy/book_backup/
EXCLUDE  = --exclude 'Makefile' 
OPTIONS  = --verbose --no-perms --delete --stats --progress --recursive -z -e ssh --inplace --partial --times $(EXCLUDE)

backup: 
	rsync $(OPTIONS) $(INPUT_DIR) $(USERNAME)@$(SITE):$(DIR)

clean:
	@rm -f *.aux *.bbl *.blg *.log *-mpgraph.mp *.top *.tmp *.tuc *.tui *.tuo

veryclean: clean
	@rm -f *.pdf
