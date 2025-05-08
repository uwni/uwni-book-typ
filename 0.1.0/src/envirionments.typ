#import "components.typ": * // import components
#import "config.typ"

#let accent-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: _color_palette.accent)
  show text: upper
  block(it, spacing: 1em)
}

#let accent-frame(body) = {
  show heading: it => {
    if it.level == 1 { panic("accent-frame cannot be used for level 1 headings") }
    accent-frame-heading(it.body)
  }
  block(fill: _color_palette.accent-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em), body)
}

#let dash-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: black)
  show text: upper
  block(it, spacing: 1em)
}

#let dash-frame(body) = {
  show heading: it => {
    if it.level == 1 { panic("accent-frame cannot be used for level 1 headings") }
    dash-frame-heading(it.body)
  }
  block(
    stroke: (left: (thickness: 1.2pt, paint: _color_palette.accent, dash: "densely-dashed")),
    width: 100%,
    inset: (right: 0pt, rest: 0.75em),
    body,
  )
}

#let plain-frame-heading(it) = {
  text(style: "italic", it)
}

#let plain-frame(body) = {
  show heading: it => {
    if it.level == 1 { panic("plain-frame cannot be used for level 1 headings") }
    block(it, spacing: 1em)
  }
  block(width: 100%, body)
}

#let environment(kind, name, frame, body, numbered: true) = frame[
  #counter(kind).step()
  #let heading = if frame == accent-frame {
    accent-frame-heading
  } else if frame == dash-frame {
    dash-frame-heading
  } else if frame == plain-frame {
    plain-frame-heading
  } else {
    panic("unknown frame type")
  }

  #heading(if numbered {
    name + h(.5em) + context { [#current_chapter().index.at(0).] + counter(kind).display() }
  } else {
    name + h(.5em)
  })
  #body
]

#let example = environment.with("example", "example", dash-frame)
#let proposition = environment.with("proposition", "proposition", accent-frame)
#let proof(body) = {
  let children = body.children
  let last = children.pop()
  let body = if last.func() == math.equation {
    children.push(last + place(right + bottom, text(_color_palette.accent, _qed_symbol)))
    [].func()(children)
  } else {
    body + h(1fr) + qed
  }
  environment("proof", "Proof.", plain-frame, numbered: false, body)
}

