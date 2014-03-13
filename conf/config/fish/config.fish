function add_to_path
	set done 0
	for path in $PATH
		if [ "$path" = "$argv[1]" ]
			set done 1
		end
	end
	if [ "$done" -eq 0 ]
		set -x PATH $PATH $argv[1]
	end
end

function t
	acpi -b
	date
end

set -x EDITOR vim
set -x PAGER less
set -x BLOCKSIZE M

add_to_path "$HOME/.bin"
