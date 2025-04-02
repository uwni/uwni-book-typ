#import "../packages.typ": *
#import "../defs.typ": *
#import components: *
#import environments: *

= 辯理
$R$ 二元謂語也，$phi$ 公式也，$x$ 變元也，$a$ 變元若常符也，對於一類常見的公式 $forall x (x R a -> phi)$，可以簡寫爲 $(forall x R a) phi$。

$ tack.r.double  $

= 集論

hahaha

== ZFC 公理
== 交集
$
  A union B = {x | x in A or x in B}
$

== 商集

== 勢
集 $S$ 其元之數，名曰*勢*，記曰 $abs(S)$。例如 $abs({1, 2, 3}) = 3$。若 $(exists n in NN^*)abs(S) = n$，則稱 $S$ 爲*有限集*，否則爲*無限集*，如分數集，實數集等。無限集中，$abs(NN) = alef_0$ 若勢與自然數集之勢等，則名之*可數集*，否則曰*不可數集*。例如分數集爲可數集，實數集爲不可數集。有限集之勢皆自然數，且 $abs(emptyset) = 0$。何言其勢等？
$
  S tilde.equiv T <=> (exists f: S -> T) f "對射也"
$
此計數之抽象也，若有 $S = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked, suit.spade.stroked}$ 集，數以一二三四而知其勢乃 $4$ 也。編號計數法實乃一雙射: $S -> NN^*_(<=4)$ 也。無限集也，雖數不盡其元，猶可較也。若有集可令其元一一對應於自然數者，正如數盡自然數之勢也。

== 幂集
集 $S$ 全子之所聚也，名曰冪集，記曰 $2^S := {x | x subset S }$。例如 $2^{1, 2} = {{}, {1}, {2}, {1, 2}}$。$S$ 冪集之勢 $abs(2^S) = 2^abs(S)$ 也，請以歸納法證明之:
$abs(2^emptyset) = abs({emptyset}) = 1$
,令
$abs(2^S) = 2^abs(S)$,
既添一新元 $x$ 於 $S$，其冪集必含原 $2^S$ 諸元，又以 $2^(S union {x})$ 之新添乃 $x$ 與舊 $2^S$ 諸元之合併故

$
  abs(2^(S union {x})) = overbrace(abs(2^S), "原" S "之勢") + underbrace(abs(2^S times {x}), "新添之勢") = 2^abs(S) + 2^abs(S) = 2^(abs(S)+1) = 2^(abs(S union {x}))
$

即得所證也。


== 界
=== 最大與最小
論以偏序集之構 $(T, prec.eq)$，若 $forall t exists m (m prec.eq t)$，則稱 $T$ 有*最小元* $m$，記曰 $min T = m$。若 $forall t exists M(t prec.eq M)$，則謂之有*最大元* $M$，記曰 $max T = M$。
設 $cal(S) := { S | S subset.eq T }$ 爲 $T$ 的子集族
$ max (union.big_(S in cal(S)) S) = max {max S | S in cal(S)} $
#multi-row($
  (forall t_1 in T_1)(forall t_2 in T_2)\ t_1 <= max T_1 <= max{max T_1, max T_2} and t_2 <= max T_2 <= max{max T_1, max T_2}
$)

- 有限偏序集不常有最大最小元。例如 $T = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked}$，偏序關係 $prec.eq = id$。所以無最大及最小元者，不可相較而已。
- 有限全序集常有最大最小元。請擬以歸納證明之
  + $abs(S) = 1$，$S$ 之元唯一，即最大最小元也。
  + $abs(S) = 2$，設 $S = {t_1, t_2}$，其最元得計算如下
    $
      max S = cases(t_1 quad "if" t_2 prec.eq t_1, t_2 quad "if" t_1 prec.eq t_2), wide
      min S = cases(t_1 quad "if" t_1 prec.eq t_2, t_2 quad "if" t_2 prec.eq t_1)
    $
  + 設 $abs(S) = N$，$S$ 有最大元 $M$ 與最小元 $m$。
  + 察 $abs(S) = N+1$，令 $S' = S without {s}$。
    由前款知 $S'$ 有最大元 $M'$ 與最小元 $m'$。然則 $max S = max{M', s}$, $min S = min{m', s}$ 也。即 $S$ 有最大最小元也。

集之界，不逾之境也。凡集 $S subset.eq T$ 之元 $s$，其或 $s <= M$ 者，則名 $M$ 爲 $S$ 一*上界*。反之，若 $M <= s$ 則喚作*下界*。若上下界並存，則謂之*有界*。界不必屬於集也。上界之最小者，號曰*上確界*，或曰最小上界，記曰 $sup S$。下界之最大者，號曰*下確界*，或曰最大下界，記曰 $inf S$。

$
  sup S = min{ t in T | s in S, s <= t}
$
$
  inf S = max{ t in T | s in S, t <= s}
$

例以上界與上確界，察其性質，凡有二項，一曰 $sup S$ 乃 $S$ 之上界也，二曰凡其上界莫小於 $sup S$ 也，即最小之上界也。
請問偏序集恆有上界乎？
1。有限集顯然恆有界，且 $sup S= max S$ 而 $inf S = min S$ 也。依序可列 $S$ 之元,


= 代數

== 關係
稱集 $R subset.eq A times B$ 爲集 $A$，$B$ 上之*二元關係*，畧以關係。若 $A = B$ 即 $R subset.eq A^2$ 則畧以 $A$ 上之關係。若以中綴表達式記 $a in A$ 與 $b in B$ 之適關係 $R$ 者，曰 $a R b$:
$
  a R b <=> (forall r in R)(exists a in A)(exists b in B)r = (a, b)
$
亦可記作前綴表達式並輔以括弧讀號，如 $R(a,b)$。這裡舉例同窗關係，朋友關係

=== 恆等關係
記 $S$ 上之*恆等關係*曰 $id_S$
$
  id_S := {(s, s) | s in S}
$
例如 $S = {suit.club.stroked, suit.diamond.stroked, suit.heart.stroked}$，$id_S = {(suit.club.stroked, suit.club.stroked), (suit.diamond.stroked, suit.diamond.stroked), (suit.heart.stroked, suit.heart.stroked)}$

=== 偏序關係
設以并關係集 $(S, prec.eq)$，並有
/ 自反性: $(forall s in S) s prec.eq s$
/ 反對稱性: $(forall s, t in S) s prec.eq t and t prec.eq s -> s = t$
/ 傳遞性: $(forall s, t, u in S) s prec.eq t and t prec.eq u -> s prec.eq u$
則名 $prec.eq$ 曰*偏序關係*。偏序關係之最小者，唯有恆等關係也。不難證明之。
+ $id$ 適自反性，反對稱性，傳遞性，故爲偏序關係也。
+ 凡 $(forall s in S) id without {(s, s)}$ 之關係皆以有違自反性而非偏序關係也。故最小也
+ 凡偏序關係必含 $id$ 也。可以歸謬法示其唯一性也。

=== 全序關係
若改 $prec.eq$ 之自反性爲完全性，即
$
  "完全性":& quad (forall s, t in S) s prec.eq t or t prec.eq s\
  "反對稱性":& quad (forall s, t in S) s prec.eq t and t prec.eq s -> s = t\
  "傳遞性":& quad (forall s, t, u in S) s prec.eq t and t prec.eq u -> s prec.eq u
$

則謂之*全序關係*，或曰*鏈*。凡全序之關係，恆偏序也。請證明之。全序關係滿足反對稱性與傳遞性，並以完全性蘊含自反性即知其亦偏序也。
