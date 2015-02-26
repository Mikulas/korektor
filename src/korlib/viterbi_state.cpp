// This file is part of korektor <http://github.com/ufal/korektor/>.
//
// Copyright 2015 by Institute of Formal and Applied Linguistics, Faculty
// of Mathematics and Physics, Charles University in Prague, Czech Republic.
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted under 3-clause BSD licence.

#include <sstream>

#include "stage_posibility.h"
#include "utils.h"
#include "viterbi_state.h"

namespace ufal {
namespace korektor {

StagePosibilityP ViterbiState::GetYoungestHistory()
{
  return history[history.size() - 1];
}

size_t ViterbiState::UniqueIdentifier()
{
  size_t seed = 0;

  MyUtils::HashCombine(seed, history.size());

  for (uint32_t i = 0; i < history.size(); i++)
  {
    MyUtils::HashCombine(seed, history[i]->UniqueIdentifier());
  }

  return seed;

}

bool ViterbiState::Equals(ViterbiState &state)
{
  return this->UniqueIdentifier() == state.UniqueIdentifier();
}

ViterbiState::ViterbiState(vector<StagePosibilityP> _history):
  history(_history), distance(0), ancestor(ViterbiStateP())
{}

ViterbiState::ViterbiState(ViterbiStateP prev_state, StagePosibilityP next_sp, double _distance):distance(_distance), ancestor(prev_state)
{
  history.reserve(prev_state->history.size());

  for (size_t i = 1; i < prev_state->history.size(); i++)
  {
    history.push_back(prev_state->history[i]);
  }

  history.push_back(next_sp);

  //distance = _distance;

  //ancestor = prev_state;
}

string ViterbiState::ToString()
{
  stringstream strs;
  strs << "(Old -> Young): ";

  for (uint32_t i = 0; i < history.size(); i++)
  {
    if (i > 0) strs << ", ";
    strs << history[i]->ToString();
  }

  return strs.str();
}

} // namespace korektor
} // namespace ufal
