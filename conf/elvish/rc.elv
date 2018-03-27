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

# Emacs binds
builtin:edit:insert:binding[Ctrl-A] = { edit:move-dot-sol }
builtin:edit:insert:binding[Ctrl-E] = { edit:move-dot-eol }
builtin:edit:insert:binding[Ctrl-F] = { edit:move-dot-right }
builtin:edit:insert:binding[Ctrl-B] = { edit:move-dot-left }
