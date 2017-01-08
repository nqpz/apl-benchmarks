# APL benchmarks

Mostly from the futhark-benchmarks repo.  Mostly targeting Futhark
through TAIL.


## Running the benchmarks

These instructions are true for both the `crystal` and `nbody`
benchmarks.

If you want to run their respective real-time simulations, you must
install https://github.com/melsman/apltail and
https://github.com/henrikurms/tail2futhark.

Then `cd` into the benchmark of your choice and run something like:

```
TAIL_ROOT="path/to/apltail" make run
```

For example, if you installed apltail through Smackage, you can probably
run this:

```
TAIL_ROOT="$HOME/.smackage/lib/apltail/v1" make run
```
