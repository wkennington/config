fn add_to_path [entry]{
	for path $paths {
		if (eq $path $entry) {
			return
		}
	}
	paths = [ $@paths $entry ]
}

fn symlink [src dst]{
	mkdir -p (path-dir $dst)
	if (eq (_ = ?(readlink -f $dst)) $src) {
		return
	}
	rm -rf $dst
	ln -s $src $dst
}

tmpdir = $false
fn get_tmp_dir []{
	if $up:tmpdir {
		put $up:tmpdir
		return
	}

	local:possible_dirs = [
		$E:ROOT/dev/shm
		$E:ROOT/run/shm
		$E:ROOT/tmp
		$E:ROOT/var/tmp
	]
	tmps=[(mount | grep 'type \(tmpfs\|ramfs\)' | eawk [@line]{ put $line[3] })]
	for local:possible_dir $possible_dirs {
		try {
			test -w $possible_dir
			if (not (put $@tmps | each [tmp]{ eq $tmp $possible_dir } | or (all))) {
				fail "Couldn't find ram mounted tmpdir"
			}
		} except _ { } else {
			up:tmpdir = $possible_dir/tmp-(id -u)
			mkdir -p -m 0700 $up:tmpdir
			put $up:tmpdir
			return
		}
	}

	fail "Failed to find a valid tmp directory"
}

fn setup_tmp_dirs []{
	local:tmpdir = (get_tmp_dir)
	symlink $tmpdir $E:HOME/.tmp
	symlink $tmpdir $E:HOME/.cache
}

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

add_to_path $E:HOME/.bin
setup_tmp_dirs

# Emacs binds
builtin:edit:insert:binding[Ctrl-A] = $edit:move-dot-sol~
builtin:edit:insert:binding[Ctrl-E] = $edit:move-dot-eol~
builtin:edit:insert:binding[Ctrl-F] = $edit:move-dot-right~
builtin:edit:insert:binding[Ctrl-B] = $edit:move-dot-left~
