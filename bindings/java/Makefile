all:
	mkdir -p cz/cuni/mff/ufal/korektor
	swig -c++ -java -package cz.cuni.mff.ufal.korektor  -outdir cz/cuni/mff/ufal/korektor korektor.i
	cd ../../src && make lib && cd -
	c++ -I../../src -std=c++11 -W -Wall -mtune=generic -I. -fvisibility=hidden -mmacosx-version-min=10.7 -stdlib=libc++ -O3 -dynamiclib -mmacosx-version-min=10.7 -stdlib=libc++ -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Home/include/darwin -I/Library/Java/JavaVirtualMachines/jdk1.8.0_05.jdk/Contents/Headers -fno-strict-aliasing -Wl,-undefined -Wl,dynamic_lookup  korektor_wrap.cxx ../../src/libkorlib.a -o libkorektor_java.dylib

	javac -source 1.4 -Xlint:-options cz/cuni/mff/ufal/korektor/*.java
	jar cf korektor.jar cz/cuni/mff/ufal/korektor/*.class

clean:
	rm -rf cz *.java *.cxx
