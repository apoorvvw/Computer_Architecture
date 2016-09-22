#! /bin/bash
make clean
asm asmFiles/test.rtype.asm
sim -t
make system.sim
diff -y memsim.hex memcpu.hex