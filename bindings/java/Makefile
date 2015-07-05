all:
	mkdir -p cz/cuni/mff/ufal/korektor
	swig -c++ -java -package cz.cuni.mff.ufal.korektor  -outdir cz/cuni/mff/ufal/korektor korektor.i
	clang -std=c++11 -Wextra -I../../src -c korektor_wrap.cxx -I"${JAVA_HOME}/include" -I"${JAVA_HOME}/include/darwin"
	cd ../../src && make lib && cd -
	clang -stdlib=libc++ -o libkorektor.dylib -dylib korektor_wrap.o ../../src/libkorlib.a
	# ld -dylib korektor_wrap.o -o libkorektor.so
clean:
	rm -rf cz *.java *.cxx
