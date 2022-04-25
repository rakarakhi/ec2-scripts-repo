#!/bin/bash
#
#
export target_line="         [plugins."io.containerd.grpc.v1.cri".containerd.untrusted_workload_runtime.options]"
export line_to_add="           SystemdCgroup = true"
echo $target_line
echo $line_to_add
#
while IFS= read -r line || [[ -n "$line" ]]; do
    	echo "Text read from file: $line"
    	echo "$line" >>./config.toml
	if [[ $line == $target_line ]];
	then
		echo "\n$line_to_add" >>./config.toml
	fi
done < ./config.toml.org
