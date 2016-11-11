mkdir -p dinamite_mount
docker run -dit -P --name din-compiler -v `pwd`/dinamite_mount:/dinamite_workspace dinamite/compiler /bin/bash
