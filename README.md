# docker-compose.vim
docker-compose wrap plugin.

## Installtion
e.g dein.vim

```toml
[[plugins]]
repo = 'skanehira/docker-compose.vim'
```

## Usage
wrap `docker-compose` command.
```vim
" this is same as docker-compose up"
:DockerCompose up
```

containers
```vim
" if no speficied {file}, default is find docker-compose.yaml and use it.
:DockerComposeList {file}
```

build, create and run containers
```vim
:DockerComposeUp {file}
```

monitoring logs
```vim
:DockerComposeLogs {file}
```

build, create and start containers.
```vim
:DockerComposeUp {file}
 ```

stop, remove container and voluems, networks.
```vim
:DockerComposeDown {file}
```

stop, remove contaienr and voluems, networks, images
```vim
:DockerComposeDownAll {file}
```

## Keybindings
### docker compose list

| key | operation       |
|-----|-----------------|
| u   | start contaienr |
| d   | stop contaienr  |

## Author
skanehira
