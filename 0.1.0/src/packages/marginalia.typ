#import "@preview/marginalia:0.1.4"

#import "../components.typ": is_even_page, _color_palette // import component
#import "../config.typ": _caption_font, _symbol_font

#let note_text_style = (size: 0.8 * 11pt, style: "normal", weight: "regular", font: _caption_font)
#let note_par_style = (spacing: 1.2em, leading: 0.5em, hanging-indent: 0pt)
#let page_margin = 15mm
#let block-style(loc) = if calc.even(loc.page()) {
  (
    stroke: (left: _color_palette.accent + page_margin),
    outset: (left: page_margin, rest: 1pt),
    width: 100%,
  )
} else {
  (
    stroke: (right: _color_palette.accent + page_margin),
    outset: (right: page_margin, rest: 1pt),
    width: 100%,
  )
}

#let note(..args) = context {
  marginalia.note(text-style: note_text_style, par-style: note_par_style, block-style: block-style, ..args)
}

#let notefigure = marginalia.notefigure.with(text-style: note_text_style, par-style: note_par_style)
#let wideblock = marginalia.wideblock

/// Format note marker
/// -> content
#let note-numbering(
  repeat: true,
  ..,
  /// -> int
  number,
) = {
  let markers = marginalia.note-markers-alternating
  let index = if repeat { calc.rem(number - 1, markers.len()) } else { number - 1 }
  let symbol = if index < markers.len() {
    markers.at(index)
  } else {
    str(index + 1 - markers.len())
    h(1.5pt)
  }
  return text(size: 5pt, style: "normal", font: _symbol_font, fill: _color_palette.accent, symbol)
}
