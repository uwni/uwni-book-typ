#import "../packages.typ": *
#import "../defs.typ": * 

= Problem Definition and Methodology <chap>

#lorem(20)
== 數學常數 $eu$
數學常數 $eu$ 最初見於複利率之計算. $n > 0$
$ eu := lim_(n -> oo) (1+1/n)^n $
此處唯需證明 RHS 收斂。請道其證法
$
(1+1/n)^n 
= sum_(k=0)^n binom(n, k)(1/n)^k 
= sum_(k=0)^n n! / (k! (n-k)! n^k ) 
$

$n! / (k! (n-k)! n^k ) >=0$ 故而嚴格遞增.

$
n! / (k! (n-k)! n^k ) = n^(underline(k)) / (k! n^k) <= n^k / (k! n^k) = 1/k!
$
這裏定義 $e_n := sum_(k=0)^n 1/k!$ .
$
(1+1/n)^n <= e_n
&= 1 + 1 + 1/2 + 1/(2 times 3) + dots.c + 1/(2 times 3 times dots.c times n)\
&<= 1 + 1 + 1/2 + 1/(2 times 2) + dots.c + 1/(2^(n-1))\
&= 1 + 2(1-2^(-n))\
&<= 3
$

即所求證. 法前例亦可得證 $e_n$ 之收斂. 然尚不可擅斷 $lim_(n->oo) e_n =^? eu$ . 不妨先驗其概貌.

#let e_n_plot(n) = {
  range(calc.ceil(n)).fold(0, (acc, k) => acc + 1 / calc.fact(k))
}



#cetz.canvas({
  import cetz.draw: *
  // Your plot/chart code goes here
    set-style(axes: (stroke: .5pt, tick: (stroke: .5pt)),
            legend: (stroke: none, orientation: ttb, item: (spacing: .3), scale: 80%))

  plot.plot(size: (12, 8), y-min: 0, y-max: 3, stroke: none,
    {
      let domain = (0, 20)
      plot.add(e_n_plot, domain: domain, label: $sin x$, mark: "o", )
    })
})

考察

$
(1 + 1/n)^(n+1)
$



Super long equaiton

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

#let mean(arg) = $ lr(angle.l #arg angle.r)  $
$ mean(x/y) $

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


And you can refer to the figure above by writing `@tubame` which will be rendered as

@tubame

and you can refer to a chapter by writing `@chap` which will be rendered as

@chap
@sec
