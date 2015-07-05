%module korektor

%{
#include "./src/Correct.h"
%}

%include "std_string.i"

using namespace std;

class Correct {
public:
  Correct(string path);
  string suggest(string input);
};
