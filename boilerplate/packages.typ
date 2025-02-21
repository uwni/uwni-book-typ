
///
/// this file is used to import and config packages
///

#import "../lib.typ": *
#let (
  isct_thesis,
  titlepage,
  standalone,
  mainbody,
  appendix
) = config_isct(
  // ["en"|"ja"]
  lang: "en",
  title: (
    ja: text(lang: "ja")[
       傅里葉分析筆記  
    ],
    en: [
      Fourier Analysis Note
    ],
  ),
  // author information
  author: (en: "Taro Tokodai", ja: "東工大 太郎"),
  // report date
  date: datetime.today(),
  department: "Department of Alchemy, School of Occultistic Engineering",
  degree: "Master of Engineering",
  major: "Occultistic Engineering",

  supervisor: "Professor Wukyu OwO",
  // set to true to enable draft watermark, so that you can prevent from submitting a draft version
  draft: false,
  // set to true to enable two-sided layout
  two_sided: false,
  // "modern"|"classic"
  title_style: "modern",
)

//delete this line if you do not need the lorem ipsum for japnese language, as it only for demostration
#import "@preview/roremu:0.1.0"
// #import "@preview/physica:0.9.4"