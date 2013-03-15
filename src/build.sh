build_dir=$(cd ../build; pwd)

emacs_w3m () {
    cd ${build_dir}/src
    arcfile=emacs-w3m.tar.gz
    [ -f ${arcfile} ] || curl -O http://dl.dropbox.com/u/64576/share/sw/${arcfile}
    tar xzf ${arcfile}
    cd emacs-w3m
    autoconf
    ./configure --prefix=${build_dir}/emacs-w3m
    make
    make install
    make install-el
    cd ${build_dir}/emacs-w3m
    cp ${build_dir}/emacs-w3m/share/emacs/site-lisp/w3m/* .
    mkdir -p recipes
    files='"ChangeLog" "ChangeLog.1" "bookmark-w3m.el" "mew-w3m.el"
"mime-w3m.el" "octet.el" "w3m-antenna.el" "w3m-antenna.elc"
"w3m-bookmark.el" "w3m-bookmark.elc" "w3m-bug.el" "w3m-bug.elc"
"w3m-ccl.el" "w3m-ccl.elc" "w3m-cookie.el" "w3m-cookie.elc"
"w3m-dtree.el" "w3m-dtree.elc" "w3m-ems.el" "w3m-ems.elc"
"w3m-favicon.el" "w3m-favicon.elc" "w3m-fb.el" "w3m-fb.elc"
"w3m-filter.el" "w3m-filter.elc" "w3m-form.el" "w3m-form.elc"
"w3m-hist.el" "w3m-hist.elc" "w3m-image.el" "w3m-image.elc"
"w3m-lnum.el" "w3m-lnum.elc" "w3m-load.el" "w3m-mail.el"
"w3m-mail.elc" "w3m-namazu.el" "w3m-namazu.elc" "w3m-perldoc.el"
"w3m-perldoc.elc" "w3m-proc.el" "w3m-proc.elc" "w3m-rss.el"
"w3m-rss.elc" "w3m-search.el" "w3m-search.elc" "w3m-session.el"
"w3m-session.elc" "w3m-symbol.el" "w3m-symbol.elc" "w3m-tabmenu.el"
"w3m-tabmenu.elc" "w3m-ucs.el" "w3m-util.el" "w3m-util.elc"
"w3m-weather.el" "w3m-weather.elc" "w3m.el" "w3m.elc"'
    (echo '(emacs-w3m :version "1.4.501"'; \
	echo '           :doc "Emacs web browser based on w3m"'; \
	echo '           :files (' $files ')'; \
	echo ')') > recipes/emacs-w3m
}

mkdir -p ${build_dir} ${build_dir}/src
emacs_w3m
