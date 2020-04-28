#!/usr/bin/env Rscript

# R - https://www.r-project.org/
#
# Usage:
# ./gcd.r 11 22 33 121
# [1] 11
#
# Or:
# Rscript ./gcd.r 11 22 33 121
# [1] 11
#

gcd <- function (a, b) {
  if (b == 0) {
    a
  } else {
    gcd(b, a %% b)
  }
}

gcdn <- function(ns) {
  Reduce(gcd, ns)
}

args <- commandArgs(trailingOnly=TRUE)
ns <- mapply(as.integer, args)
gcdn(ns)
