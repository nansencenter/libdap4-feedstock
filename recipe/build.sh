#!/bin/bash

if [[ $(uname) == Darwin ]]; then
  export LIBRARY_SEARCH_VAR=DYLD_FALLBACK_LIBRARY_PATH
elif [[ $(uname) == Linux ]]; then
  export LIBRARY_SEARCH_VAR=LD_LIBRARY_PATH
fi


export LDFLAGS="-L$PREFIX/lib $LDFLAGS"
export CPPFLAGS="-I$PREFIX/include $CPPFLAGS"

autoreconf --force --install

bash configure --prefix=$PREFIX \
               --enable-threads=pth \
               --with-xml2=$PREFIX \
               --with-curl=$PREFIX \


make
ls /Users/travis/miniconda3/conda-bld/work
eval ${LIBRARY_SEARCH_VAR}=$PREFIX/lib make check
make install
