" check
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" checking features
function! docker_compose#utils#check#has(feature) abort
    if !has(a:feature)
        call docker_compose#utils#message#err(a:features .. ' is not supported')
        return 0
    endif
    return 1
endfunction

" checking executable cmd
function! docker_compose#utils#check#executable(cmd) abort
    if !executable(a:cmd)
        call docker_compose#utils#message#err(a:cmd .. ' is not installed')
        return 0
    endif
    return 1
endfunction

" checking file readable
function! docker_compose#utils#check#filereadable(file) abort
    if !filereadable(a:file)
        call docker_compose#utils#message#err(a:file .. ' is not exist or readable')
        return 0
    endif
    return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
