# Runs prior to every test
setup() {
    # Load our script file.
    source ./src/scripts/install.sh
}

@test '1: Install' {
    Install
    [ -x "/usr/local/bin/nullstone" ]
}