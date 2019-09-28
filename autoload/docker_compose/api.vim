" compose
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:base_cmd = 'docker-compose '

" wrap docker-compose command
function! docker_compose#api#execute(args) abort
    let cmd = s:base_cmd .. a:args
    let out = systemlist(cmd)
    if v:shell_error == 0
        call docker_compose#utils#message#echoerr('failed to execute ' .. cmd)
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

    execute 'terminal docker-compose ' .. join(a:000, ' ')
    nnoremap <buffer> <silent>q :bw!<CR>
endfunction

" tail logs
function! docker_compose#api#logs(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif
    call docker_compose#api#terminal('-f', compose_file, 'logs')
endfunction

function! docker_compose#api#compose_file(...) abort
    let args = a:1
    let compose_file = 'docker-compose.yaml'
    if len(args) is# 1
       let compose_file = args[0]
    endif

    return compose_file
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
