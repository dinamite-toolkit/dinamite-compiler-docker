export PATH=$PATH:/root/dinamite/build/bin
export LLVM_SOURCE=/root/dinamite/llvm-3.5.0.src/
export LLVM_BUILD=/root/dinamite/build
export DIN_ROOT=/root/dinamite/llvm-3.5.0.src/projects/dinamite/
export INST_LIB=/root/dinamite/llvm-3.5.0.src/projects/dinamite/library
export DIN_CC="clang -g -Xclang -load -Xclang /root/dinamite/llvm-3.5.0.src/Release+Asserts/lib/AccessInstrument.so"
export DIN_CXX="clang++ -g -Xclang -load -Xclang /root/dinamite/llvm-3.5.0.src/Release+Asserts/lib/AccessInstrument.so"
export DIN_LDFLAGS="-L/root/dinamite/llvm-3.5.0.src/projects/dinamite/library -linstrumentation -lpthread"
export LD_LIBRARY_PATH=$INST_LIB