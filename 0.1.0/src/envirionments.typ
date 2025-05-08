#import "components.typ": * // import components
#import "config.typ"

#let accent-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: color_palette.accent)
  show text: upper
  block(it, spacing: 1em)
}

#let accent-frame(body) = {
  show regex("\[\[(.*?)\]\]"): accent-frame-heading
  block(fill: color_palette.accent-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em), body)
}

#let dash-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: black)
  show text: upper
  block(it, spacing: 1em)
}

#let dash-frame(body) = {
  show regex("\[\[(.*?)\]\]"): dash-frame-heading
  block(
    stroke: (left: (thickness: 1.2pt, paint: color_palette.accent, dash: "densely-dashed")),
    width: 100%,
    inset: (right: 0pt, rest: 0.75em),
    body,
  )
}

#let environment(kind, frame, body) = frame[
  #counter(kind).step()
  #let heading = if kind == accent-frame {
    accent-frame-heading
  } else if kind == dash-frame {
    dash-frame-heading
  }
  #heading(kind + h(.5em) + context { [#current_chapter().index.at(0).] + counter(kind).display() })
  #body
]

#let example = environment.with("example", dash-frame)
#let proposition = environment.with("proposition", accent-frame)
