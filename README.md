
This container definition contains the full build toolchain for monome eurorack modules, including 
the AVR32 cross-compiler and the LaTeX documentation build tools.


## Prerequisites

A container runtime, either one of:
- **Docker**: install [Docker CLI](https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-22-04) on Linux, or [Docker Desktop](https://www.docker.com/products/docker-desktop/) on macOS or Windows.
- **Containerd**: install [containerd](https://github.com/containerd/containerd/blob/main/docs/getting-started.md) + [nerdctl](https://github.com/containerd/nerdctl) on Linux, or [Rancher Desktop](https://docs.rancherdesktop.io/getting-started/installation) (macOS/Windows)

Docker is slightly easier to use (especially on Windows) but the containerd/nerdctl ecosystem is completely open.

If you're using Rancher Desktop, you may need to preload the `dewb/monome-build` container image [using the GUI](https://docs.rancherdesktop.io/ui/images) or by explicitly fetching it from the docker.io registry before referencing it in a `nerdctl run` command.

## Using with Docker

To build any module with a Makefile in the root folder (currently just Teletype):

```
git clone https://github.com/monome/teletype
cd teletype
git submodule update --init --recursive
docker run -v $(pwd):/target -t dewb/monome-build 
```

When the Makefile is not in the root folder, or if you want to run a different target or tool, you can provide a bash command line as an additional argument:

```
git clone https://github.com/monome/ansible
cd ansible
git submodule update --init --recursive
docker run -v $(pwd):/target -t dewb/monome-build "cd src; make"
```

Some other useful commands are `"make clean"` (or `"cd src; make clean"`) to clean build products, `"make format"` to format any modified files in the working tree with clang-format, or `"make format-all"` to format the entire source tree.

If you would prefer a shell inside the container to run multiple commands, provide the command `bash` (or your preferred shell) and add the `-i` flag to connect to the interactive console.

```
docker run -v $(pwd):/target -it dewb/monome-build "bash"
```

### Windows note

The commands above should also work in git-bash or Powershell on Windows; if you use CMD.exe, substitute `%CD%` for `$(pwd)`.

## Using with nerdctl

To build any module with a Makefile in the root folder (currently just Teletype):

```
git clone https://github.com/monome/teletype
cd teletype
git submodule update --init --recursive
nerdctl run -v $(pwd):/target -t dewb/monome-build 
```

When the Makefile is not in the root folder, or if you want to run a different target or tool, you can provide a bash command line as an additional argument:

```
git clone https://github.com/monome/ansible
cd ansible
git submodule update --init --recursive
nerdctl run -v $(pwd):/target -t dewb/monome-build "cd src; make"
```

Some other useful commands are `"make clean"` (or `"cd src; make clean"`) to clean build products, `"make format"` to format any modified files in the working tree with clang-format, or `"make format-all"` to format the entire source tree.

If you would prefer a shell inside the container to run multiple commands, provide the command `bash` (or your preferred shell) and add the `-i` flag to connect to the interactive console.

```
nerdctl run -v $(pwd):/target -it dewb/monome-build "bash"
```

### Windows note

nerdctl does not deal with Windows paths as well as Docker. Instead of using `$(pwd)`, provide the local project root directory as a quoted, absolute Windows path, with double backslashes. For example:

```
nerdctl run -v "C:\\Users\\myusername\\git\\teletype":/target -t dewb/monome-build
```