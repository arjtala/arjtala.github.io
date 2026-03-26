---
layout: post
---

# Emacs with natively-compiled EmacsLisp

This process has become far easier now that v29 is stable. The instructions below apply to Fedora but for the most part should be quite similar for other distributions and even mac os.

## Prerequisites

Install packages

{% highlight bash %}
> sudo dnf install -y \
    jansson-devel \
    mpfr-devel \
    libmpc-devel \
    gmp-devel \
    libgccjit-devel \
    autoconf \
    texinfo \
    libX11-devel \
    jansson \
    jansson-devel \
    libXpm \
    libXaw-devel \ 
    libjpeg-turbo-devel \
    ibpng-devel \
    giflib-devel \
    libtiff-devel \
    gnutls-devel \
    ncurses-devel \
    gtk3-devel \
    webkit2gtk3-devel
{% endhighlight %}

## Clone and install Emacs

`git clone git@github.com:emacs-mirror/emacs.git && cd emacs/`

I have no idea if these are the optimal settings so proceed at your own peril.

{% highlight bash %}
> make clean

> ./autogen.sh

> ./configure \
    --with-dbus \
    --with-gif \
    --with-jpeg \
    --with-png \
    --with-rsvg \
    --with-tiff \
    --with-xft \
    --with-xpm \
    --with-gpm=no \
    --with-xwidgets \
    --with-modules \
    --with-native-compilation \
    --with-pgtk \
    --with-threads \
    --with-included-regex

> make -j8

> sudo make install prefix=$(HOME)/.local/emacs
{% endhighlight %}

## Native Compilation
I deleted everything in the `~/.emacs.d/elpa` directory.
You can edit your `init.el` file to include the following near the top:

(setq comp-speed 2)
Adding the below will store all compiled *.eln files in cache/eln-cache within your Emacs configuration directory:

{% highlight lisp %}
(when (boundp 'comp-eln-load-path)
    (setcar comp-eln-load-path
            (expand-file-name "cache/eln-cache/" user-emacs-directory)))
{% endhighlight %}

I also have an early-init.el file with this supposed speedup hack and aesthetic tweaks

{% highlight lisp %}
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil  :family "Source Code Pro" :height 80 :weight 'normal)
(add-to-list 'default-frame-alist '(undecorated . t))
{% endhighlight %}

Confirm the native compilation is working

{% highlight lisp %}
(if (and (fboundp 'native-comp-available-p)
        (native-comp-available-p))
    (message "Native compilation is available")
(message "Native complation is *not* available"))
{% endhighlight %}

And one more tweak to the `init.el` file for scrolling: `(pixel-scroll-precision-mode)`

Now everything should be running buttery smooth.

![emacs-screenshot](/assets/emacs_screenshot.png){:class="img-responsive"}
