" window
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

let s:last_title_window = -1
let s:last_content_window = -1

function! s:popup_filter(filter, id, key)
	call a:filter(a:id, a:key)
	return popup_filter_menu(a:id, a:key)
endfunction

function! docker_compose#utils#window#create(ctx) abort
	call popup_close(s:last_title_window)
	call popup_close(s:last_content_window)

	let s:last_content_window = popup_menu(a:ctx.content, {
				\ 'filter': function('s:popup_filter', [a:ctx.filter]),
				\ 'title': a:ctx.title,
				\ 'border': [1, 1, 1, 1],
				\ 'borderchars': ['-','|','-','|','+','+','+','+'],
				\ 'mapping': 0,
				\ })
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
