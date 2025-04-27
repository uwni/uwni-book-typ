#import "components.typ": *
#import "../packages.typ": *

/// text properties for the main body
#let _main_size = 11pt
#let _lineskip = 0.75em
#let _parskip = _lineskip //1.2em
#let _eq_spacing = 1em
#let _figure_spacing = 1.5em
#let _heading1_size = 24pt
#let _heading2_size = 16pt
#let _heading3_size = 1.2 * _main_size
#let _page_top_margin = 2.5cm
#let _page_bottom_margin = 2.5cm

// for the "book" weights of NCM font
#let default_weight = 400
#let _outline(config, ..args) = {
  set outline(indent: auto, depth: 2, title: config.toc)
  set par(leading: 1em, spacing: 0.5em)


  show outline.entry.where(level: 1): it => {
    set text(font: config.sans_font, weight: "medium", fill: color_palette.primary)
    set block(above: 1.25em)
    let prefix = if it.element.numbering == none { none } else if config.lang == "zh" {
      it.element.supplement + it.prefix()
    }
    let body = upper(it.body() + h(1fr) + it.page())
    link(
      it.element.location(),
      it.indented(prefix, body),
    )
  }

  justify_page()
  outline(..args)
}

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
  let marginalia_config = (
    inner: (far: 15mm, width: 0mm, sep: 5mm),
    outer: (far: 15mm, width: 30mm, sep: 5mm),
    top: _page_top_margin,
    bottom: _page_bottom_margin,
    book: two_sided,
    clearance: 8pt,
  )

  marginalia.configure(..marginalia_config)

  set page(
    // explicitly set the paper
    paper: "a4",
    ..marginalia.page-setup(..marginalia_config),
    //for draft
    background: if draft {
      watermark(text(25pt, fill: rgb("#e8eaf1"), sans(upper(draft))))
    },
    header: context if not is_starting() and current_chapter() != none {
      marginalia.notecounter.update(0)
      let book = marginalia._config.get().book
      let leftm = marginalia.get-left()
      let rightm = marginalia.get-right()
      let (index: (chap_idx, sect_idx), body: (chap, sect)) = current_chapter()
      let book_left = book and is_even_page()
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
      let page_num = block(
        fill: blue,
        height: 100%,
        outset: (y: 1em, x: 1em),
        semi(fill: white, current_page()),
      )
      set align(if not book_left { right } else { left })
      set text(font: sans_font)
      wideblock(
        double: true,
        {
          box(
            width: leftm.width,
            if book_left [
              #page_num
            ],
          )
          h(leftm.sep)
          box(
            width: 1fr,
            if not book_left { sect_prefix } else { chap_prefix },
          )
          h(rightm.sep)
          box(
            width: rightm.width,
            if not book_left {
              page_num
            },
          )
        },
      )
    },
    footer: context if is_starting() {
      let leftm = marginalia.get-left()
      let rightm = marginalia.get-right()
      let page = sans(semi(current_page()))
      wideblock(
        double: true,

        {
          if is_even_page() [
            #page
          ]
          h(leftm.sep)
          h(1fr)
          h(rightm.sep)
          if not is_even_page() [
            #page
          ]
        },
      )
    },
    footer-descent: 30% + 0pt, // default
    header-ascent: 30% + 0pt, // default
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

#let mainbody(body, config, two_sided) = {
  let (
    serif_font,
    sans_font,
    math_font,
    mono_font,
    italic_font,
    lang,
  ) = config

  let sans = text.with(font: sans_font)

  let marginalia_config = (
    inner: (far: 15mm, width: 0mm, sep: 7.5mm),
    outer: (far: 15mm, width: 40mm, sep: 7.5mm),
    top: _page_top_margin,
    bottom: _page_bottom_margin,
    book: two_sided,
    clearance: 8pt,
  )

  marginalia.configure(..marginalia_config)

  set page(
    numbering: "1", // setup margins:
    ..marginalia.page-setup(..marginalia_config),
  )

  /* ---- Customization of Table&Image ---- */
  set figure(
    gap: 0pt,
    numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()),
  )
  show figure: set block(spacing: _figure_spacing)
  set figure.caption(position: top, separator: [:])
  show figure.caption: it => [
    #set text(..note_text_style)
    #set par(..note_par_style)
    #box(
      sans(weight: "medium")[
        #it.supplement
        #context counter(figure.where(kind: it.kind)).display()
      ]
        + it.separator,
    )
    #it.body
  ]

  show figure: it => layout(((width, height)) => {
    let f_height = measure(width: width, height: height, it.body).height
    let overheight = 2 * f_height > height
    set figure(gap: 0pt)

    show figure.caption.where(position: top): it => context {
      let height = measure(width: marginalia_config.outer.width, block(it)).height
      note(
        numbered: false,
        dy: if overheight { 0pt } else { f_height - height },
        align-baseline: false,
        keep-order: true,
        it,
      )
    }

    it
  })

  set table(stroke: none, align: horizon + center)
  show figure.where(kind: table): set figure(supplement: config.table)
  show figure.where(kind: image): set figure(supplement: config.figure)

  show heading.where(level: 1): it => {
    it
    place(
      top,
      note(
        numbered: false,
        shift: false,
        dy: 1.5cm,
        {
          let nexth2 = heading.where(level: 2).after(here())
          let nexth1 = query(heading.where(level: 1, outlined: true).after(here())).at(1)
          if query(nexth2.before(nexth1.location())).len() > 0 {
            block(spacing: 1em, sans[*Contents*])
          }
          outline(target: nexth2.before(nexth1.location()), indent: n => (n - 1) * 1em, depth: 2, title: none)
        },
      ),
    )
  }

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


