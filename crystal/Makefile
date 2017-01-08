TAIL_PRELUDE=$(TAIL_ROOT)/lib/prelude.apl

.PHONY: all clean run

all: crystal.py

crystal.py: crystal.fut
	futhark-pyopencl --library crystal.fut

crystal.fut: crystal.tail
	tail2futhark --float-as-single --library -o crystal.fut crystal.tail

crystal.tail: crystal.apl
	aplt -p_types -s_tail -c -o crystal.tail $(TAIL_PRELUDE) crystal.apl

clean:
	rm -f crystal.tail crystal.fut crystal.py

run: crystal.py
	./crystal-gui.py
