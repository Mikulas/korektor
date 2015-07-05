#include "Correct.h"

using namespace std;

int main() {
	cout << "testing...\n";
	Correct correct = Correct("/Users/mikulas/Projects/korektor/models/korektor-czech-130202/spellchecking_h2mor.conf");
	cout << correct.suggest("kocky jsou zvirata");

	return 0;
}
