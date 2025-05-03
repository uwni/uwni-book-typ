#let book_title(
  config,
  title,
  author,
  department,
  date,
  draft,
) = {
  let (serif_font, sans_font, title_font, date_format, lang) = config
  set page(
    // explicitly set the paper
    background: image("assets/background.svg", width: 100%),
    numbering: none,
    margin: (top: 3.5cm),
  )

  set par(first-line-indent: 0pt, leading: 1em, spacing: 1em)
  set text(13.75pt, weight: 450, font: serif_font, lang: lang)
  set align(right)

  let large = text.with(16.5pt)
  let title_text = text.with(22pt, font: title_font, weight: 600)
  let title_cn_text = text.with(32pt, font: "FZZJ-XHLSHUJF", weight: 600)

  let author_en = if type(author) == dictionary {
    author.at("en")
  } else if type(author) == string {
    author
  } else if type(author) == array {
    author.at(0)
  } else {
    panic("cannot resolve author info")
  }

  let author_ja = if type(author) == dictionary {
    [（#author.at("ja", default: none)）]
  } else {
    none
  }

  [
    #par(justify: false)[
      #title_text(title.en, lang: "en")\
      #title_cn_text(title.at(lang), lang: lang)
    ]

    #v(1fr)

    #[
      #set par(leading: 1em, spacing: 2em)
      by\
      #large[*#author_en\ #author_ja*]


      under the supervision of\

      #v(1fr)

      分析補遺
      代數補遺
    ]

    #v(1fr)
    #date.display(date_format)
    #v(1fr)
    #align(left, image("assets/SVG/アセット 4.svg", width: 25%))
  ]

  if draft {
    draft_seal
  }
}

#let titlepage(style: "", ..args) = {
  set page(paper: "a4")

  (
    "book": book_title(..args),
  ).at(style)
  pagebreak(to: "odd")
}
