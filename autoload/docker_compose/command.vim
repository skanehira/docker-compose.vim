" command
" Author: skanehira
" License: MIT

let s:save_cpo = &cpo
set cpo&vim

function! s:f_ps_filter(ctx, id, key) abort
    if a:key is# 'q'
        call popup_close(a:id)
        return 1
    elseif a:key is# 'u'
        call s:container_start(a:id, a:ctx)
        return 1
    elseif a:key is# 'd'
        call s:container_stop(a:id, a:ctx)
        return 1
    elseif a:key is# 'j'
        if a:ctx.select isnot len(a:ctx.contents) - 1
            let a:ctx.select = a:ctx.select + 1
        endif
    elseif a:key is# 'k'
        if a:ctx.select isnot 0
            let a:ctx.select = a:ctx.select - 1
        endif
    endif
    return popup_filter_menu(a:id, a:key)
endfunction

function! s:get_containers(compose_file) abort
    let result = docker_compose#api#execute('-f', a:compose_file, 'ps')
    if result is# ''
        return ''
    endif

    let title = result[0]
    let view_contents = result[2:]

    let contents = []
    for content in view_contents
        let tmp = split(content, ' ')
        call add(contents,{
                    \ 'name': tmp[0]
                    \ })
    endfor

    return {
                \ 'title': substitute(title, ' ', '-', 'g'),
                \ 'view_contents': view_contents,
                \ 'contents': contents,
                \ 'compose_file': a:compose_file,
                \ 'select': 0,
                \ }
endfunction

" get services
function! docker_compose#command#ps(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif

    let ctx = s:get_containers(compose_file)
    let ctx['filter'] = function('s:f_ps_filter', [ctx])

    call docker_compose#utils#window#create(ctx)
endfunction

" monitoring logs
function! docker_compose#command#logs(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif
    call docker_compose#api#terminal('-f', compose_file, 'logs')
endfunction

" docker compose up
function! docker_compose#command#up(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif
    call docker_compose#api#terminal('-f', compose_file, 'up')
endfunction

" docker compose down
function! docker_compose#command#down(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif
    call docker_compose#utils#message#info('downing services...')
    call docker_compose#api#execute('-f', compose_file, 'down')
    call docker_compose#utils#message#info('downed services')
endfunction

" docker compose down and remove all
function! docker_compose#command#downall(...) abort
    let compose_file = docker_compose#api#compose_file(a:000)
    if !docker_compose#utils#check#filereadable(compose_file)
        return
    endif
    call docker_compose#utils#message#info('downing services...')
    call docker_compose#api#execute('-f', compose_file, 'down', '--rmi', 'all')
    call docker_compose#utils#message#info('downed services')
endfunction

" update container list
function! s:update_list(winid, ctx) abort
    let ctx = s:get_containers(a:ctx.compose_file)
    call popup_settext(a:winid, ctx.view_contents)
endfunction

" start container
function! s:container_start(winid, ctx) abort
    if !docker_compose#utils#check#executable('docker')
        return
    endif
    let container = a:ctx.contents[a:ctx.select].name
    call docker_compose#utils#message#info('starting ' .. container)
    call docker_compose#api#docker('start', container)

    call s:update_list(a:winid, a:ctx)
    call docker_compose#utils#message#info('started ' .. container)
endfunction

" stop container
function! s:container_stop(winid, ctx) abort
    if !docker_compose#utils#check#executable('docker')
        return
    endif
    let container = a:ctx.contents[a:ctx.select].name
    call docker_compose#utils#message#info('stopping ' .. container)
    call docker_compose#api#docker('stop', container)

    call s:update_list(a:winid, a:ctx)
    call docker_compose#utils#message#info('stopped ' .. container)
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
