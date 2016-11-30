ISE_BIN = /opt/xilinx/14.7/ISE_DS/ISE/bin/lin64
MIMAS_CONFIG = /opt/mimasconfig.py
PORT = /dev/ttyACM0

all: mimas.bin

mimas.bin: $(wildcard *.v)
	$(ISE_BIN)/xst -intstyle ise -ifn mimas.xst -ofn mimas.syr && \
	$(ISE_BIN)/ngdbuild -intstyle ise -dd _ngo -nt timestamp -uc \
	mimas.ucf -p xc6slx16-csg324-2 mimas.ngc mimas.ngd && \
	$(ISE_BIN)/map -intstyle ise -p xc6slx9-tqg144-3 -w -logic_opt off \
	-ol high -t 1 -xt 0 -register_duplication off -r 4 -global_opt off \
	-mt off -ir off -pr off -lc off -power off -o mimas_map.ncd \
	mimas.ngd mimas.pcf && \
	$(ISE_BIN)/par -w -intstyle ise -ol high -mt off mimas_map.ncd \
	mimas.ncd mimas.pcf && \
	$(ISE_BIN)/trce -intstyle ise -v 3 -s 2 -n 3 -fastpaths -xml \
	mimas.twx mimas.ncd -o mimas.twr mimas.pcf && \
	$(ISE_BIN)/bitgen -intstyle ise -f mimas.ut mimas.ncd

flash: mimas.bin
	python $(MIMAS_CONFIG) $(PORT) mimas.bin

clean:
	$(RM) -r _ngo _xmsgs xlnx_auto_0_xdb xst
	$(RM) mimas.bgn mimas.bin mimas.bit mimas.bld mimas.drc \
	mimas.lso mimas.ncd mimas.ngc mimas.ngd mimas.ngr mimas.pad \
	mimas.par mimas.pcf mimas.ptwx mimas.syr mimas.twr mimas.twx \
	mimas.unroutes mimas.xpi mimas_bitgen.xwbt mimas_map.map \
	mimas_map.mrp mimas_map.ncd mimas_map.ngm mimas_map.xrpt \
	mimas_ngdbuild.xrpt mimas_pad.csv mimas_pad.txt mimas_par.xrpt \
	mimas_summary.xml mimas_usage.xml mimas_xst.xrpt \
	par_usage_statistics.html usage_statistics_webtalk.html webtalk.log

dist: clean
	mkdir -p mimas
	cp -R mimas.prj mimas.ucf mimas.ut mimas.xst *.v Makefile mimas
	tar -cvjf mimas.tar.bz2 mimas
	$(RM) -r mimas

.PHONY: all flash clean dist
