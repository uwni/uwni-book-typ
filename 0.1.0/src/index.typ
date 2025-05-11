#let _amlos_dict = state("amlos-dict", ())

#let index(group: "default", symbol, detail: none) = context {
  if type(group) != str {
    panic("group must be a string")
  }
  // the index of amlos-dict give a unique id to the symbol
  let record = (group: group, symbol: symbol, detail: detail, loc: here())
  _amlos_dict.update(old => old + (record,))

  symbol
}

#let to_string(it) = {
  if it == none {
    none
  } else if type(it) == str {
    it
  } else if type(it) != content {
    str(it)
  } else if it.has("text") {
    it.text
  } else if it.has("children") {
    it.children.map(to_string).join()
  } else if it.has("body") {
    to_string(it.body)
  } else if it == [ ] {
    " "
  }
}

// first letter
#let first_letter(it) = {
  if type(it) == str {
    it.at(0)
  } else if it.has("text") {
    it.text.at(0)
  } else {
    panic("it must be a string or an array of string")
  }
}

#let use_symbol_list(group, id_func: first_letter, fn) = context {
  let group = if type(group) == str {
    (group,)
  } else if type(group) == array {
    group
  } else {
    panic("group must be a string or an array of string")
  }
  // no symbol definition found

  let res = (:)
  let curr_symbol = none
  let curr_children = ()
  let curr_int_min_page = none
  let curr_int_max_page = none
  let curr_min_page = none
  let curr_max_page = none
  let curr_id = none

  for (group: _group, symbol, detail, loc) in _amlos_dict
    .get()
    .sorted(key: it => (to_string(it.symbol), to_string(it.detail))) {
    // filter the symbol by group
    if not group.contains(_group) { continue }
    let int_page_num = counter(page).at(loc).at(0)
    let page_num = if loc.page-numbering() == none {
      int_page_num
    } else {
      numbering(loc.page-numbering(), int_page_num)
    }

    if curr_symbol == none {
      curr_symbol = symbol
      curr_int_min_page = int_page_num
      curr_int_max_page = int_page_num
      curr_min_page = page_num
      curr_max_page = page_num
    }

    if curr_symbol != symbol {
      res.insert(
        curr_id,
        (
          ..res.at(curr_id, default: ()),
          (
            symbol: curr_symbol,
            children: curr_children,
            min_page: curr_min_page,
            max_page: curr_max_page,
          ),
        ),
      )
      curr_symbol = symbol
      curr_children = ()
    }

    curr_id = id_func(symbol)

    curr_children.push((detail: detail, page_num: page_num, loc: loc))
    (curr_int_min_page, curr_min_page) = if curr_int_min_page < int_page_num {
      (curr_int_min_page, curr_min_page)
    } else {
      (int_page_num, page_num)
    }

    (curr_int_max_page, curr_max_page) = if curr_int_max_page > int_page_num {
      (curr_int_max_page, curr_max_page)
    } else {
      (int_page_num, page_num)
    }
  }

  if curr_symbol != none {
    res.insert(
      curr_id,
      (
        ..res.at(curr_id, default: ()),
        (
          symbol: curr_symbol,
          children: curr_children,
          min_page: curr_min_page,
          max_page: curr_max_page,
        ),
      ),
    )
  } else {
    return
  }

  fn(res)
}

