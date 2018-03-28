fn bind [f @args]{
	put [@args2]{ $f $@args $@args2 }
}

fn orp []{ or (all) }
fn andp []{ and (all) }
fn notp []{ not (all) }

memoized = [&]
fn memoize [f]{
	put [@args]{
		local:fn = (to-string [$f $@args])
		try {
			put $memoized[$fn]
		} except _ {
			local:ret = ($f $@args)
			memoized[$fn] = $local:ret
			put $local:ret
		}
	}
}

fn add_to_path [entry]{
	if (put $@paths | each (bind $eq~ $entry) | orp | notp) {
		paths = [$@paths $entry]
	}
}

fn symlink [src dst]{
	mkdir -p (path-dir $dst)
	if (eq (_ = ?(readlink -f $dst)) $src) {
		return
	}
	rm -rf $dst
	ln -s $src $dst
}

fn get_tmp_dir_uncached []{
	tmps=[&]
	mount | grep 'type \(tmpfs\|ramfs\)' | awk '{print $3}' \
		| each [tmp]{ tmps[$tmp] = $ok }

	for local:possible_dir [dev/shm run/shm tmp var/tmp] {
		possible_dir = $E:ROOT/$possible_dir
		try {
			test -w $possible_dir
			_ = $tmps[$possible_dir]
		} except _ { } else {
			local:tmpdir = $possible_dir/tmp-(id -u)
			mkdir -p -m 0700 $local:tmpdir
			put $local:tmpdir
			return
		}
	}
	fail "Failed to find a valid tmp directory"
}

fn get_tmp_dir { (memoize $get_tmp_dir_uncached~) }

fn setup_tmp_dirs []{
	local:tmpdir = (get_tmp_dir)
	for local:dir [.tmp .cache] {
		symlink $tmpdir $E:HOME/$dir
	}
}

fn t []{
	acpi -b
	date
}

fn grep [@args]{ e:grep --color=auto $@args }
fn ls [@args]{ e:ls --color=auto $@args }

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
