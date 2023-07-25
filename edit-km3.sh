#!/bin/sh

./cheptre.sh graph.cep km3.cep graph-helpers.cep graph-validity.cep graph-edit.cep graph-navigate.cep checking-with-manual-memoization.cep --set-context km3 --add-context '{stage editing}' --omit-pointless-choices "$@"
