all:
	mkdir -p cz/cuni/mff/ufal/korektor
	swig -c++ -java -package cz.cuni.mff.ufal.korektor  -outdir cz/cuni/mff/ufal/korektor korektor.i
	# swig -c++ -tcl korektor.i

	clang++ -I../../src -std=c++11 -stdlib=libc++ -W -Wall -o test src/test.cpp \
		../../src/decoder/*.cpp \
		../../src/error_model/*.cpp \
		../../src/language_model/*.cpp \
		../../src/lexicon/*.cpp \
		../../src/morphology/*.cpp \
		../../src/persistent_structures/*.cpp \
		../../src/spellchecker/*.cpp \
		../../src/token/*.cpp \
		../../src/unilib/*.cpp \
		../../src/utils/*.cpp
	chmod +x ./test
	./test

	c++ -I../../src -fvisibility=hidden -mmacosx-version-min=10.7 \
		-std=c++11 -W -Wall -mtune=generic -stdlib=libc++ -W -Wall \
		-c src/Correct.h -o correct.a

	cd ../../src && make lib && cd -

	# c++ -I../../src -std=c++11 -W -Wall -mtune=generic -I. -fvisibility=hidden -mmacosx-version-min=10.7 -stdlib=libc++ -O3 -dynamiclib -mmacosx-version-min=10.7 -stdlib=libc++ -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include/darwin -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Headers -fno-strict-aliasing -Wl,-undefined -Wl,dynamic_lookup  korektor_wrap.cxx ../../src/libkorlib.a -o libkorektor_java.dylib
	c++ -I../../src -std=c++11 -stdlib=libc++ -W -Wall -mtune=generic -I. -fvisibility=hidden \
		-mmacosx-version-min=10.7 -stdlib=libc++ -O3 -dynamiclib \
		-I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include \
		-I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include/darwin \
		-I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Headers \
		-fno-strict-aliasing -Wl,-undefined -Wl,dynamic_lookup \
		korektor_wrap.cxx correct.a ../../src/libkorlib.a \
		-o libkorektor_java.dylib

	javac -source 1.4 -Xlint:-options cz/cuni/mff/ufal/korektor/*.java
	jar cf korektor.jar cz/cuni/mff/ufal/korektor/*.class

clean:
	rm -rf cz *.java *.cxx *.dylib *.a *.o
