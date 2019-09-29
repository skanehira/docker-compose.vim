" compose
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:base_cmd = 'docker-compose '

" wrap docker-compose command
function! docker_compose#api#execute(...) abort
    if a:0 is# 0
		call docker_compose#utils#message#err('there are no args')
        return
    endif

    let cmd = s:base_cmd .. join(a:000, ' ')
    let out = systemlist(cmd)
    if v:shell_error != 0
        call docker_compose#utils#message#err('failed to execute: ' .. join([cmd] + out, "\n"))
        return ''
    endif

    redraw
    return out
endfunction

" execute docker cli
function! docker_compose#api#docker(...) abort
    if a:0 is# 0
		call docker_compose#utils#message#err('there are no args')
        return
    endif

    let cmd = 'docker ' .. join(a:000, ' ')
    let out = systemlist(cmd)
    if v:shell_error != 0
        call docker_compose#utils#message#err('failed to execute: ' .. join([cmd] + out, "\n"))
        return ''
    endif

    return out
endfunction

" execute docker-compose in the terminal
function! docker_compose#api#terminal(...) abort
	if a:0 == 0
		call docker_compose#utils#message#err('there are no args')
        return
	endif

    if !docker_compose#utils#check#has('terminal')
        return
    endif

    if !docker_compose#utils#check#executable('docker-compose')
        return
    endif

    execute 'terminal ' .. s:base_cmd .. join(a:000, ' ')
    nnoremap <buffer> <silent>q :bw!<CR>
endfunction

function! docker_compose#api#compose_file(...) abort
    let args = a:1
    let compose_file = 'docker-compose.yaml'
    if len(args) >= 1
       let compose_file = args[0]
    endif

    return compose_file
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
