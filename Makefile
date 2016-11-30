
check: p1 p2
	@echo Result of p1:
	LD_LIBRARY_PATH=. ./p1
	@echo Result of p2:
	LD_LIBRARY_PATH=. ./p2
.PHONY: check

%.so: %.o %.map
	gcc -g -shared -o $@ $< -Wl,--version-script,$(@:%.so=%.map)

lib%.o: lib%.c
	gcc -g -c -fPIC -Wall $<

p%: lib-v%.so
	gcc -g -o $@ prg.c $<

clean:
	rm -f ./*.o ./*.so p1 p2
.PHONY: clean
