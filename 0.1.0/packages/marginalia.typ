#import "../packages.typ": marginalia // import package
#import "../src/components.typ": is_even_page, color_palette // import component

#let note_text_style = (size: 0.8 * 11pt, style: "normal", weight: "regular")
#let note_par_style = (spacing: 1.2em, leading: 0.5em, hanging-indent: 0pt)
#let page_margin = 15mm
#let block-style(loc) = if calc.even(loc.page()) {
  (
    stroke: (left: color_palette.accent + page_margin),
    outset: (left: page_margin, rest: 1pt),
    width: 100%,
  )
} else {
  (
    stroke: (right: color_palette.accent + page_margin),
    outset: (right: page_margin, rest: 1pt),
    width: 100%,
  )
}

#let note(..args) = context {
  marginalia.note(text-style: note_text_style, par-style: note_par_style, block-style: block-style, ..args)
}

#let figurenote = marginalia.notefigure.with(text-style: note_text_style, par-style: note_par_style)
#let wideblock = marginalia.wideblock
