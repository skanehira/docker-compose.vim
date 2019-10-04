" docker-compose
" Author: skanehira
" License: MIT

if exists('g:loaded_docker_compose')
  finish
endif

let g:loaded_docker_compose = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=+ DockerCompose call docker_compose#api#terminal(<f-args>)
command! -nargs=? -complete=file DockerComposeLogs call docker_compose#command#logs(<f-args>)
command! -nargs=? -complete=file DockerComposeList call docker_compose#command#ps(<f-args>)
command! -nargs=? -complete=file DockerComposeUp call docker_compose#command#up(<f-args>)
command! -nargs=? -complete=file DockerComposeDown call docker_compose#command#down(<f-args>)
command! -nargs=? -complete=file DockerComposeDownAll call docker_compose#command#downall(<f-args>)
command! -nargs=? -complete=file DockerComposeStart call docker_compose#command#start(<f-args>)
command! -nargs=? -complete=file DockerComposeStop call docker_compose#command#stop(<f-args>)
command! -nargs=? -complete=file DockerComposeRestart call docker_compose#command#restart(<f-args>)
command! -nargs=? -complete=file DockerComposeBuild call docker_compose#command#build(<f-args>)
command! -nargs=? -complete=file DockerComposePull call docker_compose#command#pull(<f-args>)
command! -nargs=? -complete=file DockerComposeConfig call docker_compose#command#config(<f-args>)
command! -nargs=? -complete=file DockerComposeServices call docker_compose#command#services(<f-args>)
command! -nargs=? -complete=file DockerComposeCreate call docker_compose#command#create(<f-args>)
command! -nargs=? -complete=file DockerComposeRemove call docker_compose#command#remove(<f-args>)

let &cpo = s:save_cpo
unlet s:save_cpo

" vim:set et:
