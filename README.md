
This docker image contains the full build toolchain for monome eurorack modules, including 
the AVR32 cross-compiler and the LaTeX documentation build tools.

To build Teletype on a Linux or OS X machine, with no prerequisites other than Docker:

```
git clone https://github.com/monome/teletype
cd teletype
git submodule update --init  --recursive
docker run -v $(pwd):/target -t dewb/monome-build 
```

Or to build ansible/whitewhale/earthsea/meadowphysics, which require an extra argument because the Makefile is in the `src` folder:
```
git clone https://github.com/monome/ansible
cd ansible
git submodule update --init  --recursive
docker run -v $(pwd):/target -t dewb/monome-build "cd src; make"
```

Windows users should be able to do the same in git-bash or Powershell, or, for 
CMD.exe, use `%CD%` in place of `$(pwd)` in the `docker run` command.