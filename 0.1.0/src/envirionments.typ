#import "components.typ": * // import components
#import "config.typ"

#let emphblock_heading(it) = {
  set text(font: config.sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: color_palette.accent)
  show text: upper
  block(it, spacing: 1em)
}

#let emphblock(body) = {
  show regex("\[\[(.*?)\]\]"): emphblock_heading
  block(fill: color_palette.accent-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em), body)
}

#let subblock_heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: black)
  show text: upper
  block(it, spacing: 1em)
}

#let subblock(body) = {
  show regex("\[\[(.*?)\]\]"): subblock_heading
  block(
    stroke: (left: (thickness: 1.2pt, paint: color_palette.accent, dash: "densely-dashed")),
    width: 100%,
    inset: (right: 0pt, rest: 0.75em),
    body,
  )
}

#let _example_counter = counter("example")
#let example(body) = subblock[
  #subblock_heading("Example" + _example_counter.step())
  #body
]
