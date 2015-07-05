#include "common.h"
#include "lexicon/lexicon.h"
#include "spellchecker/configuration.h"
#include "spellchecker/spellchecker.h"
#include "token/input_format.h"
#include "token/output_format.h"
#include "utils/options.h"
#include "utils/parse.h"
#include "version/version.h"

#include <sstream>

using namespace ufal::korektor;

class Korektor {
private:
	Spellchecker spellchecker;
	unique_ptr<InputFormat> input_format;
	unsigned max_corrections = 2;

public:
	Korektor(string path) {
		ConfigurationP configuration(new Configuration(path));
		spellchecker = Spellchecker(configuration.get());

		input_format = InputFormat::NewUntokenizedLinesInputFormat(configuration->lexicon);
		output_format = OutputFormat::NewXmlOutputFormat();
	}
	string check(string input) {
		std::ostringstream response;

		string output_block;
		vector<TokenP> tokens;
		vector<SpellcheckerCorrection> corrections;

		std::stringstream ss;
		ss.str(input);

		while (input_format->ReadBlock(ss, input_block)) {
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
