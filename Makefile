all: clean petitc.exe
tests:
	mv ./petitc.exe tests/petitc.exe; 
	cd tests; bash test -3b ./petitc.exe
	cd ..
petitc.exe:
	dune build petitc.exe

clean:
	dune clean

.PHONY: all clean petitc tests