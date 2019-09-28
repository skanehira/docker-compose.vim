" compose
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

" wrap docker-compose command
function! docker#compose#api#execute(...) abort
    " TODO use job to execute docker-compose
endfunction

function! docker#compose#api#terminal(...) abort
	if a:0 == 0
		call docker#compose#utils#message#echoerr('there are no args')
        return
	endif

    if !docker#compose#utils#check#has('terminal')
        return
    endif

    if !docker#compose#utils#check#executable('docker-compose')
        return
    endif

    execute 'terminal docker-compose ' .. join(a:000, ' ')
    nnoremap <silent>q :bw!<CR>
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
