#import "components.typ": *
#import "../packages/marginalia.typ": *
#import "index.typ": use_word_list
#import "config.typ" as config
#import config: *

#let _page_geo = (
  inner: (far: _page_margin, width: 0mm, sep: 0mm),
  outer: (far: _page_margin, width: _page_margin_note_width, sep: _page_margin_sep),
  top: _page_top_margin,
  bottom: _page_bottom_margin,
  clearance: _main_size,
)

/// text properties for the main body
#let _pre_chapter() = {
  counter(math.equation).update(0)
  counter(figure.where(kind: table)).update(0)
  counter(figure.where(kind: image)).update(0)
  counter(figure.where(kind: raw)).update(0)
  pagebreak(weak: true)
}

#let preamble(body) = {
  set page(numbering: "I")
  body
}

#let page-number(offset: 0pt) = context {
  let number = text(_page_num_size, font: _sans_font, weight: "semibold", current_page())

  if is_even_page() [
    #h(-offset)#number#h(1fr)
  ] else [
    #h(1fr)#number#h(-offset)
  ]
}

#let template(
  title,
  author,
  date,
  draft,
  two_sided,
  chap_imgs,
  body,
) = {
  ///utilities
  let sans = text.with(font: _sans_font)
  let italic = if "_italic_font" in dictionary(config) { text.with(font: { _italic_font }) } else { text }
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
  let marginaliaconfig = (
    .._page_geo,
    book: two_sided,
    numbering: note-numbering,
  )

  marginalia.configure(..marginaliaconfig)

  set page(
    // explicitly set the paper
    paper: "a4",
    ..marginalia.page-setup(..marginaliaconfig),
    header: context if not is_starting() and current_chapter() != none {
      marginalia.notecounter.update(0)
      let (index: (chap_idx, sect_idx), body: (chap, sect)) = current_chapter()
      let chap_prefix = upper[
        #if chap_idx > 0 {
          set text(_color_palette.accent)
          semi[Chapter#h(.5em)#chap_idx] + [#h(0.5em, weak: true)•#h(0.5em, weak: true)]
        }
        #chap
      ]
      let sect_prefix = upper[
        #if sect_idx != none and sect_idx > 0 {
          semi[#numbering("1.1", chap_idx, sect_idx)] + h(1em, weak: true)
          sect
        }
      ]
      let book = marginalia._config.get().book
      let book_left = book and is_even_page()
      let x_alignmnent = if book_left {
        left
      } else {
        right
      }
      set align(x_alignmnent)
      set text(font: _sans_font)

      let leftm = marginalia.get-left()
      let rightm = marginalia.get-right()
      let page_num = semi(_page_num_size, current_page())

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
            text(_main_size, if book_left { chap_prefix } else { sect_prefix }),
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

      wideblock(
        double: true,
        page-number(),
      )
    },
    footer-descent: 30% + 0pt, // default
    header-ascent: 30% + 0pt, // default
    numbering: "1",
  )

  counter(page).update(1)

  // set the font for main texts
  set text(
    size: _main_size,
    font: _serif_font,
    weight: _default_weight,
    lang: _lang,
  )

  set text(_region) if "_region" in dictionary(config)

  /*-- Math Related --*/
  set math.equation(numbering: (..num) => numbering("(1.1.a)", counter(heading).get().first(), ..num))
  show math.equation: set text(font: (_math_font, .._serif_font), weight: _default_weight)
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
  set math.cases(gap: _lineskip)


  // set paragraph style
  set par(leading: _lineskip, spacing: _parskip, first-line-indent: 1em, justify: true)
  show raw: set text(font: _mono_font, weight: "regular")

  set heading(numbering: "1.1")
  set heading(supplement: it => if it.depth == 1 [Chapter] else [Section]) if _lang == "en"
  set heading(supplement: "章") if _lang == "ja"
  set heading(supplement: _chapter) if _lang == "zh"
  show heading.where(level: 1): it => {
    _pre_chapter()
    wideblock(
      _standalone_heading(
        top_margin: _page_top_margin,
        it,
      ),
    )
  }

  show heading.where(level: 2): it => block(
    below: 1.5em,
    above: 2em,
    width: 100%,
    outset: (top: .5em),
    stroke: (top: _color_palette.accent),
    {
      set text(_heading2_size, weight: "bold", font: _sans_font, fill: _color_palette.accent)
      text(counter(heading).display(it.numbering))
      h(.5em)
      it.body
    },
  )

  show heading.where(level: 3): it => {
    show: block.with(above: 1.5em, below: 1em)
    set text(weight: 600, font: _sans_font, fill: black, tracking: 0.07em)
    upper(it.body)
  }
  /*-- emph --*/
  show emph: italic
  // show strong: set text(_color_palette.accent)

  show "。": "．"
  show "，": "、"
  show "？！": "‽"

  /// Main body.
  body
}

#let _outline(..args) = {
  set outline(indent: auto, depth: 2)
  set outline(title: _toc) if "toc" in dictionary(config)

  set page(
    margin: (top: _page_top_margin, x: _page_margin + _page_margin_sep),
    header: none,
    footer: page-number(offset: _page_margin_sep),
    numbering: "I",
  )
  set par(leading: 1em, spacing: 0.5em)

  show outline.entry.where(level: 1): it => {
    set text(font: _sans_font, weight: "bold", fill: _color_palette.accent)
    set block(above: 1.25em)
    let prefix = if it.element.numbering == none { none } else if _lang == "zh" {
      it.element.supplement + it.prefix()
    }
    let body = upper(it.body() + h(1fr) + it.page())
    link(
      it.element.location(),
      it.indented(prefix, body),
    )
  }
  _toc_heading(heading(outlined: false, numbering: none, "Table of Contents", depth: 1))
  columns(2, [#outline(..args, title: none)#v(1pt)])
}

#let mainbody(body, two_sided, chap_imgs) = {
  // make sure the page is start at right 
  justify_page()
  let sans = text.with(font: _sans_font)

  let marginaliaconfig = (
    .._page_geo,
    book: two_sided,
  )

  marginalia.configure(..marginaliaconfig)

  set page(
    ..marginalia.page-setup(..marginaliaconfig),
    //for draft
    background: context if is_starting() {
      set image(width: 100%)
      place(
        top + center,
        block(
          chap_imgs.at(counter(heading).get().at(0)),
          clip: true,
          width: 100%,
          height: _chap_top_margin,
          radius: (bottom-right: _page_margin),
        ),
      )
    },
    numbering: "1", // setup margins:
  )

  show heading.where(level: 1): it => {
    _pre_chapter()
    wideblock(
      double: true,
      _fancy_chapter_heading(
        top_margin: _page_top_margin,
        chap_top_margin: _chap_top_margin,
        it,
      ),
    )
    marginalia.note(
      text-style: note_text_style,
      par-style: note_par_style,
      numbered: false,
      shift: false,
      keep-order: true,
      {
        let nexth2 = heading.where(level: 2).after(here())
        let nexth1 = heading.where(level: 1, outlined: true).after(here(), inclusive: false)
        if query(nexth2.before(nexth1)) != () {
          block(spacing: 1em, [*Sections*])
        }
        outline(target: nexth2.before(nexth1), indent: n => (n - 1) * 1em, depth: 2, title: none)
      },
    )
    // marginalia leaves a blank space here. therefore, we need to
    // eliminate the space.
    h(0pt, weak: true)
  }

  /* ---- Customization of Table&Image ---- */
  set figure(
    gap: 0pt,
    numbering: (..num) => numbering("1.1", counter(heading).get().first(), num.pos().first()),
  )
  show figure.where(kind: image): set block(spacing: _figure_spacing)
  show figure.where(kind: table): set block(spacing: _figure_spacing)

  set figure.caption(position: top, separator: sym.space)
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
      let height = measure(width: marginaliaconfig.outer.width, block(it)).height
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
  show figure.where(kind: table): set figure(supplement: _i18n.table) if (
    "_i18n" in dictionary(config) and "table" in _i18n
  )
  show figure.where(kind: image): set figure(supplement: _i18n.figure) if (
    "_i18n" in dictionary(config) and "figure" in _i18n
  )

  // reset the counter for the main body
  counter(page).update(1)
  counter(heading).update(0)
  body
}


// TODO: specify the appendix heading
#let appendix(body) = {
  justify_page()

  let (supplement, numbering: _numbering) = _appendix
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
    pagebreak()
    show heading.where(level: 1): it => {
      _pre_chapter()
      wideblock(
        _appendix_heading(
          top_margin: _page_top_margin,
          chap_top_margin: _chap_top_margin,
          it,
        ),
      )
    }

    body
  }
}

#let subheading(body) = {
  set par(leading: 0.5em)
  v(0pt, weak: true)
  block(text(font: _sans_font, _subheading_size, style: "italic", weight: 500, black, body))
  v(_lineskip)
}

#let make_index(group: "default", indent: 1em, separator: [, ], columns: 3) = {
  justify_page()
  set page(
    margin: (top: _page_top_margin, x: _page_margin + _page_margin_sep),
    header: none,
    footer: page-number(offset: _page_margin_sep),
  )
  heading(depth: 1)[index]
  show: std.columns.with(columns)
  use_word_list(
    group,
    it => {
      for (id, entries) in it {
        heading(
          level: 3,
          depth: 1,
          numbering: none,
          id,
        )
        for entry in entries {
          let (word, children, min_page, max_page) = entry
          let _entry = {
            let page_range = if min_page == max_page {
              min_page
            } else {
              [#min_page\-#max_page]
            }
            block[#word#separator#page_range]
            for child in children {
              let (modifier, loc) = child
              if modifier == none { continue }
              block[#h(indent)#modifier#separator#loc.join(",")]
            }
          }
          block(_entry)
        }
      }
    },
  )
}
