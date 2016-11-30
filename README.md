# ld-symver-example
Example of symbol versions in shared libraries

Launch with `make`:
```
[ld-symbol-vers-2]$ make
gcc -g -c -fPIC -Wall lib-v1.c
gcc -g -shared -o lib-v1.so lib-v1.o -Wl,--version-script,lib-v1.map
gcc -g -o p1 prg.c lib-v1.so
gcc -g -c -fPIC -Wall lib-v2.c
gcc -g -shared -o lib-v2.so lib-v2.o -Wl,--version-script,lib-v2.map
gcc -g -o p2 prg.c lib-v2.so
Result of p1:
LD_LIBRARY_PATH=. ./p1
I'm original xyz()
Result of p2:
LD_LIBRARY_PATH=. ./p2
I'm new xyz()
Readelf for p1:
readelf -s p1 | grep xyz
     3: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND xyz@VER_1 (3)
    61: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND xyz@@VER_1
Readelf for p2:
readelf -s p2 | grep xyz
     1: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND xyz@VER_2 (2)
    53: 0000000000000000     0 FUNC    GLOBAL DEFAULT  UND xyz@@VER_2
swapping lib-v1.so <=> lib-v2.so
cp lib-v2.so lib-v1.so
Result of p1:
LD_LIBRARY_PATH=. ./p1
I'm original xyz()
Result of p2 (expecting ld.so error):
LD_LIBRARY_PATH=. ./p2
./p2: ./lib-v2.so: version `VER_2' not found (required by ./p2)
make: *** [Makefile:17: check] Error 1
rm lib-v1.o lib-v2.o
```
