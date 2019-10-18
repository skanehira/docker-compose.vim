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

function! s:docker_compose_exit_cb(msg, ch, status) abort
    if a:status is 0
        if a:msg isnot# ''
            call docker_compose#utils#message#info(a:msg)
        endif
    else
        call docker_compose#utils#message#err(join(s:err_msg, "\n"))
    endif
endfunction

let s:err_msg = []

function! s:docker_compose_err_cb(ch, msg) abort
    call add(s:err_msg, a:msg)
endfunction

function! docker_compose#api#async_execute(msg, ...) abort
    if a:0 is# 0
        call docker_compose#utils#message#err('there are no args')
        return
    endif

    let s:err_msg = []
    let cmd = [trim(s:base_cmd)] + a:000
    call job_start(cmd, {
                \ 'err_cb': function('s:docker_compose_err_cb'),
                \ 'exit_cb': function('s:docker_compose_exit_cb', [a:msg])
                \ })
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

    execute get(g:, 'docker_compose_open_terminal_way', 'vert') .. ' terminal ' .. s:base_cmd .. join(a:000, ' ')
    nnoremap <buffer> <silent>q :bw!<CR>
endfunction

function! docker_compose#api#compose_file(...) abort
    let args = a:1

    if len(args) > 0
        let file = args[0]
        if filereadable(file)
            return [file, 1]
        endif
        return [file, 0]
    endif

    for f in ['docker-compose.yaml', 'docker-compose.yml']
        if filereadable(f)
            return [f, 1]
        endif
    endfor

    return ['docker-compose.yaml or docker-compose.yml', 0]
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
