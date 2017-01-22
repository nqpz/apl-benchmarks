-- ==
-- compiled input @ data/100.in
-- compiled input @ data/1000.in
-- compiled input @ data/10000.in

include nbody

fun main
  (w : i32)
  (h : i32)
  (time_step : f32)
  (xps : [n]f32)
  (yps : [n]f32)
  (xvs : [n]f32)
  (yvs : [n]f32)
  : ([]f32, []f32, []f32, []f32, []i32) =
  nbody [w] [h] [time_step] xps yps xvs yvs
