/// lib.typ
/// entrypoint for the library

// re-export the following modules
#import "src/components.typ": *
#import "src/template.typ": *
#import "src/titlepage.typ": titlepage
#import "src/envirionments.typ": *
#import "src/components.typ": *

#let config_isct(
  config: "en",
  title: (ja: [], zh: [], en: []),
  author: "[Author]",
  department: "[Department]",
  date: datetime.today(),
  draft: false,
  two_sided: false,
  title_style: "[title_style]",
  chap_imgs: (),
) = {
  // export the following functions
  (
    isct_thesis: body => template(
      title,
      author,
      date,
      draft,
      two_sided,
      chap_imgs,
      body,
    ),
    titlepage: titlepage(
      style: title_style,
      title,
      author,
      department,
      date,
      draft,
    ),
    appendix: appendix,
    mainbody: body => mainbody(body, two_sided, chap_imgs),
  )
}

// reexport
#import "packages/marginalia.typ": *
#import "src/envirionments.typ": *
#import "src/index.typ": index
#let outline = _outline
