
///
/// this file is used to import and config packages
///

#import "@local/uwni-book-typ:0.1.0": *
#import "header_imgs/imgs.typ": imgs

#let (
  isct_thesis,
  titlepage,
  mainbody,
  appendix,
) = config_isct(
  // ["en"|"ja"]
  config: "en",
  title: (
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
  chap_imgs: imgs,
)

#import "@preview/equate:0.3.0"