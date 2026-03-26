;; publish.el — org-publish configuration for arjtala.github.io

(require 'ox-publish)
(require 'ox-html)

;; Don't prompt for confirmation
(setq org-confirm-babel-evaluate nil)

;; Don't use a timestamp cache so we always rebuild
(setq org-publish-use-timestamps-flag nil)

;; Suppress backup files
(setq make-backup-files nil)

(defvar site-preamble
  "<nav>
<a href=\"/\">home</a>
<a href=\"/about.html\">about</a>
<a href=\"https://github.com/arjtala\">github</a>
</nav>")

(defvar site-postamble
  "<p>&copy; %a — built with <a href=\"https://orgmode.org\">org-mode</a></p>")

(defvar site-head
  "<link rel=\"stylesheet\" type=\"text/css\" href=\"/css/style.css\" />
<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\" />")

(setq org-publish-project-alist
      `(("blog-posts"
         :base-directory ,(expand-file-name "posts")
         :base-extension "org"
         :publishing-directory ,(expand-file-name "public/posts")
         :publishing-function org-html-publish-to-html
         :recursive t
         :with-toc nil
         :section-numbers nil
         :html-head ,site-head
         :html-preamble ,site-preamble
         :html-postamble ,site-postamble
         :html-head-include-default-style nil
         :html-head-include-scripts nil)

        ("blog-pages"
         :base-directory ,(expand-file-name ".")
         :base-extension "org"
         :publishing-directory ,(expand-file-name "public")
         :publishing-function org-html-publish-to-html
         :recursive nil
         :with-toc nil
         :section-numbers nil
         :html-head ,site-head
         :html-preamble ,site-preamble
         :html-postamble ,site-postamble
         :html-head-include-default-style nil
         :html-head-include-scripts nil)

        ("blog-static"
         :base-directory ,(expand-file-name ".")
         :base-extension "jpg\\|png\\|svg\\|gif\\|css"
         :publishing-directory ,(expand-file-name "public")
         :publishing-function org-publish-attachment
         :recursive t)

        ("blog" :components ("blog-posts" "blog-pages" "blog-static"))))

;; Publish all
(org-publish "blog" t)
