# conda_auto_env.sh

Auto switching of conda envs, inspired by [this](https://github.com/chdoig/conda-auto-env) with a couple of modifications:
* notify of having switched to environment
* ensure `base` env selected when `environment.yml` not present

Note that this requires the `conda` command.

In my `~/.bashrc` I have

    source ~/.cfg/conda_auto_env.sh

    function cd () {
        builtin cd "$@"    # perform the actual cd
        conda_auto_env
    }