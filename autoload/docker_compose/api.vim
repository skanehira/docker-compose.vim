" compose
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" wrap docker-compose command
function! docker_compose#api#execute(...) abort
    " TODO use job to execute docker-compose
endfunction

" execute docker-compose in the terminal
function! docker_compose#api#terminal(...) abort
	if a:0 == 0
		call docker_compose#utils#message#echoerr('there are no args')
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

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
