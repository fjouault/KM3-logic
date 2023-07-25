#!/bin/bash

image=ghcr.io/np/incremental-class2relational-ceptre-cheptre
bin=(/bin/cheptre)
memory=32MB
extraDockerArgs=()

docker run -i --rm --oom-score-adj 1000 --memory "$memory" --memory-swap 0	\
	   --mount type=bind,source="$(realpath .)",target=/examples		\
	   "${extraDockerArgs[@]}"						\
	   "$image" "${bin[@]}" -D /examples +RTS -t -RTS "$@"
