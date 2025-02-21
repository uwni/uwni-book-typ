#import "i18n.typ": *
#import "utils.typ": color_palette

#let draft_seal = {
  show: place.with(bottom + right)
  show: block.with(
    inset: 1em,
    fill: color_palette.a.red,
  )
  set align(center)
  set text(font: i18n.at("en").sans_font, fill: white, weight: "black")
  text(size: 2em)[DRAFT]
  linebreak()
  text(size: 1.2em, weight: "bold", datetime.today().display())
}


///
/// Title page
/// style 1
///
#let classic_title(
  lang,
  title,
  author,
  date,
  degree,
  major,
  supervisor,
  department,
  draft,
) = page(
  // explicitly set the paper
  paper: "a4",
  background: image("assets/background.svg", 
  width: 100%
), numbering: none)[
  #let i18n = i18n.at(lang)
  // set page(background: image("assets/cover.svg", height: 100%))
  // place(dx: 270pt, dy: 180pt, image("assets/logo.svg", width: 50%))
  #set align(center)
  #set text(13.75pt, weight: 450)

  #let large = text.with(16.5pt)
  #let title_text = text.with(22pt, weight: "bold", font: ("New Computer Modern", "Noto Serif CJK JP"))

  #title_text[
    #set par(justify: false)
    #title.en\
    #title.ja
  ]

  #v(1fr)

  #par(leading: 1.5em)[
    by\
    #large[*#author*]
  ]


  #v(1.5fr)

  #image("assets/SVG/アセット 4.svg", width: 25%)

  #v(2fr)
  #par(leading: 1em, spacing: 1.5em)[
    Submitted to the\
    #department, \
    #large(smallcaps[Institute of Science Tokyo])\
    in partial fulfilment of the requirements for the degree of\
    #large(smallcaps(degree))\
    in #major

    Under the supervision of\
    #large(supervisor)
  ]
  #v(1fr)
  #date.display(i18n.date_format)

  #if draft {
    draft_seal
  }
]


///
/// Title page
/// style 2
///
#let modern_title(
  lang,
  title,
  author,
  date,
  degree,
  major,
  supervisor,
  department,
  draft,
) = {
  let config = i18n.at(lang)
  set page(  // explicitly set the paper
    paper: "a4",
    background: image("assets/background.svg", width: 100%), 
    numbering: none, 
    margin: (top: 3.5cm)
  )

  set par(first-line-indent: 0pt, leading: 1em, spacing: 1em)
  set text(13.75pt, weight: 450, font: config.serif_font, lang: lang)
  set align(right)

  let large = text.with(16.5pt)
  let title_text = text.with(22pt, weight: "semibold")

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
      #title_text(font: i18n.at("en").sans_font, title.en, lang: "en")\
      #title_text(font: i18n.at("ja").sans_font, title.ja, lang: "ja")
    ]

    #v(1fr)

    #[
      #set par(leading: 1em, spacing: 2em)
      by\
      #large[*#author_en\ #author_ja*]
    

      under the supervision of\
      #large(supervisor)
    

      #v(1fr)
   
      Submitted to the\
      #department \
      #large(smallcaps[Institute of Science Tokyo])\
      in partial fulfilment of the requirements for the degree of\
      #large(smallcaps(degree))\
      in #major
    ]

    #v(1fr)
    #date.display(config.date_format)
    #v(1fr)
    #align(left, image("assets/SVG/アセット 4.svg", width: 25%))
  ]

  if draft {
    draft_seal
  }

  // for two-sided printing
  // pagebreak()
  // set page(background: none)
  // pagebreak()
}


#let titlepage(style: "", ..args) = {
  (
    "classic": classic_title(..args),
    "modern": modern_title(..args),
  ).at(style)
}
