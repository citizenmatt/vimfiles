" Match log levels in Rider logs
syn match logLevelError "|E|"
syn match logLevelWarning "|W|"
syn match logLevelInfo "|I|"
syn match logLevelNotice "|V|"
syn match logLevelTrace "|T|"

" From MTDL9/vim-log-highlighting#12
" Matches time durations like 1ms or 1y 2d 23ns
 syn match logDuration '\(^\|\s\)\@<=\d\+\s*[mn]\?[ywdhms]\(\s\|$\)\@='
