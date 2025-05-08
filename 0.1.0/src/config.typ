// #let config = (
//   en: (
//     lang: "en",
//     appendix: (supplement: "Appendix", numbering: "A.1"),
//     title_font: ("Barlow", "尙古黑體SC"),
//     sans_font: ("Barlow", "尙古黑體SC"),
//     serif_font: ("Libertinus Serif", "尙古明體SC"),
//     math_font: "TeX Gyre Pagella Math",
//     mono_font: "IBM Plex Mono",
//     draft: "draft",
//     date_format: "[month repr:long] [year]",
//     proof: [_Proof._],
//   ),
//   zh: (
//     lang: "zh",
//     region: "CN",
//     figure: "圖",
//     table: "表",
//     chapter: "篇",
//     section: "節",
//     toc: "目錄",
//     appendix: (
//       supplement: "附錄",
//       numbering: (a, ..) => {
//         ("甲", "乙", "丙", "丁", "戊", "己", "庚", "辛", "壬", "癸").at(a - 1)
//       },
//     ),
//     title_font: ((name: "Lexend", covers: "latin-in-cjk"), "尙古黑體SC"),
//     sans_font: ((name: "Lexend", covers: "latin-in-cjk"), "尙古黑體SC"),
//     serif_font: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "尙古明體SC"),
//     math_font: ("TeX Gyre Pagella Math", "尙古明體SC"),
//     mono_font: "IBM Plex Mono",
//     italic_font: ((name: "TeX Gyre Termes", covers: "latin-in-cjk"), "Zhuque Fangsong (technical preview)"),
//     draft: "稿",
//     date_format: "[year] 年 [month repr:numerical] 月",
//     proof: [_證明_],
//   ),
//   ja: (
//     lang: "ja",
//     appendix: (supplement: "付録", numbering: "A.1"),
//     sans_font: ((name: "Lexend", covers: "latin-in-cjk"), "Noto Sans CJK JP"),
//     serif_font: ((name: "Libertinus Serif", covers: "latin-in-cjk"), "Noto Serif CJK JP"),
//     math_font: "Libertinus Math",
//     mono_font: "IBM Plex Mono",
//     draft: "下書き",
//     date_format: "[year] 年 [month repr:numerical] 月",
//   ),
// )
#let _lang = "en"
#let _appendix = (supplement: "Appendix", numbering: "A.1")
#let _title_font = ("Barlow", "尙古黑體SC")
#let _sans_font = ("Barlow", "尙古黑體SC")
#let _serif_font = ("Libertinus Serif", "尙古明體SC")
#let _math_font = "TeX Gyre Pagella Math"
#let _mono_font = "IBM Plex Mono"
#let _draft = "draft"
#let _date_format = "[month repr:long] [year]"
#let _proof = [_Proof._]
#let _main_size = 11pt
#let _lineskip = 0.75em
#let _parskip = _lineskip //1.2em
#let _eq_spacing = 1em
#let _figure_spacing = 1.5em
#let _heading1_size = 24pt
#let _heading2_size = 15pt
#let _heading3_size = 1.2 * _main_size
#let _page_top_margin(page_style) = if page_style == "top" { 20mm } else { 16mm } + _main_size
#let _page_bottom_margin = 2cm
#let _page_num_size = 15pt
#let _page_margin = 15mm
#let _page_geo(page_style) = (
  inner: (far: _page_margin, width: 0mm, sep: 0mm),
  outer: (far: _page_margin, width: 40mm, sep: 8mm),
  top: _page_top_margin(page_style),
  bottom: _page_bottom_margin,
  clearance: _main_size,
)
#let _chap_top_margin = 100mm
// for the "book" weights of NCM font
#let _default_weight = 400
#let _subheading_size = 13pt

#let _color_palette = (
  accent: rgb(85, 117, 137),
  accent-light: rgb(246, 248, 249),
  grey: rgb(100, 100, 100),
  grey-light: rgb(224, 228, 228),
)
