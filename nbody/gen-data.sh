#!/bin/sh

set -e

mkdir -p data

for n in 100 1000 10000; do
    echo 800i32 > data/$n.in
    echo 600i32 >> data/$n.in
    echo 1.0f32 >> data/$n.in
    futhark-dataset -g "[$n]f32" >> data/$n.in
    futhark-dataset -g "[$n]f32" >> data/$n.in
    futhark-dataset -g "[$n]f32" >> data/$n.in
    futhark-dataset -g "[$n]f32" >> data/$n.in
done
