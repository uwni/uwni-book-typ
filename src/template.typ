#import "utils.typ": *
#import "../packages.typ": *

#let template(
  config,
  title,
  author,
  date,
  draft,
  two_sided,
  body,
) = {
  ///utilities
  let (
    serif_font,
    sans_font,
    math_font,
    mono_font,
    italic_font,
    lang,
  ) = config
  /// text properties for the main body
  let main_size = 11pt
  let lineskip = 0.65em
  let parskip = 1.2em
  let heading1_size = 1.5em
  let heading2_size = 1.2em
  let heading3_size = 1.2em

  // for the "book" weights of NCM font
  let default_weight = 450

  let serif = text.with(font: serif_font)
  let sans = text.with(font: sans_font)
  let italic = text.with(font: italic_font)

  /// Set the document's basic properties.
  let author_en = if type(author) == dictionary {
    author.at("en")
  } else if type(author) == string {
    author
  } else if type(author) == array {
    author.at(0)
  } else {
    panic("cannot resolve author info")
  }

  set document(title: title.en, author: author_en, date: date)

  set page(
    // explicitly set the paper
    paper: "a4",
    margin: (top: 3cm, bottom: 2.5cm),
    //for draft
    background: if draft {
      watermark(text(25pt, fill: rgb("#e8eaf1"), sans(upper(draft))))
    },
    header: context if not is_starting() and current_chapter() != none {
      let (number, body) = current_chapter()
      sans[§#number~#body #h(1fr) #current_page()]
    },
    footer: align(right, context if is_starting() { sans(current_page()) }),
    footer-descent: 2.5em,
  )

  // set the font for main texts
  set text(main_size, font: serif_font, weight: default_weight, lang: lang, region: config.at("region", default: none))

  /*-- Math Related --*/
  show math.equation: set text(font: math_font, weight: default_weight, features: ("cv01",))

  set math.equation(numbering: num => numbering("(1.1)", counter(heading).get().first(), num))
  show math.equation: it => {
    if it.block {
      if it.has("label") { it } else [
        #counter(math.equation).update(v => if v == 0 { 0 } else { v - 1 })
        #math.equation(it.body, block: true, numbering: none)#label("")
      ]
    } else {
      h(0.25em, weak: true) + it + h(0.25em, weak: true)
    }
  }
  // set paragraph style
  set par(leading: lineskip, spacing: parskip, first-line-indent: 2em, justify: true)
  show raw: set text(font: mono_font, weight: "regular")

  set heading(numbering: "1.1")
  set heading(supplement: it => if it.depth == 1 [Chapter] else [Section]) if lang == "en"
  set heading(supplement: "第") if lang == "ja"
  set heading(supplement: "第") if lang == "zh"

  /* ---- Customization of Chap. Heading ---- */
  show heading.where(level: 1): it => {
    set text(heading1_size, weight: "semibold", font: sans_font)
    set par(spacing: 1.2em, leading: 0.65em, first-line-indent: 0pt, justify: false)
    /// for standalone chapters
    counter(math.equation).update(0)
    counter(figure.where(kind: table)).update(0)
    counter(figure.where(kind: image)).update(0)
    counter(figure.where(kind: raw)).update(0)

    show: pad.with(top: 1.5cm, bottom: 1em)
    block(
      spacing: heading1_size,
      width: 100%,
      stroke: (right: 0.5em),
      outset: (right: -0.25em),
      inset: (right: 1em, bottom: 0.25em),
      if it.numbering == none { upper(it) } else {
        {
          let num = text(1.5em, counter(heading).display(it.numbering))
          set text(weight: "medium")
          if lang == "en" [#smallcaps(it.supplement)~#num] else if lang == "ja" [第 #num 章] else if (
            lang == "zh"
          ) [第 #num 章]
        }
        v(0.25em)
        upper(it.body)
      },
    )
  }

  show heading.where(level: 2): it => {
    show: block.with(spacing: heading2_size)
    set text(heading2_size, weight: "medium", font: sans_font)
    v(main_size)
    counter(heading).display(it.numbering)
    h(11pt)
    it.body
  }

  show heading.where(level: 3): it => {
    show: block.with(spacing: heading3_size)
    set text(weight: 500, font: sans_font)
    v(0.5 * main_size)
    [\u{258C}#it.body]
  }

  /* ---- Customization of ToC ---- */
  set outline(indent: auto, depth: 2)

  show outline: it => {
    set page(numbering: "I")
    set par(leading: 1em, spacing: 0.5em)

    counter(page).update(1)
    it
  }

  show outline.entry.where(level: 1): it => {
    set text(font: sans_font)
    set block(above: 1.25em)
    let prefix = if it.element.numbering != none { it.prefix() }
    let body = upper(it.body() + h(1fr) + it.page())
    link(
      it.element.location(),
      it.indented(prefix, body),
    )
  }

  /* ---- Customization of Table&Image ---- */
  set figure(
    gap: lineskip,
    numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()),
  )

  show figure.caption: it => {
    set align(left)
    set par(leading: lineskip, first-line-indent: 0pt)
    //\u{258C} -> "▌"
    //supplement -> Figure|Table
    //counter.display -> 1.1
    sans[
      \u{258C}#it.supplement
      #context counter(figure.where(kind: it.kind)).display().
    ]
    it.body
  }

  set table(stroke: none, align: horizon + center)

  show figure.where(kind: table): set figure.caption(position: top)

  show figure.where(kind: image): set figure.caption(position: bottom)

  /*-- emph --*/
  show emph: italic

  set page(numbering: "I")
  /// Main body.
  body
}

#let standalone(..args) = heading(supplement: none, numbering: none, ..args)

#let appendix(config) = body => {
  let (supplement, numbering: _numbering) = config.appendix
  context {
    let offset = counter(heading).get().first()
    set heading(
      supplement: supplement,
      numbering: (..num) => numbering(
        _numbering,
        ..{
          let num = num.pos()
          (num.remove(0) - offset, ..num)
        },
      ),
    )
    body
  }
}

#let mainbody(body) = {
  set page(numbering: "1")
  show heading.where(level: 1): it => pagebreak(weak: true) + it
  counter(page).update(1)
  body
}

