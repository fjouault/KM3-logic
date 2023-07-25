#!/bin/bash

#TRACE=TRUE

cmdin=/tmp/cmdin
cmdout=/tmp/cmdout
mknod "$cmdin" p
mknod "$cmdout" p


scenario1() {
	steps=()
	steps+=("new-instance (args 'class")
	steps+=("new-instance (args 'attribute")
	steps+=("select-edge (args 'instance_.* V_.* 'owner")
	steps+=("set-edge-with-opposite (args 'instance_.* 'instance_.* 'owner")
	steps+=("select-prop (args 'instance_.* 'lower")
	steps+=("set-number-prop (args 'instance_.* 'lower \(N_[0-9]\+\) ")
	steps+=("#define \1 1")
	steps+=("new-instance (args 'instance_.*")
	steps+=("select-prop (args 'instance_.* 'instance_.*")
	steps+=("set-bool-prop (args 'instance_.* 'instance_.* (true)")
}

loadScenario() {
	steps=()
	{
		while IFS= read -r line ; do
			steps+=("$line")
		done
	} < "$1"
}

#loadScenario scenario1.txt
#scenario1

if [ "$#" -ge 1 ] ; then
	if [ -f "$1" ] ; then
		echo "Loading scenario '$1'"
		loadScenario "$1"
		shift
	else
		echo "Error: could not find '$1'"
		exit
	fi
else
	echo "No scenario specified as argument, defaulting to built-in one"
	scenario1
fi
#echo "${steps[@]}" | hexdump -C

waitEmptyLine() {
	while IFS= read -r -u 3 line ; do
		echo $line
		if [ -z "$line" ] ; then
			break
		fi
	done
}

tail -f "$cmdin" | ./edit-km3.sh "$@" > "$cmdout" &
cheptre_pid=$!
run() {
	exec 3< "$cmdout"
	prev=
	prevStep=
	for step in "${steps[@]}" ; do
		if [ "${step:0:1}" == "%" ] ; then
			echo "Comment: $step"
			continue
		elif [ -z "$step" ] ; then
			continue
		fi
		if echo "$step" | grep '\\[0-9]' >/dev/null ; then
			#echo "Prev: $prev" >&2
			#echo "PrevStep: $prevStep" >&2
			oldStep="$step"
			step=$(echo "$prev" | sed -e "s/^.*$prevStep.*$/$step/")
			#echo "RESULT: $step" >&2
			echo "Step $oldStep => $step"
		else
			echo "Step '$step'"
		fi
		context=$(waitEmptyLine)
		if [ "$TRACE" = "TRUE" ] ; then
			echo "$context"
		fi
		#echo "HERE" >&2
		transitions=$(waitEmptyLine)
		if [ "$TRACE" = "TRUE" ] ; then
			echo "$transitions"
		fi
		if [ "${step:0:1}" == "#" ] ; then
			echo "	Executing $step"
			echo "$step" > "$cmdin"
		else
			n=$(echo "$transitions" | grep "$step")
			#echo $n >&2
			#n=$(echo $n | grep "$step")

			nb=$(echo "$n" | wc -l)
			if [ "$nb" -gt 1 ] ; then
				echo "$context"
				echo "Error in scenario: more than one transition matched at step '$step'"
				echo "$n" | sed -e "s/^/	/"
				echo quit > "$cmdin"
				return
			elif [ "$n" = "" ] ; then
				echo "$context"
				echo "Error in scenario: no transition matched at step '$step'"
				echo "$transitions" | sed -e "s/^/	/"
				echo quit > "$cmdin"
				return
			else
				echo "	Firing: $n"
				prev="$n"
				prevStep="$step"
				n=$(echo "$n" | sed -re "s/^([0-9]+):.*$/\1/")
				#n=$(waitEmptyLine | grep "$step" | sed -re "s/^([0-9]+):.*$/\1/")
				#echo "HERE2" >&2
				echo "$n" > "$cmdin"
				#echo "HERE3" >&2
			fi
		fi
		#sleep 1		# to make sure any trace is shown before we echo anything else
	done
	#waitEmptyLine >&2
	#waitEmptyLine >&2
	echo "************************ Scenario completed successfully *************************************"

	if [ -f /tmp/run_transparently ] ; then
		cat /dev/fd/3 &
		while IFS= read line ; do
			echo "$line" > "$cmdin"
		done
	else
		recording=/tmp/recording
		> "$recording"
		while true ; do
			context=$(waitEmptyLine)
			transitions=$(waitEmptyLine)
			echo "$transitions"
			while IFS= read line ; do
				if [ "$line" == "context" ] ; then
					echo "$context"
				elif [ "$line" == "transitions" ] ; then
					echo "$transitions"
				else
					echo "$line" > "$cmdin"
					fired=$(echo "$transitions" | grep "^$line:")
					if [ -z "$fired" ] ; then
						echo "$line" >> "$recording"
					else
						echo "$fired" >> "$recording"
					fi
					break
				fi
			done
		done
	fi
	#read a < /tmp/stdin
	#echo $a >&2
}
#< "$cmdout"

run

wait $cheptre_pid
