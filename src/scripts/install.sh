#!/bin/bash -e

repo="nullstone-io/nullstone"

get_latest_version() {
  curl --silent "https://github.com/${repo}/releases/latest" | sed 's#.*tag/\(.*\)\".*#\1#'
}

install() {
  version=$1
  raw_version=${version//v/} # Drop first character 'v'

  os="linux"
  arch="amd64"
  if [ -n "$(uname | grep "Darwin")" ]; then
      platform="darwin"
  fi

  download_url="https://github.com/${repo}/releases/download/${version}/nullstone_${raw_version}_${os}_${arch}.tar.gz"
  echo "Downloading Nullstone CLI from '${download_url}'..."
  curl -o nullstone.tar.gz -sSL "${download_url}"
  tar -xvf nullstone.tar.gz

  echo "Installing Nullstone CLI to /usr/local/bin/nullstone"
  [ -w /usr/local/bin ] && SUDO="" || SUDO=sudo
  $SUDO mv nullstone /usr/local/bin/nullstone
  chmod +x /usr/local/bin/nullstone
}

Install() {
  latest_version=$(get_latest_version)
  if [ ! "$(which nullstone)" ]; then
    install "${latest_version}"
  else
    cur_version="v$(nullstone --version | cut -d ' ' -f3)"
    if [ "${latest_version}" = "${cur_version}" ]; then
      echo "Nullstone CLI is already installed, skipping installation."
      nullstone --version
    else
      echo "Nullstone CLI is out-of-date, installing latest..."
      install "${latest_version}"
    fi
  fi
}

# Will not run if sourced for bats-core tests.
# View src/tests for more information.
ORB_TEST_ENV="bats-core"
if [ "${0#*$ORB_TEST_ENV}" == "$0" ]; then
  Install
fi
