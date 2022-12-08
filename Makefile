all: clean petitc.exe
tests:
	cd tests; bash test -2b ../petitc.exe
petitc.exe:
	dune build petitc.exe

clean:
	dune clean

.PHONY: all clean petitc tests