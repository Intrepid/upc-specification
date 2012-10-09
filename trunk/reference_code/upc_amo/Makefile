.SUFFIXES:
.SUFFIXES: .upc .c .o

XLUPC	= xlupc




upc_amotest: upc_amotest.o upc_amolib.o
	${XLUPC} -o $@ $^ -O3

clean:
	${RM} -f *.o *~ upc_amotest

.upc.o:
	${XLUPC} -c $^ -O3