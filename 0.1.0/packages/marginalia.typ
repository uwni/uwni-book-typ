#import "../packages.typ": marginalia // import package
#import marginalia: * // import all symbols


#let note_text_style = (size: 0.8 * 11pt, style: "normal", weight: "regular")
#let note_par_style = (spacing: 1.2em, leading: 0.5em, hanging-indent: 0pt)

#let note = note.with(text-style: note_text_style, par-style: note_par_style)
#let figurenote = notefigure.with(text-style: note_text_style, par-style: note_par_style)
#let wideblock = wideblock
