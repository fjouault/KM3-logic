#!/bin/sh

(
	echo '% import "./graph.cep"'
	echo
	echo "context km3 = {"
	sed -rne "
		# Keeping empty lines
		s/^$//p

		# Keeping one-line 'single-line' comments
		s/^\s*(%[^]*)?$/  \1/p

		# Keeping one-line 'multi-line' comments
		s/^\s*[/][*]\s*(([^*]|[*][^/])*)[*][/]\s*$/  % \1/p

		s/^\s*node\(([^,]*),([^,]*)\)\.\s*$/  node '\1 '\2,/p
		s/^\s*edge\(([^,]*),([^,]*),([^,]*)\)\.\s*$/  edge '\1 '\2 '\3,/p
		s/^\s*prop\(([^,]*),([^,]*),([^,]*)\)\.\s*$/  prop '\1 '\2 \3,/p

	" KM3.pl | sed -re '
		s/prop ([^ ]*) ([^ ]*) (".*")/prop \1 \2 (vstring \3)/
		s/prop ([^ ]*) ([^ ]*) (true|false)/prop \1 \2 (vbool \3)/
		s/prop ([^ ]*) ([^ ]*) (-?[0-9]+)/prop \1 \2 (vnumber \3)/
	'
	echo "}."
) > km3.cep

