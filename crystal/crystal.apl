⍝ Cruft.
field_size ← ReadCSVInt 'field_size.txt'
field_size ← field_size[1]
scale ← ReadCSVDouble 'scale.txt'
scale ← scale[1]
degree ← ReadCSVInt 'degree.txt'
degree ← degree[1]
time ← ReadCSVDouble 'time.txt'
time ← time[1]

⍝ Code.  Some of this is a bit non-apl-y for it to work with tail2fthark.
wave ← {
  (2○((2○⍵)×⍺[1]+(1○⍵)×⍺[2])+1)÷2
}

waver ← {
  p ← ⍵
  +/{p wave ⍵×○÷1+(time*1.5)×0.005}¨⍳degree
}

wrap ← {
  n ← ⍵-⌊⍵
  odd ← 2|⌊⍵
  even ← 1-odd
  odd×(1-n)+even×n
}

⍝ The colour transformation is not completely right.  There's a bug somewhere.
wave_colour ← {
  r ← 255×1
  g ← 255×0.4+⍵×0.6
  b ← 255×⍵
  (⌊r×(2*16))+(⌊g×(2*8))+(⌊b)
}

quasicrystal ← {
  x ← (field_size|⍵)×scale÷field_size
  y ← (⌊⍵÷field_size)×scale÷field_size
  wave_colour wrap waver (x y)
}

⍝ Return values.
frame ← quasicrystal¨ ⍳ field_size×field_size
⎕ ← frame
0
