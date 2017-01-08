TAIL_PRELUDE=$(TAIL_ROOT)/lib/prelude.apl

.PHONY: all clean run

all: nbody.py

nbody.py: nbody.fut
	futhark-pyopencl --library nbody.fut

nbody.fut: nbody.tail
	tail2futhark --float-as-single --unsafe --library -o nbody.fut nbody.tail

nbody.tail: nbody.apl
	aplt -p_types -s_tail -c -o nbody.tail $(TAIL_PRELUDE) nbody.apl

clean:
	rm -f nbody.tail nbody.fut nbody.py

run: nbody.py
	./nbody-gui.py
