%module korektor

%{
#include "common.h"
#include "lexicon/lexicon.h"
#include "spellchecker/configuration.h"
#include "spellchecker/spellchecker.h"
#include "token/input_format.h"
#include "token/output_format.h"
#include "utils/options.h"
#include "utils/parse.h"
#include "version/version.h"
using namespace ufal::korektor;
%}

#define SP_DEF(cl_name) typedef shared_ptr<cl_name> cl_name##P

class Configuration {
public:
	Configuration(const string &conf_file);
};

struct Token {
  unsigned first;
  unsigned length;
  bool initialized;
  bool correction_is_allowed;
  int ID;
  u16string str;
  bool sentence_start;

  Token(unsigned _first, unsigned _length, const u16string &_str);

  void InitLexiconInformation(unsigned _ID, bool _correction_is_allowed);
  inline bool isUnknown() { return ID == -1; }

  Token(const u16string &u_str);
};

SP_DEF(Token);

struct SpellcheckerCorrection {
  enum type_t { NONE, GRAMMAR, SPELLING };

  type_t type;
  u16string correction;
  vector<u16string> alternatives;

  SpellcheckerCorrection(type_t type = NONE) : type(type) {}
};

class Spellchecker {
public:
	Spellchecker(Configuration* _configuration);
	void Spellcheck(const vector<TokenP>& tokens, vector<SpellcheckerCorrection>& corrections, unsigned alternatives = 0);
};
