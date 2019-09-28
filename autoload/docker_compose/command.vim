" command
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

function! s:f_ps_filter(id, key) abort
	if a:key is# 'q'
		call popup_close(a:id)
		return 0
	endif
	return 1
endfunction

function! docker_compose#command#ps(...) abort
	let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif

	let contents = docker_compose#api#execute('-f', compose_file, 'ps')
	if contents is# ''
		return
	endif

	let ctx = {
				\ 'filter': function('s:f_ps_filter'),
				\ 'title': substitute(contents[0], ' ', '-', 'g'),
				\ 'content': contents[2:],
				\ }

	call docker_compose#utils#window#create(ctx)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
