"~/Code/iex/*.ex"
|> Path.expand()
|> Path.wildcard()
|> Enum.flat_map(&c/1)
