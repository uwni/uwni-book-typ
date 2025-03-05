#import "../packages.typ": *
#import "../defs.typ": *

= Problem Definition and Methodology <chap>

#lorem(20)
== 換元術
夫換元之術者, 分析學之魂魄也. 以之解方程, 求積分, 皆有其用. 且其法之簡明, 使人易於理解. 換元本爲函數之複合，請例以如下. 求函數 $f(x) = 1-x^2$ 之最大值. 作換元 $g: x |-> cos t$ 得

$
   x stretch(->)^(g) cos t stretch(->)^(f) 1 - cos^2 t = sin^2 t
$

而其最值瞭然也.

== 幂集
集合 $S$ 之冪集 $2^S$ 定義爲 $S$ 全部子集之所集. 例如 $2^{1s, 2} = {{}, {1}, {2}, {1, 2}}$. $S$ 之冪集之勢 $abs(2^S) = 2^abs(S)$, 請以歸納法證明之:
$abs(2^emptyset) = abs({emptyset}) = 1$
,令
$abs(2^S) = 2^abs(S)$,
既添一新元 $x$ 於 $S$, 其冪集必含原 $2^S$ 諸元, 又以 $2^(S union {x})$ 之新添乃 $x$ 與舊 $2^S$ 諸元之合併故

$ abs(2^(S union {x})) = overbrace(abs(2^S), "原 "S" 之勢") + underbrace(abs(2^S times {x}), "新添之勢") = 2^abs(S) + 2^abs(S) = 2^(abs(S)+1) = 2^(abs(S union {x})) $

即得所證也.

== 數列單調收斂之定理
單調遞增數列之有上界者與單調遞減數列之有下界者，皆收斂. 請證明之.

== Peano算數

== 極限論
極限之概念，自古希臘先賢始用，直至 Cauchy 嚴明定義之, 至今已成爲分析學之基石. 然微分與無窮小之辯，議其存廢相爭歷千載而未絕. 或謂之爲 0, 或謂之近似 0 非 0. 時0而時亦非 0, 謬也. 若以嚴謹之分析論之，則首應定義極限之概念. 極限者近而不逮也, 定義數列 ${a_n}$ 之極限曰

$
    & lim_(n -> oo) a_n = L \
  <=> quad & (forall epsilon > 0) (exists N in NN^*) (forall n > N) abs(a_n - L) < epsilon
$

 $a_n$ 之值終將近於 $L$ 而或不之及. 不得知其及否也. 任取一小數 $epsilon$, 必有一處 $N$, 凡 $n$ 之後於 $N$ 者, $a_n$ 皆足近於 $L$. 其近幾何? 謂其差小於 $epsilon$ 耳. 

=== 極限之四則運算
極限之加減乘除是也. 假設 $lim_(n -> oo) a_n = L_a$, $lim_(n -> oo) b_n = L_b$, 則
$
  lim_(n -> oo) (a_n + b_n) = lim_(n -> oo) a_n + lim_(n -> oo) b_n
$
證明
$
  (forall epsilon > 0) (exists N in NN^*) (forall n > N) abs(a_n + b_n - (L_a + L_b)) = abs(a_n - L_a) + abs(b_n - L_b) < epsilon
$

== 級數論
累加數列之和曰級數. 設數列 ${a_n}$ 前 $n$ 項之和曰 $s_n = sum_(k=0)^n a_k$. 則稱 

$
sum_(n=0)^oo a_n :=  lim_(n -> oo) s_n
$ 
爲_無窮級數_, 畧作_級數_. 其中凡 $a_n > 0$ 者, 謂之_正項級數_.
若 $s_n$ 收斂即謂級數收斂. $s_n$ 發散即謂級數發散. 有諸據可以斷級數之斂散. 請道其詳.

=== 檢比術
差值

=== 檢根術

== 常數 $eu$
常數 $eu$, 或稱_自然底數_, 最初見於複利率之計算. 凡 $n > 0$ 定義曰
$ eu := lim_(n->oo) a_n = lim_(n -> oo) (1+1 / n)^n $
此處唯需證明 RHS 收斂。請道其證法
$
  a_n
  = sum_(k=0)^n binom(n, k)(1 / n)^k
  = sum_(k=0)^n n^(underline(k)) / (k! n^k) 
$

$n^(underline(k)) / (k! n^k)  >0$ 故知其嚴格遞增矣. 再展開之

$
  a_n &= sum_(k=0)^n  1/k! n/n (n-1)/n dots.c (n-k+1)/n \
  &= sum_(k=0)^n  1/k! (1 - 1/n) dots.c (1 - (k-1)/n) \
$<eq:an-expand>

茲定義曰 $e_n := sum_(k=0)^n 1\/k!$ , 逐項比較即知 $ a_n < e_n$

由 $(forall k >= 1) thick 1\/k! <= 1\/2^(k-1)$
$
  (1+1 / n)^n <= e_n
  &= 1 + 1 + 1 / 2 + 1 / (2 times 3) + dots.c + 1 / (2 times dots.c times (n-1) times n)\
  &<= 1 + 1 + 1 / 2 + 1 / (2 times 2) + dots.c + 1 / (2^(n-1))\
  &<= 3
$
或由 $ (forall k >= 2) quad 1/k! <= 1/k(k-1) = 1/(k-1) - 1/(k) $ 
俱得所求證. 亦由定義可知 $sup a_n = eu$ .

法前例亦可得證 $e_n$ 之收斂. 然 $lim_(n->oo) e_n eq.quest eu$ 之真僞猶未可知, 不得擅斷. 不妨先列圖以觀

#let e_n_plot(n) = {
  range(n+1).fold(
    0,
    (acc, k) => (
      acc + 1 / calc.fact(k)
    ),
  )
}
#let e_plot(n) = calc.pow(1 + 1 / n, n)

#cetz.canvas({
  import cetz.draw: *
  set-style(
    axes: (stroke: .5pt, tick: (stroke: .5pt)),
    legend: (
      stroke: none,
      orientation: ttb,
      item: (spacing: .3),
      scale: 80%,
    ),
  )

  plot.plot(
    size: (12, 8),
    y-min: 1,
    y-max: 3,
    {
      let domain = range(1, 21)
      plot.add(domain.map(it => (it, e_n_plot(it))), label: $e_n$, mark: "o", style: (stroke: none))
      plot.add(domain.map(it => (it, e_plot(it))), label: $a_n$, mark: "o", style: (stroke: none))
    },
  )
})

接着，來嚴謹證明二者收斂於同處. 庶幾以夾逼定理證之, 唯需各項 $a_n < e_n < eu$. 由上圖知其然也. 非證不信, 請證之如下. 令@eq:an-expand 內取 $n -> oo$, LHS 收斂於 $eu$ 而 $"RHS" tilde.eq e_n$ 也. 故 $e_n < eu$, 可以[假幣定理]得其證矣。

此二例因其典據而垂於數學史, 而收斂至 $eu$ 之級數非只此二者, 另察一例 $b_n = (1 + 1 \/ n)^(n+1)$ 可見
$ 
  lim_(n -> oo) b_n = lim_(n -> oo) (1 + 1 / n)a_n  = lim_(n -> oo) a_n= eu
$
有違於前, $b_n$ 單調遞減收斂至 $eu$ 也，請證明如下
$
  b_n / b_(n-1) =
  (1 + 1 / n)^(n+1) / (1 + 1 / (n-1))^n 
  // = (1 + n^(-1)) ( 
  //   (1 + n^(-1))/(1 + (n-1)^(-1))
  // )^n \
  // = (1 + n^(-1)) (((1 + n^(-1)) (n-1)) / (n - 1 + 1))^n \
  // = (1 + n^(-1)) ((n-n^(-1))/n)^n \
  = (1 + 1/n) (1 - 1/n^2)^n \

$
欲證明 $forall n > 1$, $b_n\/b_(n-1) < 1$, 即求證
$
  (1 - 1/n^2)^n < n / (n+1)
$
凡 $x in (0, 1]$, 因 $(1-x)(1+x) = 1-x^2 < 1$ 故 $(1-x)^n < (1+x)^(-n)$,
代入 $x |-> 1\/n^2$, 並以 $1+1\/n$ 乘兩邊，再以Bernoulli不等式得

$
  (1+1/n )(1 - 1/n^2)^n < (1+1/n ) (1 + 1/n^2)^(-n) < (1+1/n )(1 + n/n^2)^(-1) = 1
$

即證得 $b_n\/b_(n-1) < 1$ . 由此可知 $b_n$ 嚴格遞減. 故 $inf b_n = eu$

=== 指數函數

定義 $exp$ 函數曰
$
  exp x = sum_(n=0)^oo x^n / n!
$
分析其斂散, 由比值判別法
$
  abs(x^(n+1) / (n+1)!) / abs(x^n / n!) = abs(x/ (n+1)) -> 0 "as" n -> oo
$


== 差分方程論
請問，線性微分方程如 $y'' + y = 0$ 者當作何解？得特徵方程 $r^2 + 1 = 0$ 有根 $r = plus.minus i$ 故通解為 $y = c_1 cos x + c_2 sin x$. 代入即明此誠爲其解也. 然何以斷言此爲_全解_焉. 請論其理. 

定義數列 ${x_n}$ 之_前向差分算子_曰
$ Delta x_n = x_(n+1) - x_(n) $
而_逆向差分算子_曰
$ nabla x_n = x_n - x_(n-1) $
$n >= 0$ 階差分遞歸定義曰

$ Delta^n = cases(
  I &"if" n = 0,
  Delta compose Delta^(n-1) quad &  "if" n > 0, 
) $

因 $ Delta (a x_n + b y_n) =  a Delta x_n + b Delta y_n$, 可知 $Delta$ 爲線性算子. 又以 $I$ 之線性. 知 $Delta^n$ 亦線性也.

稱形如 
$ sum_(k=0)^n a_k Delta^k x_k = b $
 之方程式曰 $n$ _階常係數差分方程_. 特稱 $b = 0$ 者爲_齊次_, 否則爲_非齊次_. 若有一列數 $hat(x)_n$ 可令 $x_n = hat(x)_n$ 滿足方程，則稱 $hat(x)_n$ 爲方程之_解_. 
 
 請探其性質. 凡非齊次方程之解 ${hat(x)_n}$, ${hat(y)_n}$, 其和 ${hat(x)_n + hat(y)_n}$ 亦解矣
$
  sum_(k=0)^n a_k Delta^k (alpha hat(x)_k + beta hat(y)_k) = alpha sum_(k=0)^n a_k Delta^k hat(x)_k + beta sum_(k=0)^n a_k Delta^k hat(y)_k = 0
$

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
        table.cell(colspan: 4, smallcaps[*Output*]),
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

#let mean(arg) = $ lr(angle.l #arg angle.r) $
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
