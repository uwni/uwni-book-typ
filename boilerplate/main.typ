#import "packages.typ": *

/// make the title page
#titlepage

#show: isct_thesis
#show math.pi: math.upright

/// make the main text
#include "chapters/abs.typ"

/// make the abstract
#outline()

// this is necessary before starting your main text
#show: mainbody
#include "chapters/1.intro.typ"
#include "chapters/2.method.typ"
#include "chapters/3.app.typ"

#show: appendix
#include "appendices/data.typ"
#include "appendices/proof.typ"

#include "misc/ack.typ"
#include "misc/lop.typ"
#include "misc/ref.typ"

