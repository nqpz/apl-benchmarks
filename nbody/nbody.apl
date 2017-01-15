⍝ Cruft.
w ← ReadCSVInt 'w.txt'
w ← w[1]
h ← ReadCSVInt 'h.txt'
h ← h[1]
time_step ← ReadCSVDouble 'time_step.txt'
time_step ← time_step[1]
xps ← ReadCSVDouble 'xps.txt'
yps ← ReadCSVDouble 'yps.txt'
xvs ← ReadCSVDouble 'xvs.txt'
yvs ← ReadCSVDouble 'yvs.txt'

⍝ Code.  Some of this is a bit non-apl-y for it to work with tail2futhark.
indices ← ⍳(⍴ xps)[1]

move ← {
  p_i ← xps[⍵] yps[⍵]
  accel ← {
    p_j ← xps[⍵] yps[⍵]
    r ← p_j-p_i
    dist ← (+/r*2)*0.5
    r×÷1+dist*3
  }
  xa ← +/{(accel ⍵)[1]}¨indices
  ya ← +/{(accel ⍵)[2]}¨indices
  a ← xa ya
  v ← xvs[⍵] yvs[⍵]
  p1 ← p_i+v×time_step
  v1 ← v+a×time_step
  p1,v1
}

⍝ This 'write' is pretty slow.
write ← {
  indices ← ⍵[1]
  size ← ⍵[2]
  white ← (256×256×256)-1
  sub ← {
    idx ← ⍵
    is_chosen ← ∨/({⍵=idx}¨indices)
    is_chosen×white
  }
  sub¨⍳size
}

render ← {
  xpsl ← ⍵[1]
  ypsl ← ⍵[2]
  sub ← {
    x ← ⌊xpsl[⍵]
    y ← ⌊ypsl[⍵]
    mask ← (x≥0)∧(x<w)∧(y≥0)∧(y<h)
    (mask×1+y+x×h)-1
  }
  indices_flat ← sub¨indices
  write indices_flat (w×h)
}

xps1 ← {(move ⍵)[1]}¨indices
yps1 ← {(move ⍵)[2]}¨indices
xvs1 ← {(move ⍵)[3]}¨indices
yvs1 ← {(move ⍵)[4]}¨indices
frame ← render (xps1 yps1)

⍝ Return values.
⎕ ← xps1
⎕ ← yps1
⎕ ← xvs1
⎕ ← yvs1
⎕ ← frame
0
