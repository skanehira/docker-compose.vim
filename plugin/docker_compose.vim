" docker-compose
" Author: skanehira
" License: MIT

if exists('g:loaded_docker-compose')
  finish
endif

" TODO remove comment out
"let g:loaded_docker-compose = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=+ DockerCompose call docker_compose#api#terminal(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
