all: run load

run:
	@rm -f app.fs || true
	@gw_sh run.tcl
	@mv ./impl/pnr/app.fs ./

load:
	@openFPGALoader app.fs -f

py:
	@python main.py
	@mv output.hex src/
