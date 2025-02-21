/// entrypoint for the library

// re-export the following modules
#import "src/utils.typ": *

#let config_isct(
  lang: "en",
  title: (ja: [], en: []),
  author: "[Author]",
  date: datetime.today(),
  degree: "[degree]",
  major: "[major]",
  supervisor: "[supervisor]",
  department: "[department]",
  draft: false,
  two_sided: false,
  title_style: "[title_style]",
) = {
  import "src/template.typ": *
  import "src/titlepage.typ": titlepage
  import "src/i18n.typ": *

  // export the following functions
  (
    isct_thesis: body => template(
      lang,
      title,
      author,
      date,
      draft,
      two_sided,
      body,
    ),
    titlepage: titlepage(
      style: title_style,
      lang,
      title,
      author,
      date,
      degree,
      major,
      supervisor,
      department,
      draft,
    ),
    abstract: abstract.with(lang),
    appendix: appendix(lang),
    acknowledgement: standalone(i18n.at(lang).ack),
    list_of_pub: standalone(i18n.at(lang).lop),
    sans: text.with(font: i18n.at(lang).sans_font),
    mainbody: mainbody,
  )
}
