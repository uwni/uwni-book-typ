
///
/// this file is used to import and config packages
///

#import "../lib.typ": *
#let (
  isct_thesis,
  titlepage,
  standalone,
  mainbody,
  appendix,
  outline
) = config_isct(
  // ["en"|"ja"]
  config: "zh",
  title: (
    zh: [
       分析學補遺  
    ],
    en: [
      Analysis Note
    ],
  ),
  // author information
  author: (en: "Taro Tokodai", ja: "東工大 太郎"),
  // report date
  date: datetime.today(),
  // set to true to enable draft watermark, so that you can prevent from submitting a draft version
  draft: false,
  // set to true to enable two-sided layout
  two_sided: true,
  // "modern"|"classic"
  title_style: "book",
)

//delete this line if you do not need the lorem ipsum for japnese language, as it only for demostration
#import "@preview/roremu:0.1.0"
#import "@preview/physica:0.9.4"

#import "@preview/cetz:0.3.4"
#import "@preview/cetz-plot:0.1.1": plot, chart
#import "@preview/equate:0.3.0"