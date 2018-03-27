fn t []{
	acpi -b
	date
}

fn grep [@args]{
	e:grep --color=auto $@args
}

fn ls [@args]{
	e:ls --color=auto $@args
}

set-env EDITOR vim
set-env PAGER "less -R"
set-env BLOCKSIZE M

unset-env GREP_OPTIONS
