#!/usr/bin/env python

from nbody import nbody

import numpy
import pygame
import time
import random
import math
import sys


w, h = 800, 600
time_step = 1.0
size = (w, h)

_step = nbody().nbody
def step(xps, yps, xvs, yvs):
    w1 = numpy.array([w])
    h1 = numpy.array([h])
    time_step1 = numpy.array([time_step]).astype('float32')
    return _step(w1, h1, time_step1, xps, yps, xvs, yvs)

def random_points(n):
    return [(random.randrange(0, w), random.randrange(0, h))
            for i in range(n)]

def random_from(f):
    while True:
        x, y = (random.randrange(0, w),
                random.randrange(0, h))
        if f(x, y):
            return x, y

def donut_points(n):
    in_donut = lambda x, y: 140 < math.sqrt((w/2 - x)**2 + (h/2 - y)**2) < 280
    return [random_from(in_donut) for i in range(n)]

def cluster_points(n):
    x0, y0 = w / 2, h / 2
    r = 50
    return [(random.randint(x0 - r, x0 + r),
             random.randint(y0 - r, y0 + r))
            for i in range(n)]

def main():
    global screen, font
    pygame.init()
    pygame.display.set_caption('nbody')
    screen = pygame.display.set_mode(size)
    font = pygame.font.Font(None, 36)

    n = 1000
    ps = donut_points(n)
    # ps = random_points(n)
    # ps = cluster_points(n)
    xps = numpy.array([x for x, y in ps]).astype('float32')
    yps = numpy.array([y for x, y in ps]).astype('float32')
    xvs = numpy.zeros(n).astype('float32')
    yvs = numpy.zeros(n).astype('float32')
    while True:
        xps, yps, xvs, yvs = render_frame(xps, yps, xvs, yvs)
        render_frame(xps, yps, xvs, yvs)
        for event in pygame.event.get():
            if event.type == pygame.QUIT:
                return 0

def show_text(what, where):
    text = font.render(what, 1, (0, 255, 0))
    screen.blit(text, where)

def render_frame(xps, yps, xvs, yvs):
    start = time.time()
    xps, yps, xvs, yvs, frame = step(xps, yps, xvs, yvs)
    frame = frame.get()
    frame = frame.reshape(size)
    end = time.time()

    pygame.surfarray.blit_array(screen, frame)

    speed_message = "APL call took %.2fms" % ((end-start) * 1000)
    show_text(speed_message, (10, 10))

    pygame.display.flip()
    return xps, yps, xvs, yvs

sys.exit(main())
