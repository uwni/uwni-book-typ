#let watermark(
  body,
  padding: 4em,
) = context {
  set par(spacing: 0em)
  let diameter = page.width + page.height

  let body = block(inset: padding, body)
  let (width, height) = measure(body)
  // make sure the watermark covers the whole page
  // by triangle inequality
  let angle = calc.atan(height / width)
  let y-num = calc.ceil(diameter / height)

  rotate(
    angle,
    block(
      width: diameter,
      height: diameter,
      repeat(
        justify: false,
        for y in range(y-num) {
          body
        },
      ),
    ),
  )
}

#let fignote(body) = {
  set align(left)
  set par(leading: 0.65em)
  grid(columns: 2)[_註._][#body]
}

// check if the calling page is the first page of a new chapter
// need a contextal env
#let is_starting() = {
  for h in query(heading.where(level: 1)) {
    if h.location().page() == here().page() {
      return true
    }
  }
  false
}

#let is_even_page() = calc.even(counter(page).get().at(0))


// none -> it is not already yet, e.g. titlepage
#let current_chapter() = {
  let chapter = query(heading.where(level: 1).before(here()))
  // no chapter founded
  chapter = if chapter == () {
    return none
  } else {
    chapter.last()
  }

  let section = query(heading.where(level: 2).before(here()))
  // no section founded
  section = if section == () {
    none
  } else {
    section.last()
  }

  let index = counter(heading).get()

  let body = (chapter.body, section.body)
  // styling it with numbering

  (index: index, body: body)
}

#let current_page() = counter(page).display(page.numbering)

#let color_palette = (
  primary: blue,
  secondary: rgb("c6e6e8"),
  tertiary: rgb("dfecd5"),
)

/* Table tools */
#let heavyrule = table.hline.with(stroke: 0.08em)
#let midrule = table.hline.with(stroke: 0.05em)
#let vline = table.vline(stroke: 0.05em)

#let multi-row(eq) = {
  eq
    .body
    .children
    .split(linebreak())
    .map([].func())
    .zip((
      [],
      {
        if (eq.has("label")) {
          let c = counter(math.equation)
          c.step()
          h(1em)
          context c.display()
        }
      },
    ))
    .map(array.join)
    .map(math.equation.with(block: true, numbering: none))
    .map(box)
    .join(((h(1fr),) * 2).join(linebreak()))
}

#let title_num_art(content) = {
  set text(size: 5em)
  let c = str(content)
  place(text(c, stroke: blue + .35em))
  text(c, fill: white)
}

#title_num_art("篇")
