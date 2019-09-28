" check
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" checking features
function! docker_compose#utils#check#has(feature) abort
    if !has(a:feature)
		call docker_compose#utils#message#echoerr(a:features .. ' is not supported')
		return 0
    endif
	return 1
endfunction

" checking executable cmd
function! docker_compose#utils#check#executable(cmd) abort
    if !executable(a:cmd)
		call docker_compose#utils#message#echoerr(a:cmd .. ' is not installed')
        return 0
    endif
	return 1
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
