" Vim syntax file
syn match  mkdCodeStart    /^```\w*$/
syn match  mkdCodeEnd      /^```$/

syn cluster mkdNonListItem add=mkdCodeStart,mkdCodeEnd

