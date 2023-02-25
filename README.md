flake-protostar
===============

nix flake for https://github.com/software-mansion/protostar

    ❯ nix shell github:georgewhewell/flake-protostar
    ❯ protostar
    usage: protostar [-h] [--profile PROFILE] [--version] [--no-color]
                    {init,build,install,remove,update,upgrade,test,deploy,declare,format,cairo-migrate,invoke,call,deploy-account,migrate-configuration-file,calculate-account-address,multicall}
                    ...

    positional arguments:
    {init,build,install,remove,update,upgrade,test,deploy,declare,format,cairo-migrate,invoke,call,deploy-account,migrate-configuration-file,calculate-account-address,multicall}

    optional arguments:
    -h, --help            show this help message and exit
    --profile PROFILE, -p PROFILE
                            Specifies active configuration profile defined in the configuration file.
    --version, -v         Show Protostar and Cairo-lang version.
    --no-color            Disable colors.
