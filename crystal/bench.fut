-- ==
-- compiled input {
--   1000
--   1.0f32
--   1
--   1
--   1.0f32
-- }
--
-- compiled input {
--   1000
--   1.0f32
--   10
--   1
--   1.0f32
-- }
--
-- compiled input {
--   1000
--   1.0f32
--   100
--   1
--   1.0f32
-- }


include crystal

fun main
  (field_size : i32)
  (scale : f32)
  (degree : i32)
  (n_steps : i32)
  (time_delta : f32)
  : [][]i32 =
  map (\step_i ->
         let time = f32 step_i * time_delta
         in crystal [field_size] [scale] [degree] [time]) (iota n_steps)
