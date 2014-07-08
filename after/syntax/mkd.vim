" Vim syntax file
syn match  mkdCodeStart    /^\s*```\w*$/
syn match  mkdCodeEnd      /^\s*```$/

syn cluster mkdNonListItem add=mkdCodeStart,mkdCodeEnd

