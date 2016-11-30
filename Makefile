check: p1 p2 lib-v1.so lib-v2.so
	@echo Result of p1:
	LD_LIBRARY_PATH=. ./p1
	@echo Result of p2:
	LD_LIBRARY_PATH=. ./p2
	@echo Readelf for p1:
	readelf -s p1 | grep xyz
	@echo Readelf for p2:
	readelf -s p2 | grep xyz
	@echo replacing lib-v1.so with lib-v2.so
	cp lib-v2.so lib-v1.so
	@echo Result of p1:
	LD_LIBRARY_PATH=. ./p1
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
