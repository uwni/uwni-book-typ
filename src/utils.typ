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
  grid(columns: 2)[_Note._~][#body]
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

// none -> it is not already yet, e.g. titlepage
#let current_chapter() = {
  let chapter = query(heading.where(level: 1).before(here()))
  // no chapter founded
  if chapter == () {
    return none
  }
  let chapter = chapter.last()
  let number = counter(heading).display((chap_idx, ..) => if chap_idx > 0 { chap_idx })

  let body = chapter.body
  // styling it with numbering

  (number: number, body: body)
}

#let current_page() = counter(page).display(page.numbering)

#let color_palette = (
  c: (
    red: rgb("e97979"),
    orange: rgb("f8b488"),
    yellow: rgb("edc669"),
    green: rgb("81bd5f"),
    deep_green: rgb("5aa36c"),
    gray: rgb("979797"),
  ),
  a: (
    red: rgb("f02b2b"),
    orange: rgb("ff8732"),
    yellow: rgb("f7bb25"),
    green: rgb("69b72a"),
    deep_green: rgb("2c9a4a"),
    gray: rgb("707070"),
  ),
  bg: (
    deep: rgb("e8eaf1"),
    light: rgb("f2f4f9"),
  ),
  primary: rgb("1c3177"),
  secondary: rgb("#7f96c2"),
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
