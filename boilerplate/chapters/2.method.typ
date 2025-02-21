#import "../packages.typ": *
#import "../defs.typ": * 

= Problem Definition and Methodology <chap>

#lorem(20)
== Math
Here is a simple inline equation: $a^2 + b^2 = c^2$.

$ t t f t t  $


And we can also have a display styled formula

$ 
  1/(2pi) integral_(-oo)^oo f(t) eu^(im 2 pi f t) dif x

$<eq>
== Code block

it's very easy to include code by Typst, and your codes will get highlighted automatically. Example:


```zig
const std = @import("std");
std.debug.print("Hello, {}!\n", .{"world"});
```

== Tables
#figure(
  caption: [Truth Table for 2-to-4 Decoder],
  {
    table(
      columns: (1fr, 1fr, 1fr, 1fr, 1fr, 1fr),
      column-gutter: 0.5em,
      // stroke: (_, y) => if y == 1 { (bottom: 0.5pt) },
      heavyrule(),
      table.header(
        table.cell(colspan: 2, smallcaps[*Input*]),
        table.cell(colspan: 4, smallcaps[*Output*])
      ),
      midrule(end: 2), midrule(start: 2, end: 6),
      $A$, $B$, $Y_0$, $Y_1$, $Y_2$, $Y_3$,
      midrule(),
      $0$, $0$, $1$, $0$, $0$, $0$,
      $0$, $1$, $0$, $1$, $0$, $0$,
      $1$, $0$, $0$, $0$, $1$, $0$,
      $1$, $1$, $0$, $0$, $0$, $1$,
      heavyrule(),
    )
    fignote[$1$ = Active, $0$ = Inactive]
  },
)


== Figures

You use the `#figure` directive to include figures in your document. Here is an example:

```typ
#figure(
  caption: [A Mystery Bird],
  image("../../src/assets/titech.svg", width: 65%),
)
```

which will be rendered as:

#figure(
  caption: [A Mystery Bird] + lorem(20),
  image("../../src/assets/titech.svg", width: 25%),
)<tubame>


== References<sec>
A reference to a element can be made by using the `@` symbol. For example, you can refer to the equation above by writing `@eq` which will be rendered as

@eq

And you can refer to the figure above by writing `@tubame` which will be rendered as

@tubame

and you can refer to a chapter by writing `@chap` which will be rendered as

@chap
@sec
