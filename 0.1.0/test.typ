#let s = state("s", (:))

#context s.get()

#s.update(it => it + ("foo": it.at("foo", default: 0)))
#context s.get()

