# docker-compose.vim
This is vim plugin that wraps docker-compose.

If you want to manage docker images, containers, and more,
you can use [docker.vim](https://github.com/skanehira/docker.vim)

![Imgur](https://imgur.com/8svyqMN.gif)

## Requirements
- docker-compose
- docker cli
- Vim >= 8.1.2021

## Installtion

**dein.vim**

```toml
[[plugins]]
repo = 'skanehira/docker-compose.vim'
```

**vim-plug**

```
Plug 'skanehira/docker-compose.vim'
```

Then run:
```
:PlugInstall
```

## Usage
If `{file}` is not specified, the plugin will find
`docker-compose.yaml` or `docker-compose.yml` from the current directory and use it.

| vim ex command                 | docker-compose command                       |
|--------------------------------|----------------------------------------------|
| `DockerCompose {args}`         | `docker-compose {args}`                      |
| `DockerComposeList {file}`     | `docker-compose -f {file} ps`                |
| `DockerComposeLogs {file}`     | `docker-compose -f {file} logs`              |
| `DockerComposeUp {file}`       | `docker-compose -f {file} up`                |
| `DockerComposeDown {file}`     | `docker-compose -f {file} down`              |
| `DockerComposeDownAll {file}`  | `docker-compose -f {file} down --rmi all -v` |
| `DockerComposeStart {file}`    | `docker-compose -f {file} start`             |
| `DockerComposeStop {file}`     | `docker-compose -f {file} stop`              |
| `DockerComposeRestart {file}`  | `docker-compose -f {file} restart`           |
| `DockerComposeBuild {file}`    | `docker-compose -f {file} build`             |
| `DockerComposePull {file}`     | `docker-compose -f {file} pull`              |
| `DockerComposeConfig {file}`   | `docker-compose -f {file} config`            |
| `DockerComposeServices {file}` | `docker-compose -f {file} services`          |
| `DockerComposeCreate {file}`   | `docker-compose -f {file} up --no-start`     |
| `DockerComposeRemove {file}`   | `docker-compose -f {file} rm -f`             |

## Config
```vim
" open terminal way
let g:docker_compose_open_terminal_way = 'top'
```

## Keybindings

### Container list

| key   | operation          |
|-------|--------------------|
| `u`   | start container    |
| `d`   | stop container     |
| `j`   | next container     |
| `k`   | previous container |
| `q`   | close window       |

### Services

| key   | operation        |
|-------|------------------|
| `u`   | start service    |
| `s`   | stop service     |
| `j`   | next service     |
| `k`   | previous service |
| `q`   | close window     |

## Author
skanehira
