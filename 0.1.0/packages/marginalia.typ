#import "../packages.typ": marginalia // import package
#import "../src/components.typ": is_even_page // import component

#let note_text_style = (size: 0.8 * 11pt, style: "normal", weight: "regular")
#let note_par_style = (spacing: 1.2em, leading: 0.5em, hanging-indent: 0pt)
#let block-style(loc) = (stroke: (right: blue + 20pt), outset: (..if calc.even(loc.page()) {(left: 20mm)} else {(right: 20mm)}, rest: 4pt), width: 100%)

#let note(..args) = context {
  marginalia.note(text-style: note_text_style, par-style: note_par_style, block-style: block-style, ..args)
}

#let figurenote = marginalia.notefigure.with(text-style: note_text_style, par-style: note_par_style)
#let wideblock = marginalia.wideblock
