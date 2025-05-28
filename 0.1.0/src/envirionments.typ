#import "components.typ": * // import components
#import "config.typ"
#import "packages/marginalia.typ": * // import package

// #let red-frame-heading(it) = {
//   set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: _color_palette.red)
//   show text: upper
//   block(it, spacing: 1em)
// }

// #let red-frame = (fill: _color_palette.red-light, width: 100%, inset: 1em, radius: (top-left: 0pt, rest: 1em))

#let _env_state = state("env", (:))

#let _reset_env_counting() = _env_state.update(it => it.keys().map(k => (k, 0)).to-dict())

#let accent-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: _color_palette.accent)
  show text: upper
  block(it, spacing: 1em, sticky: true)
}

#let accent-frame = (
  fill: _color_palette.accent-light,
  width: 100%,
  outset: 0pt,
  inset: 1em,
  // radius: 5pt,
)

#let accent-topdeco = {
  block(height: 5pt, width: 100%, fill: _color_palette.accent, outset: 0pt, below: 0pt)
}

#let accent-bottomdeco = {
  block(height: 5pt, width: 100%, fill: _color_palette.accent, outset: 0pt, above: 0pt)
}

#let dash-frame-heading(it) = {
  set text(font: config._sans_font, weight: 500, tracking: 0.07em, size: config._main_size, fill: black)
  show text: upper
  block(it, spacing: 1em)
}

#let dash-frame = (
  stroke: (left: (thickness: 1.2pt, paint: _color_palette.accent, dash: "densely-dashed")),
  width: 100%,
  inset: (right: 0pt, rest: 0.75em),
  sticky: true,
)


#let plain-frame-heading(it) = {
  text(style: "italic", it)
}

#let plain-frame = {
  (width: 100%)
}


#let environment(
  kind,
  name,
  topdeco: none,
  bottomdeco: none,
  frame,
  title,
  body,
  label: none,
  numbered: true,
) = {
  _env_state.update(it => it + (str(kind): it.at(kind, default: 0) + 1))
  let heading = if frame == accent-frame {
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
  show figure.where(kind: kind): set block(breakable: true)
  show figure.where(kind: kind): set par(spacing: _envskip)
  [#figure(
      kind: kind,
      supplement: name,
      placement: none,
      caption: none,
      {
        set align(left)
        topdeco
        block(
          ..frame,
          [
            #heading(if numbered {
              let num = context [#current_chapter().index.at(0).#_env_state.get().at(kind)]
              [#name#h(.3em) #num #h(.5em) #title]
            } else {
              name + h(.5em) + title
            })
            #body
          ],
        )
        bottomdeco
      },
    ) #label]
}

#let example(title: none, body) = environment(
  "example",
  "Example",
  dash-frame,
  title,
  body,
)

#let proposition(title: none, body) = environment(
  "proposition",
  "Proposition",
  topdeco: accent-topdeco,
  bottomdeco: accent-bottomdeco,
  accent-frame,
  title,
  body,
)

#let definition(title: none, body) = environment("definition", "Definition", accent-frame, title, body)

#let proof(title: none, body) = {
  let title = if title != none [(#title)]
  let _body = {
    title + body + h(1fr) + text(_color_palette.accent, _qed_symbol)
  }
  if "children" in body.fields() {
    let children = body.children
    let last = children.pop()
    if last.func() == math.equation {
      children.push(last + place(right + bottom, text(_color_palette.accent, _qed_symbol)))
      _body = [].func()(title + children)
    }
  }
  environment(numbered: false, "proof", "Proof.", plain-frame, none, _body)
}

#let highlighteq(body) = {
  $
    #box(fill: _color_palette.accent-light, stroke: _color_palette.accent + 0.5pt, inset: 1em, body)
  $
}

