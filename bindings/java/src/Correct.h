#include "common.h"
#include "lexicon/lexicon.h"
#include "spellchecker/configuration.h"
#include "spellchecker/spellchecker.h"
#include "token/input_format.h"
#include "token/output_format.h"
#include "utils/options.h"
#include "utils/parse.h"
#include "version/version.h"

#include <string>
#include <sstream>

using namespace ufal::korektor;
using namespace std;

class Correct {
private:
	ConfigurationP config;
	Spellchecker spellchecker;
	// unique_ptr<InputFormat> input_format;
	// unique_ptr<OutputFormat> output_format;
	unsigned max_corrections = 2;

	Spellchecker setup() {
		return Spellchecker(config.get());
	}

public:
	Correct(string path) : config(new Configuration(path)), spellchecker(setup()) {}
	string suggest(string input) {
		std::ostringstream response;

		string input_block, output_block;
		vector<TokenP> tokens;
		vector<SpellcheckerCorrection> corrections;

		std::stringstream ss;
		ss.str(input);

		auto input_format = InputFormat::NewUntokenizedLinesInputFormat(config->lexicon);
		cout << "IF done\n";
		auto output_format = OutputFormat::NewXmlOutputFormat();

		while (input_format->ReadBlock(ss, input_block)) { // TODO REMOVE THIS AND USE input AS input_block
			input_format->SetBlock(input_block);
			output_format->SetBlock(input_block);
			output_block.clear();

		    // For all sentences in the input block
			while (input_format->NextSentence(tokens)) {
	      		// Perform the spellchecking
				spellchecker.Spellcheck(tokens, corrections, max_corrections - 1);

				output_format->AppendSentence(output_block, tokens, corrections);
			}

			output_format->FinishBlock(output_block);
			response << output_block;
		}
		return response.str();
	}
};
