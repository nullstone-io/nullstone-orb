#!/usr/bin/env bash

repo="nullstone-io/nullstone"

get_latest_version() {
  if [ -n "${GITHUB_TOKEN}" ]; then
    echo "Discovering latest Nullstone CLI version via authenticated GitHub API..."
    curl --silent -H "Accept: application/vnd.github.v3+json" \
      -H "Authorization: Bearer ${GITHUB_TOKEN}" \
      "https://api.github.com/repos/${repo}/releases/latest" | \
      grep tag_name | sed 's/\s*\"tag_name\": \"\([^"]*\)",/\1/'
  else
    echo "Discovering latest Nullstone CLI version via unauthenticated GitHub API..."
    curl --silent -H "Accept: application/vnd.github.v3+json" \
      "https://api.github.com/repos/${repo}/releases/latest" | \
      grep tag_name | sed 's/\s*\"tag_name\": \"\([^"]*\)",/\1/'
  fi
}

install() {
  version=$1
  raw_version=${version//v/} # Drop first character 'v'

  os="linux"
  arch="amd64"
  if uname | grep -q "Darwin"; then
      os="darwin"
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
