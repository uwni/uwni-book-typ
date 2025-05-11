#import "../packages.typ": *
#import "../defs.typ": *

= 數域 <chap>

== 換元術
夫換元之術者，分析學之魂魄也。以之解方程，求積分，皆有其用。且其法之簡明，使人易於理解。換元本爲函數之複合，請例以如下。求函數 $f(x) = 1-x^2$ 之最大值。作換元 $g: x |-> cos t$ 得

$
  x stretch(->)^(g) cos t stretch(->)^(f) 1 - cos^2 t = sin^2 t
$

而其最值瞭然也。
簡記一階邏輯
$
  (forall a in A)p(a) <=> forall a(a in A -> p(a))
$



== 數列
數列者，

== 數列單調收斂之定理
凡單調遞增數列之有上界者與單調遞減數列之有下界者，皆收斂。請證明之。
== 自然數論
=== Peano 公理

== 整數論

#let mr = $stretch(-, size: #1em)$
#let dr = $slash slash$

相等關係
$
  a mr b = c mr d <=> a + d = b + c
$

凡自然數 $n$，察對射於 $NN -> {n mr 0 | n in NN}$ 上者 $n |-> n mr 0$。知整數之形如 $n mr 0$ 者同構於 $NN$ 也。故可以整數 $n$ 記自然數 $n mr 0$ 而無虞也。
逆元
$
  -a := 0 mr a
$

== 分數論

相等關係
$
  a dr b = c dr d <=> a d = b c
$
必有
$
  (exists x dr y in [a dr b]) gcd(x, y) = 1
$
*約式*，或曰*最簡分式*，分式之子母互素者也。例如 $1\/1$，$2\/3$，$5\/8$。以其子母皆最小，立爲 $QQ\/=$ 之代表元也。稠性: $a$

== 實數論
請問，正方形之對角線長 $l$ 幾何? 以勾股定理知 $l^2 = 2$，擬其長以一分數之約式 $l = p\/q$

#multi-row($
  l^2 = 2 <=> p^2 = 2 q^2
  <=> 2 divides p^2 <=> 2 divides p\
  <=> exists p'(p = 2 p') <=>
  2p'^2 = q^2 <=> 2 divides q^2 <=> 2 divides q
$)

$p$ 與 $q$ 皆偶數，而 $p \/ q$ 非約式也。故知 $l$ 非分數之屬也。以Ἵππασος之初覺爲嚆矢，分數之遺缺始昭於天下矣。此所以分數不可以度量也。

另察一例，有集分數其平方皆小於 $2$ 者
#let QQ2 = $QQ_(<sqrt(2))$
$
  QQ2 := {x in QQ | x^2 < 2}
$
即知有上界也。而無上確界。擬以歸謬法證之：
設其上確界爲 $macron(x)$，則 $forall x in QQ2, macron(x) >= x$，
$
  forall epsilon > 0, exists y in QQ2, macron(x) - epsilon < y
$

由全序關係之三歧性知
+ 若 $macron(x)^2 = 2$: 證偽
+ 若 $macron(x)^2 > 2$，需證明 $exists y in QQ2, y < macron(x)$，設 $y = macron(x) - epsilon$，並使 $y^2 > 2$。即 $y$ 爲上界而甚小耳。 $ (macron(x) - epsilon)^2 >= 2 <=> macron(x)^2 - 2 macron(x) epsilon + epsilon^2 > 2 arrow.l.double macron(x)^2 - 2 macron(x) epsilon >= 2 <=> epsilon <= (macron(x)^2 - 2) / (2 macron(x)) $
  不妨取 $epsilon = (macron(x)^2 - 2) / (2 macron(x))$，即證所求
+ 若 $macron(x)^2 < 2$，需證明 $exists y in QQ2, y > macron(x)$，設 $y = macron(x) + epsilon$。即 $macron(x)$ 乃非上界耳。 $ y^2 = (macron(x) + epsilon)^2 <= 2 <=> macron(x)^2 + 2 macron(x) epsilon + epsilon^2 < 2 arrow.l.double macron(x)^2 + 2 macron(x) epsilon <= 2 <=> epsilon <= (2 - macron(x)^2) / (2 macron(x)) $
  不妨取 $epsilon = (2 - macron(x)^2) / (2 macron(x))$，即證所求

故知 $QQ2$ #index[上確界]之不存也。

二例。#let QQ4 = $QQ_(<2)$
$
  QQ4 := {x in QQ | x^2 < 4}
$
可知 $x >= 2$ 皆上界也，而$sup QQ4 = 2$也

凡 $Q$ 爲 $QQ$ 上非空有上界子集，則定義為實數。
全序集 $(X, prec.eq)$。若其非空子集之有上界者有上確界。曰*序完備*

以下三命題等價也
+ $(X, prec.eq)$ 序完備也
+ $X$ 非空子集之有下界者有下確界也
+ 凡 $∀A, B ⊆ X$ 不空，$∀a ∈ A, ∀b ∈ B, a ≤ b -> (∃c ∈ X)(∀a ∈ A, ∀b ∈ B) a <= c <= b$ 也。請證:
$1 => 2$

= 極限
若夫極限者，古希臘之先賢始用，至 Cauchy 嚴明定義之，已歷數千年矣。然微分與無窮小之辯，曾相爭其存廢逾千載而未絕也。其或爲 0，或幾及 0 而非 0。時 0 而時亦非 0，George Berkeley 等甚異之。而物理學家總以無窮小算得正確之結果，故不以爲謬也。數學之理也，必明必晰。然則應先申明極限為何物，而後可以道嚴謹之分析而無虞也。定義數列 ${a_n}$ 之極限曰

$
  & lim_(n -> oo) a_n = L \
  <=> quad & (forall epsilon > 0) (exists N in NN^*) (forall n > N) abs(a_n - L) < epsilon
$

極限者近而不逮，傍而未屆也。$a_n$ 之值將屆於 $L$ ，抑不之至。不得知也。若以 $epsilon-N$ 定義論之。恣取正數 $epsilon$，不論大小，必存一處 $N$，凡 $n$ 之後於 $N$ 者，$a_n$ 與 $L$ 相距幾微。何以知其然也? 蓋其相距小於 $epsilon$ 者也。凡正數者，皆見小於 $a_n$ 與 $L$ 之相距，此所以度量其近也。豈非因 $n$ 之漸長而 $a_n$ 幾及於 $L$ 耶？！

=== 單調有界性之定理

數列之收斂者，其極限必存焉。以單調有界性之定理得知其收斂而不得知其極限也。欲察極限幾何，猶須探其值而後驗以定義也。幸有各術如下以索極限，一曰夾逼定理，二曰四則運算，三曰 Stolz-Cesàro 定理也。

=== 夾逼定理

=== 極限之代數運算
極限之加減乘除是也。設以 $lim_(n -> oo) a_n = L$，$lim_(n -> oo) b_n = M$，由定義知 $forall epsilon > 0$

#multi-row($
  &(exists N_a in NN^*) (forall n > N_a) abs(a_n - L) < epsilon \ and quad &(exists N_b in NN^*) (forall n > N_b) abs(b_n - M) < epsilon
$)

故而 $abs(-a_n - (-L)) = abs(a_n - L) < epsilon$，是以
$
  lim_(n -> oo) (-a_n) = -L
$<eq:lim-rev>
也。設 $N := max{N_a, N_b}$，以三角不等式
$
  abs(a_n + b_n - (L + M)) <= abs(a_n - L) + abs(b_n - M) < 2 epsilon
$
故而
$
  lim_(n -> oo) (a_n + b_n) = L + M
$<eq:lim-add>
並由@eq:lim-rev 可知 $lim_(n -> oo) (a_n - b_n) = L - M$ 也。

此所以極限之代數運算效也。
$
  abs(a_n b_n - L M)
$

== 級數論
級數者，數列之累和也。若名累數列 ${a_n}$ 前 $n$ 項之和曰 $s_n = sum_(k=0)^n a_k$。則記

$
  sum_(n=0)^oo a_n := lim_(n -> oo) s_n
$
爲*無窮級數*，畧作*級數*。其中凡 $a_n > 0$ 者，謂之*正項級數*。若 $s_n$ 收斂即曰級數收斂。$s_n$ 發散即謂之級數發散。有諸據可以斷級數之斂散。請道其詳。
=== 檢比術
差值

=== 檢根術

== 常數 $eu$
常數 $eu$，或曰*自然底數*，初見於複利率之計算。凡 $n > 0$ 有定義曰
$ eu := lim_(n->oo) a_n = lim_(n -> oo) (1+1 / n)^n $
此處唯需證明 RHS 收斂。請道其證法
$
  a_n
  = sum_(k=0)^n binom(n, k)(1 / n)^k
  = sum_(k=0)^n n^(underline(k)) / (k! n^k)
$

$n^(underline(k)) / (k! n^k) >0$ ，則知 $a_n$ 之嚴格遞增矣。再展開之

$
  a_n &= sum_(k=0)^n 1 / k! n / n (n-1) / n dots.c (n-k+1) / n \
  &= sum_(k=0)^n 1 / k! (1 - 1 / n) dots.c (1 - (k-1) / n) \
$<eq:an-expand>

茲定義曰 $e_n := sum_(k=0)^n 1\/k!$ ，逐項比較即知 $a_n < e_n$

由 $(forall k >= 1) thick 1\/k! <= 1\/2^(k-1)$
$
  (1+1 / n)^n <= e_n
  &= 1 + 1 + 1 / 2 + 1 / (2 times 3) + dots.c + 1 / (2 times dots.c times (n-1) times n)\
  &<= 1 + 1 + 1 / 2 + 1 / (2 times 2) + dots.c + 1 / (2^(n-1))\
  &<= 3
$
抑由 $ (forall k >= 2) quad 1 / k! <= 1 / k(k-1) = 1 / (k-1) - 1 / (k) $
亦得所求證。由定義可知 $sup a_n = eu$ 也。
法前例亦可得證 $e_n$ 之收斂。然 $lim_(n->oo) e_n eq.quest eu$ 之真僞猶未可辨，不得臆斷。然則不妨先列圖以觀

#let e_n_plot(n) = {
  range(n + 1).fold(
    0,
    (acc, k) => (
      acc + 1 / calc.fact(k)
    ),
  )
}
#let e_plot(n) = calc.pow(1 + 1 / n, n)

// #let plt = cetz.canvas({
//   import cetz.draw: *
//   set-style(
//     axes: (stroke: .5pt, tick: (stroke: .5pt)),
//     legend: (
//       stroke: none,
//       orientation: ttb,
//       item: (spacing: .3),
//       scale: 100%,
//     ),
//   )

//   plot.plot(
//     size: (7, 6),
//     y-min: 1.3,
//     y-max: 3,
//     {
//       let domain = range(1, 21)
//       plot.add(domain.map(it => (it, e_n_plot(it))), label: $e_n$, mark: "o", style: (stroke: none))
//       plot.add(domain.map(it => (it, e_plot(it))), label: $a_n$, mark: "o", style: (stroke: none))
//     },
//   )
// })
#figure(
  caption: [$a_n$ 與 $e_n$ 之收斂圖],
  box(width: 50%, height: 50pt, fill: gradient.linear(..color.map.crest)),
)

再證二者收斂於同處。庶幾以夾逼定理證之，唯需各項 $a_n < e_n < eu$。以上圖料其然也。然理學也非證不信非驗不服。請證之如下。令@eq:an-expand 之 $n -> oo$，左邊收斂於 $eu$ 而 $"右邊" tilde.eq e_n$ 也。故 $e_n < eu$，然則可以[假幣定理]得其證矣。

此二例以其典據垂於史，而級數之收斂至 $eu$ 者止此二例歟? 另察一例 $b_n = (1 + 1 \/ n)^(n+1)$ 可見
$
  lim_(n -> oo) b_n = lim_(n -> oo) (1 + 1 / n)a_n = lim_(n -> oo) a_n= eu
$
有違於前，$b_n$ 單調遞減並收斂至 $eu$ 也。請證明如下
$
  b_n / b_(n-1) =
  (1 + 1 / n)^(n+1) / (1 + 1 / (n-1))^n
  // = (1 + n^(-1)) (
  //   (1 + n^(-1))/(1 + (n-1)^(-1))
  // )^n \
  // = (1 + n^(-1)) (((1 + n^(-1)) (n-1)) / (n - 1 + 1))^n \
  // = (1 + n^(-1)) ((n-n^(-1))/n)^n \
  = (1 + 1 / n) (1 - 1 / n^2)^n \
$
欲證明 $forall n > 1$，$b_n\/b_(n-1) < 1$，即求證
$
  (1 - 1 / n^2)^n < n / (n+1)
$
凡 $x in (0, 1]$，因 $(1-x)(1+x) = 1-x^2 < 1$ 故 $(1-x)^n < (1+x)^(-n)$，
换元以 $x |-> 1\/n^2$，並乘兩邊以 $1+1\/n$，再以Bernoulli不等式得

$
  (1+1 / n )(1 - 1 / n^2)^n < (1+1 / n ) (1 + 1 / n^2)^(-n) < (1+1 / n )(1 + n / n^2)^(-1) = 1
$

$b_n\/b_(n-1) < 1$ 也。而 $b_n$ 之嚴格遞減可知矣。故 $inf b_n = eu$

=== 指數函數

定義 $exp$ 函數曰
$
  exp x = sum_(n=0)^oo x^n / n!
$
審其斂散，法以比值
$
  abs(x^(n+1) / (n+1)!) / abs(x^n / n!) = abs(x / (n+1)) -> 0 "as" n -> oo
$

=== 調和級數

何其緩也!
=== 收斂最慢的級數

== 差分方程論
請問線性微分方程如 $y'' + y = 0$ 者當作何解？得特徵方程 $r^2 + 1 = 0$ 有根 $r = plus.minus i$ 故知通解爲 $y = c_1 cos x + c_2 sin x$。代入即明此誠爲其解也。此*全解*耶? 請論其理。
定義數列 ${x_n}$ 之*前向差分算子*曰
$ Delta x_n = x_(n+1) - x_(n) $
而*逆向差分算子*曰
$ nabla x_n = x_n - x_(n-1) $
$n >= 0$ 階差分遞歸定義曰

$
  Delta^n = cases(
    I &"if" n = 0,
    Delta compose Delta^(n-1) quad & "if" n > 0,
  )
$

因 $Delta (a x_n + b y_n) = a Delta x_n + b Delta y_n$，可知 $Delta$ 爲線性#index(modifier: "線性")[算子]。又以 $I$ 之線性。知 $Delta^n$ 亦線性也。
稱形如
$ sum_(k=0)^n a_k Delta^k x_k = b $
之方程式曰 $n$ *階常係數差分方程*。特稱 $b = 0$ 者爲*齊次*，否則爲*非齊次*。若有一列數 $hat(x)_n$ 可令 $x_n = hat(x)_n$ 滿足方程，則稱 $hat(x)_n$ 爲方程之*解*。
請探其性質。凡非齊次方程之解 ${hat(x)_n}$，${hat(y)_n}$，其和 ${hat(x)_n + hat(y)_n}$ 亦解矣
$
  sum_(k=0)^n a_k Delta^k (alpha hat(x)_k + beta hat(y)_k) = alpha sum_(k=0)^n a_k Delta^k hat(x)_k + beta sum_(k=0)^n a_k Delta^k hat(y)_k = 0
$

== Code block

it's very easy to include code by Typst, and your codes will get highlighted automatically。Example:


```zig
const std = @import("std");
std.debug.print("Hello, {}!\n", .{"world"});
```

== Tables
#(
  figure(
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
    },
  )
)


You use the `#figure` directive to include figures in your document. Here is an example:

#let mean(arg) = $ lr(angle.l #arg angle.r) $
$ mean(x / y) $

```typ
#figure(
  caption: [A Mystery Bird which is the logo of a lost university],
  image("../../src/assets/titech.svg", width: 55%),
)
```

which will be rendered as:

#figure(
  caption: [A Mystery Bird which is the logo of a lost university, A Mystery Bird which is the logo of a lost university, A Mystery Bird which is the logo of a lost university, A Mystery Bird which is the logo of a lost university],
  image("../../src/assets/titech.svg", width: 70%),
)<tubame>

get-

#index(modifier: "測試")[算子]

= 實分析

= 複分析

= 諧分析
#index(modifier: "測試")[算子]
#index(modifier: "text")[content]
