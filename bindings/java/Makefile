all:
	mkdir -p cz/cuni/mff/ufal/korektor
	swig -c++ -java -package cz.cuni.mff.ufal.korektor  -outdir cz/cuni/mff/ufal/korektor korektor.i
	#clang++ -std=c++11 -Wextra -c korektor_wrap.c -I"${JAVA_HOME}/include" -I"${JAVA_HOME}/include/darwin"
	#ld -G korektor_wrap.o  -o libkorektor.so
clean:
	rm -rf cz *.java *.cxx
