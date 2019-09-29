# docker-compose.vim
docker-compose wrap plugin.

## Requirements
- docker-compose
- docker cli

## Installtion
e.g dein.vim

```toml
[[plugins]]
repo = 'skanehira/docker-compose.vim'
```

## Usage
If {file} is no specified, the plugin will find
docker-compose.yaml from the current directory and use it.

| vim ex command              | docker-compose command                     |
|-----------------------------|--------------------------------------------|
| DockerCompose {args}        | docker-compose {args}                      |
| DockerComposeList {file}    | docker-compose -f {file} ps                |
| DockerComposeLogs {file}    | docker-compose -f {file} logs              |
| DockerComposeUp {file}      | docker-compose -f {file} up                |
| DockerComposeDown {file}    | docker-compose -f {file} down              |
| DockerComposeDownAll {file} | docker-compose -f {file} down --rmi all -v |
| DockerComposeStart {file}   | docker-compose -f {file} start             |
| DockerComposeStop {file}    | docker-compose -f {file} stop              |
| DockerComposeRestart {file} | docker-compose -f {file} restart           |
| DockerComposeBuild {file}   | docker-compose -f {file} build             |
| DockerComposePull {file}    | docker-compose -f {file} pull              |
| DockerComposeConfig {file}  | docker-compose -f {file} config            |

## Keybindings
### container list

| key | operation       |
|-----|-----------------|
| u   | start contaienr |
| d   | stop contaienr  |

## Author
skanehira
