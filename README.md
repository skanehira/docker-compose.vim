# docker-compose.vim
docker-compose wrap plugin.

# Installtion
e.g dein.vim

```toml
[[plugins]]
repo = 'skanehira/docker-compose.vim'
```

# Usage
wrap `docker-compose` command.
```vim
" this is same as docker-compose up"
:DockerCompose up
```

containers
```vim
" is no speficied {file}, default is find docker-compose.yaml and use it.
:DockerComposeList {file}
```

# Author
skanehira
