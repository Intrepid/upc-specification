.SUFFIXES:
.SUFFIXES: .upc .c .o

XLUPC	= xlupc
UPCFLAGS = -I../upc_types -O3



upc_amotest: upc_amotest.o upc_amolib.o
	${XLUPC} -o $@ $^ ${UPCFLAGS}

clean:
	${RM} -f *.o *~ upc_amotest

.upc.o:
	${XLUPC} -c $^ ${UPCFLAGS}
