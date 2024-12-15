## Notes

This is a build of the decompilation and port to modern platforms by numerous 
authors - see:
 [https://github.com/n64decomp/perfect_dark](https://github.com/n64decomp/perfect_dark)
 [https://github.com/fgsfdsfgs/perfect_dark](https://github.com/fgsfdsfgs/perfect_dark)

Thanks to the teams for this amazing work.


## Compile

```
# This was compiled on aarch64 Ubuntu 24.04

# Get dependencies
apt install libsdl-dev

# Compile
git clone https://github.com/fgsfdsfgs/perfect_dark.git
cd perfect_dark
cmake -G'Unix Makefiles' -Bbuild .
cd build
make
```
