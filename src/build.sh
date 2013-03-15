build_dir=$(cd ../build; pwd)

emacs_w3m () {
    cd ${build_dir}/src
    arcfile=emacs-w3m.tar.gz
    [ -f ${arcfile} ] || curl -O http://dl.dropbox.com/u/64576/share/sw/${arcfile}
    tar xzf ${arcfile}
    cd emacs-w3m
    if [ -f Makefile ]; then
	make distclean
    fi
    autoconf
    ./configure --prefix=${build_dir}/emacs-w3m
    make
    make install
    cd ${build_dir}/emacs-w3m
    for f in $(ls ${build_dir}/emacs-w3m/share/emacs/site-lisp/w3m/*.el); do
	rm -f $(basename $f)
	ln $f .
    done
    rm -f w3m-load.el*
    mkdir -p recipes
    files='"bookmark-w3m.el" "mew-w3m.el"
"mime-w3m.el" "octet.el" "w3m-antenna.el" "w3m-bookmark.el"
"w3m-bug.el" "w3m-ccl.el" "w3m-cookie.el" "w3m-dtree.el" "w3m-ems.el"
"w3m-favicon.el" "w3m-fb.el" "w3m-filter.el" "w3m-form.el"
"w3m-hist.el" "w3m-image.el" "w3m-lnum.el" "w3m-mail.el"
"w3m-namazu.el" "w3m-perldoc.el" "w3m-proc.el" "w3m-rss.el"
"w3m-search.el" "w3m-session.el" "w3m-symbol.el" "w3m-tabmenu.el"
"w3m-ucs.el" "w3m-util.el" "w3m-weather.el" "w3m.el" '
    (echo '(emacs-w3m :version "1.4.501"'; \
	echo '           :doc "Emacs web browser based on w3m"'; \
	echo '           :files (' $files ')'; \
	echo ')') > recipes/emacs-w3m
}

mkdir -p ${build_dir} ${build_dir}/src
emacs_w3m
