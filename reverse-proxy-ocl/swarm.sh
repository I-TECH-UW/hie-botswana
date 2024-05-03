#!/bin/bash

declare ACTION=""
declare MODE=""
declare COMPOSE_FILE_PATH=""
declare UTILS_PATH=""
declare TIMESTAMP
declare TIMESTAMPED_NGINX
declare SERVICE_NAMES=()
declare STACK="nginx-ocl"

function init_vars() {
  ACTION=$1
  MODE=$2

  COMPOSE_FILE_PATH=$(
    cd "$(dirname "${BASH_SOURCE[0]}")" || exit
    pwd -P
  )

  TIMESTAMP="$(date "+%Y%m%d%H%M%S")"
  TIMESTAMPED_NGINX="${TIMESTAMP}-nginx.conf"

  UTILS_PATH="${COMPOSE_FILE_PATH}/../utils"

  SERVICE_NAMES=("nginx-ocl")

  readonly ACTION
  readonly MODE
  readonly COMPOSE_FILE_PATH
  readonly UTILS_PATH
  readonly TIMESTAMP
  readonly TIMESTAMPED_NGINX
  readonly SERVICE_NAMES
  readonly STACK
}

# shellcheck disable=SC1091
function import_sources() {
  source "${UTILS_PATH}/docker-utils.sh"
  source "${UTILS_PATH}/config-utils.sh"
  source "${UTILS_PATH}/log.sh"
}

function add_configs() {
  # try \
  #   "docker config create --label name=nginx-ocl ${TIMESTAMPED_NGINX} ${COMPOSE_FILE_PATH}/config/nginx-temp.conf" \
  #   throw \
  #   "Failed to create nginx-ocl config"

  # log info "Updating nginx-ocl service: adding config file..."
  # docker service update --config-add source=${TIMESTAMPED_NGINX},target=/etc/nginx/nginx.conf ${STACK}_${SERVICE_NAMES}
  # # try \
  # #   "docker service update --config-add source=${TIMESTAMPED_NGINX},target=/etc/nginx/nginx.conf ${STACK}_${SERVICE_NAMES}" \
  # #   throw \
  # #   "Error updating ${SERVICE_NAMES} service"
  overwrite "Updating nginx-ocl service: adding config file... Done"
}

function deploy_nginx() {
  docker::deploy_service $STACK "${COMPOSE_FILE_PATH}" "docker-compose.yml" 
}

function initialize_package() {
  (
    deploy_nginx
  ) ||
    {
      log error "Failed to deploy package!"
      exit 1
    }
}

function destroy_package() {
  docker::stack_destroy $STACK

  mapfile -t nginx_secrets < <(docker secret ls -qf label=name=nginx-ocl)
  if [[ "${#nginx_secrets[@]}" -ne 0 ]]; then
    try "docker secret rm ${nginx_secrets[*]}" catch "Failed to remove nginx secrets"
  fi

  docker::prune_configs "nginx-ocl"
}

main() {
  init_vars "$@"
  import_sources

  if [[ "${ACTION}" == "init" ]] || [[ "${ACTION}" == "up" ]]; then
    log info "Running package"

    initialize_package
  elif [[ "${ACTION}" == "down" ]]; then
    log info "Scaling down package"

    docker::scale_services $STACK 0
  elif [[ "${ACTION}" == "destroy" ]]; then
    log info "Destroying package"
    destroy_package
  else
    log error "Valid options are: init, up, down, or destroy"
  fi
}

main "$@"
