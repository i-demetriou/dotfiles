# Contains useful Docker Aliases

_docker-images() {
  local cur
  local images
  COMPREPLY=()

  _get_comp_words_by_ref -n : cur
  images=$(docker image ls --format '{{.Repository}}:{{.Tag}}')
  # REPO=${image%/*}
  # FULL_NAME=${image##*/}
  # TAG=${FULL_NAME##*:}
  # NAME=${FULL_NAME%:*}
  COMPREPLY=($(compgen -W "${images}" -- ${cur}))
  __ltrim_colon_completions "$cur"
}

_docker-images_name() {
  local cur
  local images
  COMPREPLY=()

  _get_comp_words_by_ref -n : cur
  images=$(docker image ls --format '{{.Repository}}')
  COMPREPLY=($(compgen -W "${images}" -- ${cur}))
  __ltrim_colon_completions "$cur"
}

_docker-images_id() {
  local cur
  local images
  COMPREPLY=()

  _get_comp_words_by_ref -n : cur
  images=$(docker image ls --format '{{.ID}}')
  COMPREPLY=($(compgen -W "${images}" -- ${cur}))
  __ltrim_colon_completions "$cur"
}

_docker-containers() {
  local cur containers
  cur="${COMP_WORDS[COMP_CWORD]}"
  containers=$(docker container ls --all --format '{{.Names}}')
  COMPREPLY=($(compgen -W "${containers}" -- ${cur}))
}

docker-logs() {
  local IMAGE_NAME="$1"
  docker logs -f "$IMAGE_NAME" |& \source-highlight --failsafe -f esc256 --lang-def javalog.lang --style-file javalog.style
}
alias dlog='docker-logs'
complete -F _docker-containers dlog

docker-ps-short() {
  docker ps --format 'table {{.Status}}\t{{.Names}}\t\t{{.Image}}' --all |
    sed -E 's|(.+?\s\s+)([a-zA-Z0-9\:]+)/.+/([^\s]+)|\1(\2) \3|'
}
alias dps="docker-ps-short"

docker-stats-short() {
  docker stats --format 'table {{.Name}}\t\t{{.CPUPerc}}\t{{.MemUsage}} ({{.MemPerc}})\t{{.NetIO}}\t{{.BlockIO}}' --no-trunc
}
alias dstats="docker-stats-short"

docker-stop-all() {
  docker stop $(docker ps --format '{{.ID}}')
  echo "docker container prune"
  docker container prune
}
alias dstopall='docker-stop-all'
alias dkillall='docker rm -f `docker ps --all --format "{{.ID}}"`'

alias dkill='docker rm -f'
complete -F _docker-containers dkill

docker-search() {
  local IMAGE_NAME="$1"
  docker search ${IMAGE_NAME} --format 'table {{.Name}}'
}
alias dsearch='docker-search'
complete -F _docker-images dsearch

docker-env() {
  local CONTAINER_NAME="$1"
  docker inspect --type container --format='{{range $env := .Config.Env}}{{$env}}{{"\n"}}{{end}}' $CONTAINER_NAME
}
alias denv='docker-env'
complete -F _docker-containers denv

docker-exec() {
  local CONTAINER_NAME="$1"
  docker exec -it ${CONTAINER_NAME} /bin/bash
}
alias dexec='docker-exec'
complete -F _docker-containers dexec

docker-run() {
  local IMAGE_NAME="$1"
  docker run -it ${IMAGE_NAME} /bin/bash
}
alias drun='docker-run'
complete -F _docker-images_id drun

alias dupd='docker-compose up -d --remove-orphans'
alias ddown='docker-compose down --remove-orphans'
alias dls='docker image ls'
