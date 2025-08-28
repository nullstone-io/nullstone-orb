#!/usr/bin/env bash

repo="nullstone-io/nullstone"

get_latest_version() {
  curl -sIL -o /dev/null -w '%{url_effective}' https://github.com/nullstone-io/nullstone/releases/latest | awk -F/ '{print $NF}'
}

install() {
  version_tag=$1
  version=${version_tag//v/} # Drop first character 'v'

  os="linux"
  arch="amd64"
  if uname | grep -q "Darwin"; then
      os="darwin"
  fi

  download_url="https://github.com/${repo}/releases/download/${version_tag}/nullstone_${version}_${os}_${arch}.tar.gz"
  echo "Downloading Nullstone CLI from '${download_url}'..."
  curl -o nullstone.tar.gz -sSL "${download_url}"
  tar -xvf nullstone.tar.gz

  echo "Installing Nullstone CLI to /usr/local/bin/nullstone"
  [ -w /usr/local/bin ] && SUDO="" || SUDO=sudo
  $SUDO mv nullstone /usr/local/bin/nullstone
  chmod +x /usr/local/bin/nullstone
}

Install() {
  desired_version="${PARAM_VERSION}"
  if [ -z "${desired_version}" ]; then
    desired_version=$(get_latest_version)
  fi
  if [ ! "$(which nullstone)" ]; then
    install "${desired_version}"
  else
    cur_version="v$(nullstone --version | cut -d ' ' -f3)"
    if [ "${desired_version}" = "${cur_version}" ]; then
      echo "Nullstone CLI is already installed, skipping installation."
      nullstone --version
    else
      echo "Nullstone CLI is out-of-date, installing ${desired_version}..."
      install "${desired_version}"
    fi
  fi
}

Install
