#import "packages.typ": *

/// make the title page
#titlepage

#show: isct_thesis
#show math.pi: math.upright

#preamble[
  #include "chapters/0_abs.typ"
]

/// make the abstract
#outline()

// this is necessary before starting your main text
#mainbody[
  #include "chapters/1_intro.typ"
  #include "chapters/2_set.typ"
]

#appendix[
  // #include "appendices/data.typ"
  // #include "appendices/proof.typ"
]

#justify_page()
#include "misc/ack.typ"
#include "misc/lop.typ"
#include "misc/ref.typ"

#make_index()

