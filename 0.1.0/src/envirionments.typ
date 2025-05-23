#import "components.typ": * // import components
#import "config.typ"
#import "../packages/marginalia.typ": * // import package

// #let red-frame-heading(it) = {
//   set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: _color_palette.red)
//   show text: upper
//   block(it, spacing: 1em)
// }

// #let red-frame = (fill: _color_palette.red-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em))

#let accent-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: _color_palette.accent)
  show text: upper
  block(it, spacing: 1em)
}

#let accent-frame = (fill: _color_palette.accent-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em))

#let dash-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: black)
  show text: upper
  block(it, spacing: 1em)
}

#let dash-frame = (
  stroke: (left: (thickness: 1.2pt, paint: _color_palette.accent, dash: "densely-dashed")),
  width: 100%,
  inset: (right: 0pt, rest: 0.75em),
)


#let plain-frame-heading(it) = {
  text(style: "italic", it)
}

#let plain-frame = {
  (width: 100%)
}

#let environment(kind, name, frame, title, body, label: none, numbered: true) = {
  figure(
    kind: kind,
    supplement: name,
    placement: none,
    caption: none,
    gap: 0pt,
    block(..frame)[
      #set align(left)
      #counter(kind).step()
      #let heading = if frame == accent-frame {
        accent-frame-heading
      } else if frame == dash-frame {
        dash-frame-heading
      } else if frame == plain-frame {
        plain-frame-heading
      } else if frame == red-frame {
        red-frame-heading
      } else {
        panic("unknown frame type")
      }
      #heading(if numbered {
        let num = context { [#current_chapter().index.at(0).] + counter(kind).display() }
        [#name#h(.3em) #num #h(.5em) #title]
      } else {
        name + h(.5em) + title
      })
      #body
    ],
  )
}

#let example(title: none, body) = environment(
  "example",
  "Example",
  dash-frame,
  title,
  body,
)

#let proposition(title: none, body) = environment("proposition", "Proposition", accent-frame, title, body)
#let definition(title: none, body) = environment("definition", "Definition", accent-frame, title, body)

#let proof(title: none, body) = {
  let title = if title != none [(#title)]
  let body = {
    title + body + h(1fr) + text(_color_palette.accent, _qed_symbol)
  }
  if "children" in body.fields() {
    let children = body.children
    let last = children.pop()
    if last.func() == math.equation {
      body = title + children.push(last + place(right + bottom, text(_color_palette.accent, _qed_symbol)))
      [].func()(children)
    }
  }
  environment(numbered: false, "proof", "Proof.", plain-frame, none, body)
}

#let highlight-eq(body) = {
  // set box(
  //   // fill: _color_palette.accent-light,
  //   stroke: _color_palette.accent,
  //   inset: .5em,
  // )
  // TODO: add highlight
  body
}
