#import "components.typ": *
#import "../packages.typ": *

/// text properties for the main body
#let _main_size = 10pt
#let _lineskip = 0.75em
#let _parskip = _lineskip //1.2em
#let _eq_spacing = 1em
#let _figure_spacing = 1.5em
#let _heading1_size = 24pt
#let _heading2_size = 16pt
#let _heading3_size = 1.2 * _main_size
#let _margin = (y: 2cm, inside: 2cm, outside: 1.3cm, extent: 2.5cm)

// for the "book" weights of NCM font
#let default_weight = 400

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

  let serif = text.with(font: serif_font)
  let sans = text.with(font: sans_font)
  let italic = text.with(font: italic_font)
  let semi = text.with(weight: "semibold")

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
    paper: "jis-b5",
    margin: (y: _margin.y, inside: _margin.inside, outside: _margin.outside + _margin.extent),
    //for draft
    background: if draft {
      watermark(text(25pt, fill: rgb("#e8eaf1"), sans(upper(draft))))
    },
    header: context if not is_starting() and current_chapter() != none {
      let (index: (chap_idx, sect_idx), body: (chap, sect)) = current_chapter()
      let chap_prefix = [
        #if chap_idx > 0 {
          semi[篇#chap_idx] + h(1em, weak: true)
        }
        #chap
      ]
      let sect_prefix = [
        #if sect_idx != none and sect_idx > 0 {
          semi[#numbering("1.1", chap_idx, sect_idx)] + h(1em, weak: true)
          sect
        }
      ]

      if lang == "zh" {
        let page_num = semi(current_page())
        let skip = h(_margin.extent - measure(page_num).width, weak: true)
        sans[
          #if two_sided {
            if is_even_page() [
              #h(-_margin.extent)#page_num#skip#chap_prefix
            ] else [
              #set align(right)
              #sect_prefix#skip#page_num#h(-_margin.extent)
            ]
          } else [
            #chap_prefix
            #h(1fr)
            #page_num
          ]
        ]
      } else {
        sans[#chap_prefix #h(1fr) #page_num]
      }
    },
    footer: context if is_starting() {
      let page = sans(semi(current_page()))
      if is_even_page() [
        #h(-_margin.extent) #page #h(1fr)
      ] else [
        #h(1fr) #page #h(-_margin.extent)
      ]
    },
    // footer-descent: 30% + 0pt, // default
    // header-ascent: 30% + 0pt,  // default
    numbering: "I",
  )
  counter(page).update(1)

  // set the font for main texts
  set text(
    size: _main_size,
    font: serif_font,
    weight: default_weight,
    lang: lang,
    region: config.at("region", default: none),
  )

  /*-- Math Related --*/
  set math.equation(numbering: num => numbering("(1.1)", counter(heading).get().first(), num))
  show math.equation: set text(font: math_font, weight: default_weight, features: ("cv01",))
  show math.equation: set block(spacing: _eq_spacing)
  show math.equation: it => {
    if it.block {
      let eq = if it.has("label") { it } else [
        #counter(math.equation).update(v => if v == 0 { 0 } else { v - 1 })
        #math.equation(it.body, block: true, numbering: none)#label("")
      ]
      eq
    } else {
      h(0.25em, weak: true) + it + h(0.25em, weak: true)
    }
  }
  // set paragraph style
  set par(leading: _lineskip, spacing: _parskip, first-line-indent: 2em, justify: true)
  show raw: set text(font: mono_font, weight: "regular")

  set heading(numbering: "1.1")
  set heading(supplement: it => if it.depth == 1 [Chapter] else [Section]) if lang == "en"
  set heading(supplement: "章") if lang == "ja"
  set heading(supplement: config.chapter) if lang == "zh"

  /* ---- Customization of Chap. Heading ---- */
  show heading.where(level: 1): styled_heading(
    kind: "chapter",
    lineskip: _lineskip,
    text_size: _heading1_size,
    config: config,
  )

  show heading.where(level: 2): it => {
    show: block.with(spacing: _heading2_size)
    set text(_heading2_size, weight: "medium", font: sans_font, fill: color_palette.primary)
    v(_main_size)
    counter(heading).display(it.numbering)
    h(11pt)
    it.body
  }

  show heading.where(level: 3): it => {
    show: block.with(spacing: _heading3_size)
    set text(weight: 500, font: sans_font, fill: color_palette.primary)
    v(0.5 * _main_size)
    [\u{258C}#it.body]
  }

  /* ---- Customization of ToC ---- */
  set outline(indent: auto, depth: 2, title: config.toc)

  show outline: it => {
    set page(numbering: "I")
    set par(leading: 1em, spacing: 0.5em)
    it
    justify_page()
  }

  show outline.entry.where(level: 1): it => {
    set text(font: sans_font, weight: "medium", fill: color_palette.primary)
    set block(above: 1.25em)
    let prefix = if it.element.numbering == none { none } else if lang == "zh" { it.element.supplement + it.prefix() }
    let body = upper(it.body() + h(1fr) + it.page())
    link(
      it.element.location(),
      it.indented(prefix, body),
    )
  }

  /* ---- Customization of Table&Image ---- */
  set figure(
    gap: _lineskip, //default behavior of Typst, explicit setting for clarity
    numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()),
  )
  show figure: set block(spacing: _figure_spacing)
  set figure.caption(separator: text(font: "Zapf Dingbats")[❘])

  show figure.caption: it => {
    set par(leading: _lineskip, first-line-indent: 0pt, justify: false)
    align(left)[
      #sans(fill: color_palette.primary, weight: "medium")[
        #it.supplement
        #context counter(figure.where(kind: it.kind)).display()
      ] #it.separator #it.body
    ]
  }

  set table(stroke: none, align: horizon + center)
  show figure.where(kind: table): set figure(supplement: config.table)
  show figure.where(kind: table): it => {
    set figure(supplement: config.table)
    set figure.caption(position: top)
    it
  }
  show figure.where(kind: image): set figure(supplement: config.figure)
  show figure.where(kind: image): fig_with_auto_caption.with(margin_ext: _margin.extent, gap: _parskip)

  /* ---- Customization of ref ---- */
  // show ref: it => {
  //   let eq = math.equation
  //   let el = it.element
  //   if el != none and el.func() == eq {
  //     // Override equation references.
  //     link(
  //       el.location(),
  //       numbering(
  //         el.numbering,
  //         ..counter(eq).at(el.location()),
  //       ),
  //     )
  //   } else {
  //     // Other references as usual.
  //     it
  //   }
  // }

  /*-- emph --*/
  show emph: italic

  show "。": "．"
  show "，": "、"
  show "？！": "‽"

  /// Main body.
  body
}

/// weak: if false, a pagebreak will be added after the body
#let standalone(config) = (weak: false, ..args) => body => {
  heading(supplement: none, numbering: none, ..args)

  body
  if not weak {
    justify_page()
  }
}

#let mainbody(body) = {
  set page(numbering: "1")
  // reset the counter for the main body
  counter(page).update(1)
  body
}

// TODO: specify the appendix heading
#let appendix(config) = body => {
  justify_page()
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

    show heading.where(level: 1): styled_heading(
      kind: "appendix",
      lineskip: _lineskip,
      text_size: _heading1_size,
      config: config,
    )

    body
  }
}


