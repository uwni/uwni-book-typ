/// lib.typ
/// entrypoint for the library

// re-export the following modules
#import "src/components.typ"
#import "packages/theorion.typ" as environments

#let config_isct(
  config: "en",
  title: (ja: [], zh: [], en: []),
  author: "[Author]",
  department: "[Department]",
  date: datetime.today(),
  draft: false,
  two_sided: false,
  page_style: "side",
  title_style: "[title_style]",
) = {
  let config = if type(config) == str {
    import "src/config.typ": config as default_config
    default_config.at(config, default: [])
  } else if type(config) == dictionary {
    config
  }

  import "src/template.typ": *
  import "src/titlepage.typ": titlepage

  // export the following functions
  (
    isct_thesis: body => template(
      config,
      title,
      author,
      date,
      draft,
      two_sided,
      page_style,
      body,
    ),
    titlepage: titlepage(
      style: title_style,
      config,
      title,
      author,
      department,
      date,
      draft,
    ),
    appendix: appendix(config),
    standalone: standalone(config),
    mainbody: body => mainbody(body, config, two_sided, page_style),
    outline: _outline.with(config),
  )
}


// reexport
#import "packages/marginalia.typ": *