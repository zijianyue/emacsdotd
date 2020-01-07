;;-----------------------------------------------------------外观-----------------------------------------------------------;;
;; 字体保证中文是英文的两倍宽
;; Setting English Font

;; (package-initialize)
;; 目录复杂的移到.emacs.d目录下并专门指定load-path，防止load-path过多
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/all-the-icons.el"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/expand-region.el"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/evil"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/lsp-java"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/magit/lisp"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/treemacs/src/elisp"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/treemacs/src/extra"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/emacs-doom-themes"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/multiple-cursors.el"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/lsp-mode"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/lsp-ui"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/emacs-neotree"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/swiper"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/doom-modeline"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/helm"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/company-mode"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/emacs-purpose"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/aweshell"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/centaur-tabs"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/rg.el"))
;; (add-to-list 'load-path (concat user-emacs-directory "site-lisp/nyan-mode"))
;; (add-to-list 'load-path (concat user-emacs-directory "site-lisp/smartparens"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/dired-hacks"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/company-tabnine"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/snails"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/emacs-ccls"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/lsp-treemacs"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/markdown-mode"))
(add-to-list 'load-path (concat user-emacs-directory "site-lisp/ztree"))

(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

;; 打印调用函数的性能方法如下
;; M-x elp-instrument-package magit即查看magit包所有方法用掉的时间
;; 执行 magit-status
;; M-x elp-results 查看结果
;; M-x elp-restore-all取消

;; magit debug命令
;; magit-version magit-emacs-Q-command magit-debug-git-executable with-editor-debug
(require 'all-the-icons)

;; 窗口位置 大小
(setq initial-frame-alist
      '((top . 20) (left . 350) (width . 200 ) (height . 70)))

;; Start maximised (cross-platf)
;; (add-hook 'window-setup-hook 'toggle-frame-maximized t)

(set-face-attribute
 ;; 'default nil :font "source code pro" :weight 'normal :height 140) ;ultra-light
 ;; 'default nil :font "inconsolata 14")
 'default nil :font "Consolas 11")

;; 新开的窗口保持字体
(add-to-list 'default-frame-alist '(font . "Consolas 11"))

;;Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
                    charset
                    ;; (font-spec :family "Heiti SC" :size 14)));mac中Heiti SC能中英文等高
                    (font-spec :family "新宋体" :size 16)));mac中Heiti SC能中英文等高

;; 获取site-lisp路径
(defvar site-lisp-directory nil)
(if (eq system-type 'darwin)
    ;; (setq site-lisp-directory "/Applications/Emacs.app/Contents/Resources/site-lisp")
    (setq site-lisp-directory "/usr/local/share/emacs/site-lisp")
  (setq site-lisp-directory (expand-file-name (concat data-directory "../site-lisp"))))

(add-to-list 'custom-theme-load-path (concat user-emacs-directory "/site-lisp/emacs-doom-themes/themes"))
;;-----------------------------------------------------------设置-----------------------------------------------------------;;
;; 只有一个实例
(server-force-delete)
(server-start)

;; proxy
;; (setq url-proxy-services
;;       '(;; ("no_proxy" . "^\\(localhost\\|10.*\\)")
;;         ("http" . "proxy-address:8080")
;;         ("https" . "proxy-address:8080")))

;; (setq url-http-proxy-basic-auth-storage
;;       (list (list "proxy-address:8080"
;;                   (cons "Input your LDAP UID !"
;;                         (base64-encode-string "usrname:password")))))

;; 环境变量
(when (memq window-system '(mac ns))
  (require 'exec-path-from-shell)
  (exec-path-from-shell-initialize))

(when (memq system-type '(windows-nt ms-dos))
  (setenv "HOME" (expand-file-name "~"))
  (setenv "MSYS" "C:\\MinGW\\msys\\1.0\\bin") ;需要装wget命令，wget访问github需要加--no-check-certificate参数
  (setenv "MINGW" "C:\\MinGW\\bin")
  ;; (setenv "PUTTY" "C:\\Program Files\\PuTTY")
  (setenv "LLVM" "d:\\llvm-build\\bin")
  (setenv "CMAKE" "C:\\Program Files\\CMake\\bin")
  (setenv "GTAGSBIN" "c:\\gtags\\bin")
  ;; (setenv "PYTHON" "C:\\Python27")		;用27的话ycmd可以使用semantic补全
  (setenv "PYTHON3" "c:\\Python37")		;用27的话ycmd可以使用semantic补全
  (setenv "CYGWIN" "C:\\cygwin\\bin")
  (setenv "CPPCHECK" "C:\\Program Files (x86)\\Cppcheck")
  (setenv "PDFLATEX" "F:\\CTEX\\MiKTeX\\miktex\\bin")
  (setenv "PYTHONIOENCODING" "utf-8")     ;防止raw_input出错
  (setenv "GITCMD" "C:\\Program Files\\Git\\cmd")
  (setenv "MAVEN_HOME" "D:\\software\\apache-maven-3.6.1\\bin")
  (setenv "IMAGE_MAGICk" "D:\\software\\ImageMagick-7.0.8-61-portable-Q16-x64")
  (setenv "JAVABIN" "C:\\Program Files\\Java\\jdk1.8.0_202\\bin")
  )

(when (eq system-type 'darwin)
  (setenv "LIBEXEC" "/usr/local/opt/python/libexec/bin")
  (setenv "MAVEN_HOME" "~/apache-maven-3.6.0/bin")
  (setenv "LOCALBIN" "/usr/local/bin")    ;for mac
  ;; (setenv "PYTHONMAC" "/Library/Frameworks/Python.framework/Versions/2.7/bin/")
  (setenv "JAVA_HOME" "/Library/Java/JavaVirtualMachines/jdk-9.0.4.jdk/Contents/Home")
  (setenv "PATH"
        (concat
         (getenv "LIBEXEC")
         path-separator
         (getenv "PYTHONMAC")
         path-separator
         (getenv "LOCALBIN")
         path-separator
         (getenv "PATH")))
  )

;; (setenv "GTAGSLABEL" "pygments")

(setq python-shell-prompt-detect-enabled nil) ;用python27时需要加这个不然有warning
(setq python-shell-completion-native-enable nil) ;用python27时需要加这个不然有warning
(define-coding-system-alias 'UTF-8 'utf-8)       ;防止Warning (mule): Invalid coding system ‘UTF-8’ is specified for the current buffer/file by the :coding tag.

(setenv "PATH"
        (concat
         (getenv "MAVEN_HOME")
         path-separator
         (getenv "GITCMD")
         path-separator
         (getenv "PYTHON3")
         ;; path-separator
         ;; (getenv "PYTHON")
         path-separator
         (getenv "JAVABIN")
         path-separator
         (getenv "IMAGE_MAGICk")
         path-separator
         (getenv "MSYS")
         path-separator
         (getenv "MINGW")
         ;; path-separator
         ;; (getenv "PUTTY")
         path-separator
         (getenv "LLVM")
         path-separator
         (getenv "CMAKE")
         path-separator
         (getenv "GTAGSBIN")
         path-separator
         (getenv "CYGWIN")
         path-separator
         (getenv "CPPCHECK")
         path-separator
         (getenv "PDFLATEX")
         path-separator
         (getenv "PATH")))

(when (eq system-type 'darwin)
  (add-to-list 'exec-path (getenv "LIBEXEC")) ;放前面 带t是append
  (add-to-list 'exec-path (getenv "LOCALBIN")) ;放前面 带t是append
  (add-to-list 'exec-path (getenv "PYTHONMAC"))
  )

(add-to-list 'exec-path (getenv "JAVABIN"))
(add-to-list 'exec-path (getenv "GITCMD"))
(add-to-list 'exec-path (getenv "IMAGE_MAGICk") t)
(add-to-list 'exec-path (getenv "PYTHON3") t)
(add-to-list 'exec-path (getenv "MINGW") t)
(add-to-list 'exec-path (getenv "MSYS") t)
(add-to-list 'exec-path (getenv "LLVM") t)
(add-to-list 'exec-path (getenv "CMAKE") t)
(add-to-list 'exec-path (getenv "GTAGSBIN") t)
(add-to-list 'exec-path (getenv "CYGWIN") t)
(add-to-list 'exec-path (getenv "CPPCHECK") t)
(add-to-list 'exec-path (getenv "PDFLATEX") t)
(add-to-list 'exec-path (getenv "MAVEN_HOME") t)

;; windows的find跟gnu 的grep有冲突
(setq find-program (concat "\"" (getenv "MSYS") "\\find.exe\""))
(setq grep-program "grep -nH -F")		;-F按普通字符串搜索
;; 默认目录
(setq default-directory "d:/")

;; 启动mode
(setq initial-major-mode 'text-mode)

;; elpa
(setq-default
 load-prefer-newer t
 ;; package-enable-at-startup nil
 )

;; 先执行package-initialize再package-list-packages
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ("melpa-stable" . "http://stable.melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")))


;; mini buffer 的大小保持不变
;; (setq resize-mini-windows nil)
;; 没有提示音,也不闪屏
(setq ring-bell-function 'ignore)

;; Load CEDET
;; 生成函数注释
(global-set-key (kbd "C-c / C") 'srecode-document-insert-comment)
(autoload 'srecode-document-insert-comment "srecode" nil t)
(autoload 'global-srecode-minor-mode "srecode" nil t)
;; 设置模板路径,把模板放到"~/.emacs.d/.srecode/"，避免拷来拷去
(eval-after-load "srecode/map"
  '(progn
     (semantic-mode 1)
     (setq srecode-map-load-path (list (expand-file-name "~/.emacs.d/srecode/")
                                       (srecode-map-base-template-dir)
                                       ))))
(setq semantic-c-obey-conditional-section-parsing-flag nil) ; ignore #ifdef
(set-default 'semantic-case-fold t)

;;修改标题栏，显示buffer的名字
(setq frame-title-format "%b [%+] %f")
(setq icon-title-format "%b [%+] %f")

;; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no。
(fset 'yes-or-no-p 'y-or-n-p)

;; 不折行，影响性能
;; 有长行的文件除了打开truncate-lines，还可以用find-file-literally打开文件提高性能
;; (set-default 'truncate-lines t)
;; (setq truncate-partial-width-windows nil) ;; 左右分屏时折行
;; (if (eq 25 emacs-major-version)
;;  (horizontal-scroll-bar-mode 1))

;; 自动横移跟随水平滚动条切换
(defadvice horizontal-scroll-bar-mode(after horizontal-scroll-bar-mode-after activate)
  (if horizontal-scroll-bar-mode
   (setq auto-hscroll-mode nil)
 (setq auto-hscroll-mode t)))

;; 高亮单词跟高亮当前行有冲突
(defadvice highlight-symbol-at-point(after highlight-symbol-at-point-after activate)
  (if global-hl-line-mode
      (global-hl-line-mode -1)))
(setq compile-command "devenv.com projects.sln /build \"Debug|Win32\"") ;可以传sln 或vcproj编译工程
;; tab补全时忽略大小写
(setq-default completion-ignore-case t)
;; DIRED的时间显示格式
(setq ls-lisp-format-time-list  '("%Y-%m-%d %H:%M:%S" "%Y-%m-%d %H:%M:%S")
      ls-lisp-use-localized-time-format t)
;; 优先横分割窗口
(setq split-width-threshold 9999)	;增大向右分割的要求
;; (setq split-height-threshold 0)
;; (setq split-height-threshold nil)       ; Disable vertical window splitting
;; (setq split-width-threshold nil)        ; Disable horizontal window splitting

;; mac上的键盘换位
(setq mac-option-modifier 'super)
(setq mac-command-modifier 'meta)
;; hi lock颜色不要hi-black-hb
(with-eval-after-load 'hi-lock
  ;; (unless (featurep 'swiper)
    ;; (require 'swiper))
  (setq hi-lock-face-defaults '(;; "swiper-match-face-2" "swiper-match-face-3" "swiper-match-face-4" "swiper-match-face-1"
                                ;; "ivy-minibuffer-match-face-4" "ivy-minibuffer-match-face-3" "ivy-minibuffer-match-face-2" "ivy-minibuffer-match-face-1"
                                "hi-green" "hi-blue" "hi-pink" "hi-yellow" "hi-black-b" "hi-blue-b" "hi-red-b" "hi-green-b")))

;; 长行性能提升
(setq-default bidi-display-reordering nil)
;; (global-visual-line-mode)        ;系统自带 word wrap 右侧没有换行的标记

;; org inline picture size
;; (setq org-image-actual-width nil) ; org-image-actual-width的设置需要build with imagemagick support.用emax64
;; 在org文件中图片上方加上#+ATTR_ORG: :width 800，执行org-redisplay-inline-images生效

;; 自动添加的设置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ad-redefinition-action 'accept)
 '(ag-arguments '("--smart-case" "--stats" "-u"))
 '(ag-highlight-search t)
 '(auto-save-default nil)
 '(auto-save-visited-interval 3)
 '(auto-save-visited-mode t)
 '(autopair-blink nil)
 '(avy-background t)
 '(aw-scope 'frame)
 '(backward-delete-char-untabify-method nil)
 '(bookmark-save-flag 1)
 '(bookmark-sort-flag nil)
 '(c-electric-pound-behavior '(alignleft))
 '(cc-search-directories '("." "/usr/include" "/usr/local/include/*" "../*"))
 '(ccls-sem-macro-faces [font-lock-warning-face])
 '(ccls-tree-initial-levels 1)
 '(centaur-tabs-close-button " X")
 '(centaur-tabs-cycle-scope 'tabs)
 '(column-number-mode t)
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case t)
 '(company-dabbrev-other-buffers t)
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(confirm-kill-emacs 'y-or-n-p)
 '(counsel-gtags-auto-update t)
 '(counsel-gtags-update-interval-second 3)
 '(counsel-gtags-use-input-at-point nil)
 '(cquery-sem-macro-faces [font-lock-warning-face])
 '(cquery-tree-initial-levels 1)
 '(cursor-type t)
 '(custom-enabled-themes '(doom-one))
 '(custom-safe-themes
   '("e47c0abe03e0484ddadf2ae57d32b0f29f0b2ddfe7ec810bd6d558765d9a6a6c" "2d1fe7c9007a5b76cea4395b0fc664d0c1cfd34bb4f1860300347cdad67fb2f9" "b753c0d7872e154cd395c3d311456c71749dd3f1395e96f34a329cedd9209307" "6b2636879127bf6124ce541b1b2824800afc49c6ccd65439d6eb987dbf200c36" "b54826e5d9978d59f9e0a169bbd4739dd927eead3ef65f56786621b53c031a7c" "b0407354e87ea56fd708e8b2c0f72eb5beda2b7888a75acc62d711d75ab9f755" "49ec957b508c7d64708b40b0273697a84d3fee4f15dd9fc4a9588016adee3dad" default))
 '(delete-by-moving-to-trash t)
 '(delete-selection-mode t)
 '(diff-hl-flydiff-delay 4)
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(dired-recursive-copies 'always)
 '(dired-recursive-deletes 'always)
 '(display-line-numbers-width-start t)
 '(ediff-split-window-function 'split-window-horizontally)
 '(electric-indent-mode t)
 '(electric-pair-inhibit-predicate 'electric-pair-conservative-inhibit)
 '(electric-pair-mode t)
 '(enable-local-variables :all)
 '(enable-recursive-minibuffers t)
 '(eww-search-prefix "http://cn.bing.com/search?q=")
 '(explicit-shell-file-name "bash")
 '(fci-always-use-textual-rule t)
 '(fci-eol-char 32)
 '(fill-column 120)
 '(flycheck-checker-error-threshold nil)
 '(flycheck-emacs-lisp-load-path 'inherit)
 '(flycheck-indication-mode 'right-fringe)
 '(flycheck-navigation-minimum-level 'error)
 '(frame-resize-pixelwise t)
 '(gc-cons-threshold 8000000)
 '(git-commit-fill-column 200)
 '(git-commit-style-convention-checks nil)
 '(git-commit-summary-max-length 200)
 '(global-auto-revert-mode t)
 '(global-diff-hl-mode nil)
 '(global-display-line-numbers-mode t)
 '(global-eldoc-mode nil)
 '(global-hl-line-mode t)
 '(global-hl-line-sticky-flag t)
 '(grep-template "grep <X> <C> -nH -F <R> <F>")
 '(gud-pdb-command-name "python -i -m pdb")
 '(helm-M-x-fuzzy-match t)
 '(helm-ag-base-command "ag --vimgrep -S -Q -U")
 '(helm-ag-ignore-patterns '("target" "coverage-report"))
 '(helm-ag-insert-at-point 'symbol)
 '(helm-allow-mouse t)
 '(helm-autoresize-mode t)
 '(helm-buffer-max-length 40)
 '(helm-case-fold-search t)
 '(helm-completing-read-handlers-alist
   '((describe-function . helm-completing-read-symbols)
     (describe-variable . helm-completing-read-symbols)
     (describe-symbol . helm-completing-read-symbols)
     (debug-on-entry . helm-completing-read-symbols)
     (find-function . helm-completing-read-symbols)
     (disassemble . helm-completing-read-symbols)
     (trace-function . helm-completing-read-symbols)
     (trace-function-foreground . helm-completing-read-symbols)
     (trace-function-background . helm-completing-read-symbols)
     (find-tag . helm-completing-read-default-find-tag)
     (org-capture . helm-org-completing-read-tags)
     (org-set-tags . helm-org-completing-read-tags)
     (ffap-alternate-file)
     (tmm-menubar)
     (find-file-at-point . helm-completing-read-sync-default-handler)
     (ffap . helm-completing-read-sync-default-handler)
     (dired-do-rename . helm-read-file-name-handler-1)
     (dired-do-copy . helm-read-file-name-handler-1)
     (dired-do-symlink . helm-read-file-name-handler-1)
     (dired-do-relsymlink . helm-read-file-name-handler-1)
     (dired-do-hardlink . helm-read-file-name-handler-1)
     (basic-save-buffer . helm-read-file-name-handler-1)
     (write-file . helm-read-file-name-handler-1)
     (write-region . helm-read-file-name-handler-1)))
 '(helm-completion-in-region-fuzzy-match t)
 '(helm-ff-skip-boring-files t)
 '(helm-for-files-preferred-list
   '(helm-source-buffers-list helm-source-recentf helm-source-bookmarks))
 '(helm-grep-file-path-style 'relative)
 '(helm-gtags-auto-update t)
 '(helm-gtags-cache-max-result-size 104857600)
 '(helm-gtags-cache-select-result t)
 '(helm-gtags-fuzzy-match t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-update-interval-second 3)
 '(helm-mode-fuzzy-match t)
 '(helm-rg-hidden t)
 '(helm-rg-smart-case t)
 '(helm-semantic-display-style
   '((python-mode . semantic-format-tag-summarize)
     (c-mode . semantic-format-tag-uml-prototype)
     (c++-mode . semantic-format-tag-uml-prototype)
     (emacs-lisp-mode . semantic-format-tag-abbreviate-emacs-lisp-mode)))
 '(helm-split-window-inside-p t)
 '(helm-truncate-lines t)
 '(hide-ifdef-shadow t)
 '(icomplete-show-matches-on-no-input t)
 '(ido-everywhere t)
 '(ido-mode 'both nil (ido))
 '(imenu-list-focus-after-activation t)
 '(imenu-list-idle-update-delay 1.5)
 '(imenu-max-item-length 120)
 '(imenu-max-items 1000)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-format-function 'ivy-format-function-arrow t)
 '(ivy-height 25)
 '(ivy-use-virtual-buffers t)
 '(large-file-warning-threshold 40000000)
 '(ls-lisp-verbosity nil)
 '(lsp-eldoc-hook '(lsp-hover))
 '(lsp-enable-indentation nil)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-enable-symbol-highlighting nil)
 '(lsp-file-watch-ignored
   '("[/\\\\]\\.git$" "[/\\\\]\\.hg$" "[/\\\\]\\.bzr$" "[/\\\\]_darcs$" "[/\\\\]\\.svn$" "[/\\\\]_FOSSIL_$" "[/\\\\]\\.idea$" "[/\\\\]\\.ensime_cache$" "[/\\\\]\\.eunit$" "[/\\\\]node_modules$" "[/\\\\]\\.fslckout$" "[/\\\\]\\.tox$" "[/\\\\]\\.stack-work$" "[/\\\\]\\.bloop$" "[/\\\\]\\.metals$" "[/\\\\]target$" "[/\\\\]\\.deps$" "[/\\\\]build-aux$" "[/\\\\]autom4te.cache$" "[/\\\\]\\.reference$" "[/\\\\]\\deployment\\target"))
 '(lsp-file-watch-threshold nil)
 '(lsp-imenu-sort-methods '(kind position))
 '(lsp-java-completion-import-order ["com" "org" "javax" "java" "static"])
 '(lsp-java-format-enabled nil)
 '(lsp-java-max-concurrent-builds 4)
 '(lsp-java-progress-reports-enabled nil)
 '(lsp-java-save-action-organize-imports nil)
 '(lsp-java-update-build-configuration 'interactive)
 '(lsp-java-vmargs
   '("-noverify" "-Xmx3G" "-XX:+UseG1GC" "-XX:+UseStringDeduplication"))
 '(lsp-response-timeout 20)
 '(lsp-ui-doc-include-signature t)
 '(lsp-ui-doc-use-webkit t)
 '(lsp-ui-peek-always-show t)
 '(lsp-ui-peek-peek-height 30)
 '(mac-right-option-modifier 'control)
 '(magit-blame-goto-chunk-hook nil)
 '(magit-log-arguments '("-n32" "--stat"))
 '(magit-log-margin '(t "%Y-%m-%d %H:%M " magit-log-margin-width t 18))
 '(magit-log-section-commit-count 0)
 '(make-backup-files nil)
 '(maple-imenu-auto-update t)
 '(maple-imenu-display-alist '((side . left) (slot . 2)))
 '(maple-imenu-width 30)
 '(max-specpdl-size 13000)
 '(menu-bar-mode nil)
 '(mode-require-final-newline nil)
 '(moo-select-method 'helm)
 '(mouse-drag-and-drop-region t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount '(3 ((shift) . 1) ((control))))
 '(neo-autorefresh t)
 '(neo-show-hidden-files t)
 '(neo-smart-open t)
 '(neo-theme 'icons)
 '(neo-vc-integration '(face char))
 '(neo-window-width 50)
 '(ns-right-alternate-modifier 'control)
 '(nxml-child-indent 4)
 '(org-default-notes-file "~/.emacs.d/.notes")
 '(org-directory "~/.emacs.d/org")
 '(org-download-screenshot-method "convert clipboard: %s")
 '(org-image-actual-width '(500))
 '(org-imenu-depth 4)
 '(org-log-done 'time)
 '(org-src-fontify-natively t)
 '(org-support-shift-select t)
 '(package-selected-packages '(json-mode))
 '(password-cache-expiry nil)
 '(pcmpl-gnu-tarfile-regexp "")
 '(powerline-default-separator 'box)
 '(powerline-gui-use-vcs-glyph t)
 '(proced-filter 'emacs)
 '(proced-format 'medium)
 '(proced-tree-flag t)
 '(properties-unicode-escape-uppercase t)
 '(recentf-auto-cleanup 600)
 '(regexp-search-ring-max 50)
 '(rg-custom-type-aliases nil)
 '(rg-show-header nil)
 '(save-place t nil (saveplace))
 '(semantic-c-dependency-system-include-path
   '("G:/vs2017/VC/Tools/MSVC/14.15.26726/ATLMFC/include" "G:/vs2017/VC/Tools/MSVC/14.15.26726/include" "C:/Program Files (x86)/Windows Kits/NETFXSDK/4.6.1/include/um" "C:/Program Files (x86)/Windows Kits/10/include/10.0.17134.0/ucrt"))
 '(semantic-idle-scheduler-idle-time 5)
 '(semantic-idle-scheduler-work-idle-time 600)
 '(semantic-symref-results-summary-function 'semantic-format-tag-abbreviate)
 '(semanticdb-default-save-directory "d:/semanticdb")
 '(shell-completion-execonly nil)
 '(show-paren-mode t)
 '(show-paren-when-point-in-periphery t)
 '(show-paren-when-point-inside-paren t)
 '(size-indication-mode t)
 '(snails-default-backends
   '(snails-backend-awesome-tab-group snails-backend-buffer snails-backend-recentf snails-backend-bookmark snails-backend-rg snails-backend-projectile snails-backend-imenu))
 '(sp-base-key-bindings 'sp)
 '(switch-window-shortcut-style ''qwerty)
 '(tab-width 4)
 '(tabbar-show-key-bindings nil)
 '(tool-bar-mode nil)
 '(treemacs-collapse-dirs 3)
 '(treemacs-show-cursor t)
 '(treemacs-tag-follow-cleanup nil)
 '(treemacs-width 50)
 '(undo-outer-limit 20000000)
 '(uniquify-buffer-name-style 'post-forward-angle-brackets nil (uniquify))
 '(user-full-name "gezijian")
 '(vc-handled-backends '(Git SVN))
 '(vc-svn-program "C:\\Program Files\\TortoiseSVN\\bin\\svn")
 '(vlf-batch-size 50000000)
 '(which-function-mode t)
 '(whitespace-line-column 120)
 '(winner-mode t)
 '(xref-prompt-for-identifier
   '(not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-find-references))
 '(yas-also-auto-indent-first-line t))

;;-----------------------------------------------------------plugin begin-----------------------------------------------------------;;
;; gtags
(setq gtags-suggested-key-mapping nil)
(setq gtags-disable-pushy-mouse-mapping t)
(autoload 'gtags-mode "gtags" nil t)
(eval-after-load "gtags"
  '(progn
     ;; (define-key gtags-mode-map [C-down-mouse-1] 'ignore)
     ;; (define-key gtags-mode-map [C-down-mouse-3] 'ignore)
     (remove-hook 'after-save-hook 'gtags-auto-update)
     (define-key gtags-mode-map [mouse-3] 'ignore)
     (define-key gtags-mode-map [mouse-2] 'gtags-find-tag-by-event)
     (define-key gtags-mode-map (kbd "<M-mouse-3>") 'gtags-pop-stack)
     (define-key gtags-mode-map (kbd "<mouse-3>") 'gtags-pop-stack)
     (define-key gtags-mode-map (kbd "<M-mouse-1>") 'gtags-find-tag-by-event)
     (define-key gtags-mode-map (kbd "C-c i") 'gtags-find-with-idutils)
     (define-key gtags-select-mode-map "p" 'previous-line)
     (define-key gtags-select-mode-map "n" 'next-line)
     (define-key gtags-select-mode-map "q" 'gtags-pop-stack)
     ;; (define-key gtags-select-mode-map [C-down-mouse-3] 'ignore)
     (define-key gtags-select-mode-map [mouse-3] 'ignore)
     ;; (define-key gtags-select-mode-map [C-down-mouse-1] 'ignore)
     (define-key gtags-select-mode-map [mouse-2] 'gtags-select-tag-by-event)
     (define-key gtags-select-mode-map (kbd "<M-mouse-3>") 'gtags-pop-stack)
     ;; (define-key gtags-select-mode-map (kbd "<mouse-3>") 'gtags-pop-stack)
     (define-key gtags-select-mode-map (kbd "<M-mouse-1>") 'gtags-select-tag-by-event)
     ))

;; 选中单位
(autoload 'er/expand-region "expand-region" nil t)
(global-set-key (kbd "M-s") 'er/expand-region)

;; undo redo
(require 'redo+)
(setq undo-no-redo t)
(global-set-key (kbd "C-/") 'redo)
(global-set-key (kbd "C-S-z") 'redo)
(global-set-key (kbd "C-z") 'undo)

;; stl(解析vector map等)
(setq stl-base-dir-14 "c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include")
(setq vs-dir "c:/Program Files (x86)/Microsoft Visual Studio/2019/Community/VC/Tools/MSVC/14.23.28105/include")


;; 设置成c++文件类型
(add-to-list 'auto-mode-alist (cons stl-base-dir-14 'c++-mode))
(add-to-list 'auto-mode-alist (cons vs-dir 'c++-mode))

;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

;; company
(autoload 'company-mode "company" nil t)
(autoload 'global-company-mode "company" nil t)

(eval-after-load "company"
  '(progn
     ;; 智能补全 tabnine ,exe的下载用company-tabnine-install-binary，
     ;; 如果下不下来可以通过IJ的Plugin安装tabnine插件后，搜到TabNine.exe并将整个.tabnine文件夹移到\Roaming目录下
     (require 'company-tabnine)
     ;; (add-to-list 'company-backends #'company-tabnine)
     ;; Trigger completion immediately.
     ;; (setq company-idle-delay 0)
     ;; Number the candidates (use M-1, M-2 etc to select completions).
     (setq company-show-numbers t)
     ;; workaround for company-transformers
     (setq company-tabnine--disable-next-transform nil)
     (defun my-company--transform-candidates (func &rest args)
       (if (not company-tabnine--disable-next-transform)
           (apply func args)
         (setq company-tabnine--disable-next-transform nil)
         (car args)))

     (defun my-company-tabnine (func &rest args)
       (when (eq (car args) 'candidates)
         (setq company-tabnine--disable-next-transform t))
       (apply func args))

     (advice-add #'company--transform-candidates :around #'my-company--transform-candidates)
     (advice-add #'company-tabnine :around #'my-company-tabnine)

     ;; (require 'company-box)
     ;; (add-hook 'company-mode-hook 'company-box-mode)
     (setq company-async-timeout 15)
     (global-set-key (kbd "<S-return>") 'company-complete)

     ;; (push '(company-capf :with company-semantic :with company-yasnippet :with company-dabbrev-code) company-backends)
     (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
     (define-key company-active-map (kbd "M-s") 'company-filter-candidates)
     (defun toggle-company-complete-id (&optional args)
       (interactive "P")
       (message "company complete id afte %s char" args)
       (if args
           (setq-local company-minimum-prefix-length args)
         (progn
           (if (eq company-minimum-prefix-length 99)
               (progn
                 (setq-local company-minimum-prefix-length 3))
             (progn
               (setq-local company-minimum-prefix-length 99))))
         ))
     ))

;;yasnippet 手动开启通过 yas-global-mode，会自动加载资源，如果执行yas-minor-mode，还需要执行yas-reload-all加载资源
(autoload 'yas-global-mode "yasnippet" nil t)
(autoload 'yas-minor-mode "yasnippet" nil t)

;; 前进、后退
(require 'recent-jump-small)
(setq rjs-mode-line-format nil)
(recent-jump-small-mode)
(global-set-key (kbd "<M-left>") 'recent-jump-small-backward)
(global-set-key (kbd "<M-right>") 'recent-jump-small-forward)

;; (add-to-list 'rjs-command-ignore 'mwheel-scroll)
(add-to-list 'rjs-command-ignore 'mouse-drag-region)

(defvar rjs-command-ignore-last
  '(recent-jump-backward
    recent-jump-forward
    recent-jump-small-backward
    recent-jump-small-forward
    mwheel-scroll
    mouse-drag-region))

(defun is-mwheeling()
  (and (eq last-command 'mwheel-scroll) (eq this-command 'mwheel-scroll)))

(defun uninterested-buffer (buffer &optional all)
  (if all
      (or (eq (buffer-local-value 'major-mode buffer) 'dired-mode)
          (string-match-p "\*" (buffer-name buffer)))
    (or (eq (buffer-local-value 'major-mode buffer) 'ag-mode)
        (eq (buffer-local-value 'major-mode buffer) 'semantic-symref-results-mode)
        (eq (buffer-local-value 'major-mode buffer) 'diff-mode)
        (eq (buffer-local-value 'major-mode buffer) 'vc-dir-mode)
        (eq (buffer-local-value 'major-mode buffer) 'vc-svn-log-view-mode)
        (eq (buffer-local-value 'major-mode buffer) 'ediff-meta-mode)
        (eq (buffer-local-value 'major-mode buffer) 'occur-mode)
        (eq (buffer-local-value 'major-mode buffer) 'Custom-mode)
        (eq (buffer-local-value 'major-mode buffer) 'help-mode)
        (string-match-p "ag dired pattern" (buffer-name buffer))
        (string-match-p "\*vc\*" (buffer-name buffer))
        (string-match-p "\*Backtrace\*" (buffer-name buffer))
        (string-match-p "\*Completions\*" (buffer-name buffer))
        (string-match-p "\*Cedet\*" (buffer-name buffer))
        (string-match-p "\*Annotate\*" (buffer-name buffer))
        (string-match-p "\*Compile-Log\*" (buffer-name buffer))
        (string-match-p "\*GTAGS SELECT\*" (buffer-name buffer))
        (string-match-p "\*Calc\*" (buffer-name buffer))
        (string-match-p "\*magit" (buffer-name buffer))
        (string-match-p "Ilist" (buffer-name buffer))
        (string-match-p "log-edit-files" (buffer-name buffer))
        (string-match-p "\*Helm" (buffer-name buffer))
        (string-match-p "\*Bookmark List\*" (buffer-name buffer))
        (string-match-p "screenshot*" (buffer-name buffer))
        )))

(defun rjs-pre-command-fset ()
  "每个命令执行前执行这个函数"
  (unless (or (active-minibuffer-window) isearch-mode (uninterested-buffer (current-buffer) t) (is-mwheeling))
    (unless (memq this-command rjs-command-ignore)
      (let ((position (list (buffer-file-name) (current-buffer) (point))))
        ;; (princ (format " this %S pos:%S" this-command position))
        (unless rjs-position-before
          (setq rjs-position-before position))
        (setq rjs-position-pre-command position))
      (if (memq last-command '(recent-jump-small-backward recent-jump-small-forward))
          (progn
            (let ((index (1- rjs-index)) (list nil))
              (while (> index 0)
                (push (ring-ref rjs-ring index) list)
                (setq index (1- index)))
              (while list
                (ring-insert rjs-ring (car list))
                (pop list))))))))


(defun rjs-post-command-fset ()
  "每个命令执行后执行这个函数"
  (unless (or (active-minibuffer-window) isearch-mode (uninterested-buffer (current-buffer) t) (is-mwheeling))
    (unless (memq this-command rjs-command-ignore)
      (let ((position (list (buffer-file-name) (current-buffer) (point))))
        ;; (princ (format " last %S this %S pos:%S pre:%S before:%S" last-command this-command position rjs-position-pre-command rjs-position-before))
        (if (eq this-command 'mwheel-scroll)
            (rj-insert-point rjs-ring position))
        (if (or (and rjs-position-pre-command
                     (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold rjs-position-pre-command position rjs-position-pre-command))
                (and rjs-position-before
                     (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold rjs-position-before position rjs-position-before)))
            (setq rjs-position-before nil)))))
  (setq rjs-position-pre-command nil))

(defun recent-jump-small-backward-fset (arg)
  "跳到命令执行前的位置"
  (interactive "p")
  (let ((index rjs-index)
        (last-is-rjs (memq last-command '(recent-jump-small-backward recent-jump-small-forward))))
    (if (ring-empty-p rjs-ring)
        (message (if (> arg 0) "Can't backward, ring is empty" "Can't forward, ring is empty"))
      (if last-is-rjs
          (setq index (+ index arg))
        (setq index arg)
        (unless (uninterested-buffer (current-buffer) t)
          (unless (memq last-command rjs-command-ignore-last)
            (let ((position (list (buffer-file-name) (current-buffer) (point))))
              (setq rj-position-before nil)
              (unless (rj-insert-big-jump-point rjs-ring rjs-line-threshold rjs-column-threshold (ring-ref rjs-ring 0) position)
                (ring-remove rjs-ring 0)
                (ring-insert rjs-ring position))))))
      (if (>= index (ring-length rjs-ring))
          (message "Can't backward, reach bottom of ring")
        (if (<= index -1)
            (message "Can't forward, reach top of ring")
          (let* ((position (ring-ref rjs-ring index))
                 (file (nth 0 position))
                 (buffer (nth 1 position)))
            (if (not (or file (buffer-live-p buffer)))
                (progn
                  (ring-remove rjs-ring index)
                  (message "要跳转的位置所在的buffer为无文件关联buffer, 但该buffer已被删除"))
              (if file
                  (find-file (nth 0 position))
                (assert (buffer-live-p buffer))
                (switch-to-buffer (nth 1 position)))
              (goto-char (nth 2 position))
              (setq rjs-index index))))))))

(fset 'rjs-pre-command 'rjs-pre-command-fset)
(fset 'rjs-post-command 'rjs-post-command-fset)
(fset 'recent-jump-small-backward 'recent-jump-small-backward-fset)

;; bookmark
(autoload 'bm-toggle   "bm" "Toggle bookmark in current buffer." t)
(autoload 'bm-next     "bm" "Goto bookmark."                     t)
(autoload 'bm-previous "bm" "Goto previous bookmark."            t)
(autoload 'bm-toggle-cycle-all-buffers "bm" nil  t)

(global-set-key (kbd "<C-f2>") 'bm-toggle)
(global-set-key (kbd "<f2>")   'bm-next)
(global-set-key (kbd "<S-f2>") 'bm-previous)
(setq bm-cycle-all-buffers t)
(defface bm-face
  '((((class grayscale)
      (background light)) (:background "DimGray"))
    (((class grayscale)
      (background dark))  (:background "LightGray"))
    (((class color)
      (background light)) (:background "peach puff"))
    (((class color)
      (background dark))  (:background "dark slate gray")))
  "Face used to highlight current line."
  :group 'bm)

;; 显示列竖线
(autoload 'fci-mode "fill-column-indicator" "" t)
(global-set-key (kbd "C-:") 'fci-mode)
(setq fci-rule-column 120)

(eval-after-load "fill-column-indicator"
  '(progn
     ;; 避免破坏 auto complete
     (defun sanityinc/fci-enabled-p () (symbol-value 'fci-mode))

     (defvar sanityinc/fci-mode-suppressed nil)
     (make-variable-buffer-local 'sanityinc/fci-mode-suppressed)

     (defadvice popup-create (before suppress-fci-mode activate)
       "Suspend fci-mode while popups are visible"
       (let ((fci-enabled (sanityinc/fci-enabled-p)))
         (when fci-enabled
           (setq sanityinc/fci-mode-suppressed fci-enabled)
           (turn-off-fci-mode))))

     (defadvice popup-delete (after restore-fci-mode activate)
       "Restore fci-mode when all popups have closed"
       (when (and sanityinc/fci-mode-suppressed
                  (null popup-instances))
         (setq sanityinc/fci-mode-suppressed nil)
         (turn-on-fci-mode)))

     ;; 避免和company冲突
     (defvar-local company-fci-mode-on-p nil)

     (defun company-turn-off-fci (&rest ignore)
       (when (boundp 'fci-mode)
         (setq company-fci-mode-on-p fci-mode)
         (when fci-mode (fci-mode -1))))

     (defun company-maybe-turn-on-fci (&rest ignore)
       (when company-fci-mode-on-p (fci-mode 1)))

     (add-hook 'company-completion-started-hook 'company-turn-off-fci)
     (add-hook 'company-completion-finished-hook 'company-maybe-turn-on-fci)
     (add-hook 'company-completion-cancelled-hook 'company-maybe-turn-on-fci)
     ))
;; 异步copy rename文件
(autoload 'dired-async-mode "dired-async.el" nil t)

;; helm系列
;; C-c 1/2/3... C-x 1/2/3 是直接选中离当前行第几个candi C-c是往下数，C-x是往上数，省的上下移动
;; C-@ 是标记文件
(autoload 'helm-mode "helm-config" nil t) ;开启helm-mode时要先关闭ido-mode否则不生效
(autoload 'helm-show-kill-ring "helm-config" nil t)
(autoload 'helm-semantic-or-imenu "helm-config" nil t)
(autoload 'helm-for-files "helm-config" nil t)
(autoload 'helm-resume "helm-config" nil t)
(autoload 'helm-M-x "helm-config" nil t)
(autoload 'helm-find-files "helm-config" nil t)
(autoload 'helm-locate "helm-config" nil t)

(autoload 'helm-occur "helm-config" nil t)
(autoload 'helm-ag-this-file "helm-ag" nil t)
(autoload 'helm-ag-project-root "helm-ag" nil t)
(autoload 'helm-ag-buffers "helm-ag" nil t)
(global-set-key (kbd "C-S-f") 'helm-ag-project-root) ;<C-down> and <C-up> 上下移动预览，即helm-follow-mode
(global-set-key (kbd "C-S-b") 'helm-ag-buffers) ;<C-down> and <C-up> 上下移动预览，即helm-follow-mode

(autoload 'helm-org-in-buffer-headings "helm-config" nil t) ;在org-mode中找标题很方便

(autoload 'helm-gtags-mode "helm-gtags" nil t)
(autoload 'helm-gtags-select "helm-gtags" nil t)
(autoload 'helm-gtags-select-path "helm-gtags" nil t)
(autoload 'helm-gtags-find-tag "helm-gtags" nil t)
(autoload 'helm-gtags-find-files "helm-gtags" nil t)
(autoload 'helm-gtags-create-tags "helm-gtags" nil t)
(autoload 'helm-gtags-update-tags "helm-gtags" nil t)
(autoload 'helm-gtags-dwim "helm-gtags" nil t)
(autoload 'helm-gtags-find-rtag "helm-gtags" nil t)

(defun toggle-helm-key ()
  ""
  (interactive)
  (if helm-mode
      (progn
        (message "helm mode t")
        ;; (define-key global-map [remap find-files] 'helm-find-files)
        (define-key global-map [remap execute-extended-command] 'helm-M-x)
        (define-key global-map [remap switch-to-buffer] 'helm-buffers-list)
        ;; (define-key global-map [remap bookmark-jump] 'helm-filtered-bookmarks)
        )
    (progn
      (message "helm mode nil")
      ;; (define-key global-map [remap find-files] nil)
      (define-key global-map [remap execute-extended-command] nil)
      (define-key global-map [remap switch-to-buffer] nil)
      (define-key global-map [remap bookmark-jump] nil))
    ))

(global-set-key (kbd "M-g k") 'toggle-helm-key)

(defadvice helm-mode (after helm-mode-af activate)
  ""
  (toggle-helm-key))

(with-eval-after-load 'helm-mode
  (ido-mode nil))

(with-eval-after-load 'helm
  ;; helm-mode中删除文件M-D注意是大D，或者C-c d删除但是不离开helm
  ;; (helm-mode 1)
  ;; helm-browse-project 或者helm-ls-git-ls或者c-x c-f后c-x c-d可以查看当前目录下所有git文件
  (require 'helm-ls-git)
  (global-set-key (kbd "C-x C-d") 'helm-browse-project)

  (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
  (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
  (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
  (define-key helm-map (kbd "<f12>") 'helm-buffer-run-kill-buffers) ;默认是M-D, M-spc是mark, M-a是全选， M-m是toggle mark
  ;; helm-locate设置 C-x c l
  (when (memq system-type '(windows-nt ms-dos))
    (setq helm-locate-command "es %s -sort run-count %s") ;增加排序功能
    (defun helm-es-hook ()
      (when (and (equal (assoc-default 'name (helm-get-current-source)) "Locate")
                 (string-match "\\`es" helm-locate-command))
        (mapc (lambda (file)
                (call-process "es" nil nil nil
                              "-inc-run-count" (convert-standard-filename file)))
              (helm-marked-candidates))))
    (add-hook 'helm-find-many-files-after-hook 'helm-es-hook))
  (when (eq system-type 'darwin)
    (setq helm-locate-fuzzy-match nil)
    (setq helm-locate-command "mdfind -name %s %s") ;结果与mdfind不完全一致，counsel-locate没问题
    )
  )

(eval-after-load "helm-files"
  '(progn
     (define-key helm-find-files-map (kbd "<C-backspace>") 'backward-kill-word)
     (define-key helm-read-file-map (kbd "<C-backspace>") 'backward-kill-word)
     ))

(global-set-key (kbd "<C-f10>") 'helm-locate)
;; (global-set-key (kbd "<f9>") 'helm-occur)
(global-set-key (kbd "C-S-k") 'helm-all-mark-rings)
(global-set-key (kbd "C-S-v") 'helm-show-kill-ring)
(global-set-key (kbd "<apps>") 'helm-semantic-or-imenu)
(global-set-key (kbd "<C-apps>") 'helm-for-files)
(global-set-key (kbd "<C-f7>") 'helm-for-files)
(global-set-key (kbd "<S-apps>") 'helm-resume) ;C-x c b默认
(global-set-key (kbd "<C-M-f6>") 'helm-ls-git-ls)
(global-set-key (kbd "C-S-g")  (lambda () "" (interactive)
                                      (helm-grep-do-git-grep t))) ;默认是搜当前目录，加上c-u是搜整个repo

(autoload 'helm-grep-do-git-grep "helm-grep" nil t)
(autoload 'helm-ls-git-ls "helm-ls-git" nil t)
(autoload 'helm-swoop "helm-swoop" nil t)
(autoload 'helm-swoop-from-isearch "helm-swoop" nil t)
(autoload 'helm-multi-swoop-all "helm-swoop" nil t) ;搜索所有buffer，或者用helm-multi-swoop然后mark要搜索的buffer ，或者helm-multi-swoop-projectile搜索所有当前工程打开的buffer
(global-set-key (kbd "<f9>") 'helm-swoop)
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
(define-key isearch-mode-map (kbd "<f9>") 'helm-swoop-from-isearch)
(setq helm-swoop-split-with-multiple-windows t)

(global-set-key (kbd "C-c j") 'helm-ag-this-file)
(global-set-key (kbd "M-X") 'helm-M-x)
(global-set-key (kbd "C-x f") 'helm-find-files)

(autoload 'helm-rg "helm-rg" nil t)

(global-set-key (kbd "C-c b") 'helm-gtags-find-files)
(global-set-key (kbd "C-c d") 'helm-gtags-find-tag);要在空白处使用才能输入，否则是查找光标下的符号
;; (global-set-key (kbd "C-c B") 'gtags-find-file)
(global-set-key (kbd "<f6>") 'helm-gtags-select-path)
(global-set-key (kbd "<f7>") 'helm-gtags-select)
(global-set-key (kbd "<S-f5>") 'helm-gtags-create-tags) ;可以指定路径和label
(global-set-key (kbd "<f5>") 'helm-gtags-update-tags) ;c-u 全局刷新 ，c-u c-u 创建
(global-set-key (kbd "C-\\") 'helm-gtags-dwim)
(global-set-key (kbd "C-c r") 'helm-gtags-find-rtag)

(eval-after-load "helm-gtags"
  '(progn
     (gtags-mode 1)
     (remove-hook 'after-save-hook 'gtags-auto-update)
     (helm-gtags-mode 1)
     (add-hook 'c-mode-common-hook
               (lambda ()
                 (gtags-mode 1)
                 (helm-gtags-mode 1)))
     (define-key helm-gtags-mode-map (kbd "C-]") nil)
     (define-key helm-gtags-mode-map (kbd "C-t") nil)
     (define-key helm-gtags-mode-map (kbd "M-*") nil)
     (define-key helm-gtags-mode-map (kbd "M-,") nil)
     (define-key helm-gtags-mode-map (kbd "M-.") nil)
     (define-key helm-gtags-mode-map (kbd "C-c t") nil)
     (define-key helm-gtags-mode-map (kbd "C-c s") 'helm-gtags-find-symbol)
     (define-key helm-gtags-mode-map (kbd "C-c r") 'helm-gtags-find-rtag)
     (define-key helm-gtags-mode-map (kbd "C-c f") 'helm-gtags-parse-file)
     (define-key helm-gtags-mode-map (kbd "C-c g") 'helm-gtags-find-pattern)
     (define-key helm-gtags-mode-map (kbd "C-\\") 'helm-gtags-dwim)
     (define-key helm-gtags-mode-map (kbd "C-|") 'helm-gtags-find-tag-other-window)
     ;; (define-key helm-gtags-mode-map (kbd "C-M-,") 'helm-gtags-show-stack)
     ))

;; flycheck
;; (defvar package-user-dir "")			;防止check lisp出错
(autoload 'flycheck-mode "flycheck" nil t)
(autoload 'global-flycheck-mode "flycheck" nil t)
(with-eval-after-load 'flycheck
  ;; (setq flycheck-global-modes (quote (not nxml-mode)))
  ;; (add-hook 'sh-mode-hook (lambda ()
  ;;                              (setq flycheck-checker 'sh-posix-bash)))
  )

(global-set-key (kbd "M-g l") 'flycheck-list-errors)
(global-set-key (kbd "<M-f5>") (lambda () "" (interactive)
                                 (require 'flycheck)
                                 (unless flycheck-mode (flycheck-mode 1))
                                 (flycheck-buffer)
                                 ))

;; 行号性能改善
(autoload 'nlinum-mode "nlinum" nil t)
(autoload 'global-nlinum-mode "nlinum" nil t)
;; (global-nlinum-mode 1)
;; Preset `nlinum-format' for minimum width.
(defun my-nlinum-mode-hook ()
  (when nlinum-mode
    (setq-local nlinum-format
                (concat "%" (number-to-string
                             ;; Guesstimate number of buffer lines.
                             (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
                        "d"))))
(add-hook 'nlinum-mode-hook #'my-nlinum-mode-hook)
;; 避免 “ERROR: Invalid face: linum” error
(defun initialize-nlinum (&optional frame)
  (require 'nlinum)
  (add-hook 'prog-mode-hook 'nlinum-mode))
(when (daemonp)
  (add-hook 'window-setup-hook 'initialize-nlinum)
  (defadvice make-frame (around toggle-nlinum-mode compile activate)
    (nlinum-mode -1) ad-do-it (nlinum-mode 1)))

;; lua mode
(autoload 'lua-mode "lua-mode" "Lua editing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

;; markdown mode (markdown-live-preview-mode 直接在emacs里预览)
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
  "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))

;; 打开大文件
(require 'vlf-setup)
(eval-after-load "vlf"
  '(progn
     (setq vlf-tune-enabled 'stats)
     (define-key vlf-prefix-map (kbd "C-c j") vlf-mode-map)))

(defadvice vlf (after vlf-after activate)
  ""
  (remove-dos-eol)
  ;; (nlinum-mode 1)
  (anzu-mode 1))

;; ace
(with-eval-after-load 'cua-base
  (define-key cua--cua-keys-keymap [(meta v)] nil))
(autoload 'ace-window "ace-window" nil t)
;; (autoload 'ace-jump-char-mode "ace-jump-mode" nil t)
(autoload 'avy-goto-line "avy" nil t)
(autoload 'avy-goto-char "avy" nil t)
(autoload 'avy-goto-char-timer "avy" nil t)

(eval-after-load "ace-window"
  '(progn
     (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))

;; (eval-after-load "ace-jump-mode"
;;   '(progn
;;      (setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i))))

(eval-after-load "avy"
  '(progn
     ;; (avy-setup-default)
     (setq avy-keys (loop for i from ?a to ?z collect i))
     (eval-after-load "isearch"
       '(define-key isearch-mode-map (kbd "M-;") 'avy-isearch))
     (global-set-key (kbd "C-c C-j") 'avy-resume)))

(global-set-key (kbd "M-g M-g") 'avy-goto-line)
(global-set-key (kbd "M-j") 'avy-goto-char)
(global-set-key (kbd "M-g j") 'avy-goto-char-timer)

(global-set-key (kbd "M-v") 'ace-window) ;翻页用page up代替
;; (global-set-key (kbd "M-g j") 'ace-jump-char-mode)


;; 查看diff
;; smartrep，会跟doom-modeline冲突，但是有smartrep，按键会方便
;; (require 'diff-hl-margin )
;; (global-diff-hl-mode)
(autoload 'diff-hl-dired-mode "diff-hl-dired" nil t)
(autoload 'global-diff-hl-mode "diff-hl-margin" nil t)
(autoload 'diff-hl-mode "diff-hl" nil t)
(autoload 'turn-on-diff-hl-mode "diff-hl" nil t)
(autoload 'diff-hl-flydiff-mode "diff-hl-flydiff" nil t)
(autoload 'diff-hl-next-hunk "diff-hl" nil t)
(autoload 'diff-hl-previous-hunk "diff-hl" nil t)

(global-set-key (kbd "<C-M-S-down>") 'diff-hl-next-hunk)
(global-set-key (kbd "<C-M-S-up>") 'diff-hl-previous-hunk)

;; (diff-hl-flydiff-mode 1)
;; (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
;; (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
(eval-after-load "diff-hl"
  '(progn
     (require 'diff-hl-margin)
     (diff-hl-margin-mode t)
     (setq vc-git-diff-switches '("--histogram"))
     (defun diff-hl-changes-fset ()
       (let* ((file buffer-file-name)
              (backend (vc-backend file)))
         (when backend
           (let ((state (cond
                         ((eq 'SVN backend) (vc-svn-state file))
                         ((eq 'Git backend) (vc-git-state file))
                         (t (vc-state file backend))
                         )))
             (cond
              ((diff-hl-modified-p state)
               (let* (diff-auto-refine-mode res)
                 (with-current-buffer (diff-hl-changes-buffer file backend)
                   (goto-char (point-min))
                   (unless (eobp)
                     (ignore-errors
                       (diff-beginning-of-hunk t))
                     (while (looking-at diff-hunk-header-re-unified)
                       (let ((line (string-to-number (match-string 3)))
                             (len (let ((m (match-string 4)))
                                    (if m (string-to-number m) 1)))
                             (beg (point)))
                         (diff-end-of-hunk)
                         (let* ((inserts (diff-count-matches "^\\+" beg (point)))
                                (deletes (diff-count-matches "^-" beg (point)))
                                (type (cond ((zerop deletes) 'insert)
                                            ((zerop inserts) 'delete)
                                            (t 'change))))
                           (when (eq type 'delete)
                             (setq len 1)
                             (cl-incf line))
                           (push (list line len type) res))))))
                 (nreverse res)))
              ((eq state 'added)
               `((1 ,(line-number-at-pos (point-max)) insert)))
              ((eq state 'removed)
               `((1 ,(line-number-at-pos (point-max)) delete))))))))
     (fset 'diff-hl-changes 'diff-hl-changes-fset)
     ))

;; 删除自带的git支持，在触发相关命令时再打开
(defun toggle-git-backend ()            ;文件要先打开git back后再执行vc命令，否则会报找不到vc-nil
  "docstring"
  (interactive)
  (if (memq 'Git vc-handled-backends)
      (setq vc-handled-backends (delq 'Git vc-handled-backends))
    (progn (add-to-list 'vc-handled-backends 'Git)
           (cond ((eq major-mode 'dired-mode)
                  (revert-buffer))
                 ((and (not (eq major-mode 'vc-dir-mode))
                       ;; (not (vc-backend buffer-file-name))
                       )
                  (reopen-file))))))
(global-set-key (kbd "M-g h") 'toggle-git-backend)
;; (when (memq system-type '(windows-nt ms-dos))
;;  (toggle-git-backend))
;; wgrep
(autoload 'wgrep-setup "wgrep")
(add-hook 'grep-setup-hook 'wgrep-setup)
(setq wgrep-enable-key "r")

(autoload 'wgrep-pt-setup "wgrep-pt")
(add-hook 'pt-search-mode-hook 'wgrep-pt-setup)

;; pt
(autoload 'pt-regexp "pt" nil t)

;; rg
(autoload 'rg "rg" nil t)               ;搜索的结果按s保存，然后rg-list-searches可以列出所有结果，里面有搜索的关键字,目录
(autoload 'rg-project "rg" nil t)       ;代替ag-project
(autoload 'rg-dwim "rg" nil t)       ;直接在project搜索光标下的symbol，并且不用指定类型
;; 搜索模式如下
(defun rg-rerun-toggle-word ()
  ""
  (interactive)
  (rg-rerun-toggle-flag "-w"))
(with-eval-after-load 'rg
  (define-key rg-mode-map "o" 'rg-rerun-toggle-word))
;;     (define-key map "c" 'rg-rerun-toggle-case)
;;     (define-key map "i" 'rg-rerun-toggle-ignore)
;;     (define-key map "r" 'rg-rerun-change-regexp)
;;     (define-key map "t" 'rg-rerun-change-literal)
(global-set-key (kbd "<C-f5>") 'rg-project) ;counsel-git-grep 也好用，projectile-ag完全等价


;; fast silver searcher
(autoload 'my-ag "ag" nil t)
(autoload 'ag-this-file "ag" nil t)
(autoload 'ag-dired "ag" nil t)
(autoload 'ag-dired-regexp "ag" nil t)
(autoload 'ag-project "ag" nil t)

(global-set-key (kbd "<M-f9>") 'ag-this-file)
(global-set-key (kbd "<C-f9>") 'my-ag)
;; (global-set-key (kbd "C-S-f") 'ag-project) ;counsel-git-grep 也好用，projectile-ag完全等价， helm-ag-project-root
;; (global-set-key (kbd "<S-f6>") 'vc-git-grep) ;速度最快,区分大小写
(global-set-key (kbd "<S-f9>") 'ag-dired)
;; C-c C-k 停止ag-dired

(autoload 'wgrep-ag-setup "wgrep-ag")
(add-hook 'ag-mode-hook 'wgrep-ag-setup)

(eval-after-load "ag"
  '(progn
     (require 'grep )
     (defun my-ag (string directory)
       ""
       (interactive (list (grep-read-regexp)
                          (read-directory-name "Directory: ")))
       (ag/search string directory))

     (defun my-ag-project (string)
       ""
       (interactive (list (grep-read-regexp)))
       (ag/search string (ag/project-root default-directory)))

     (defun ag-this-file (string file-regex directory)
       ""
       (interactive (list (grep-read-regexp)
                          (setq file-regex (list :file-regex
                                                 (concat "/" (file-name-nondirectory (buffer-file-name) ) "$")))
                          (setq directory default-directory)))
       (setq arg-bak ag-arguments)
       (add-to-list 'ag-arguments "-u")
       (apply #'ag/search string directory file-regex)
       (setq ag-arguments arg-bak))

     (defun ag/kill-process-fset ()
       ""
       (interactive)
       (let ((ag (get-buffer-process (current-buffer))))
         (and ag (eq (process-status ag) 'run)
              ;; (eq (process-filter ag) (function find-dired-filter))
              (condition-case nil
                  (delete-process ag)
                (error nil)))))
     (fset 'ag/kill-process 'ag/kill-process-fset)

     (defun ag-dired-regexp-fset (dir regexp)
       ""
       (interactive "DDirectory: \nsFile regexp: ")
       (let* ((dired-buffers dired-buffers) ;; do not mess with regular dired buffers
              (orig-dir dir)
              (dir (file-name-as-directory (expand-file-name dir)))
              (buffer-name (if ag-reuse-buffers
                               "*ag dired*"
                             (format "*ag dired pattern:%s dir:%s*" regexp dir)))
              (cmd (concat ag-executable " --nocolor -ui -g \"" regexp "\" "
                           (shell-quote-argument dir)
                           " | grep -v \"^$\" | sed 's:\\\\:\\\\\\\\:g' | xargs -I '{}' ls "
                           dired-listing-switches " '{}' &")))
         (with-current-buffer (get-buffer-create buffer-name)
           (switch-to-buffer (current-buffer))
           (widen)
           (kill-all-local-variables)
           (if (fboundp 'read-only-mode)
               (read-only-mode -1)
             (setq buffer-read-only nil))
           (let ((inhibit-read-only t)) (erase-buffer))
           (setq default-directory dir)
           (run-hooks 'dired-before-readin-hook)
           (shell-command cmd (current-buffer))
           (insert "  " dir ":\n")
           (insert "  " cmd "\n")
           (dired-mode dir)
           (let ((map (make-sparse-keymap)))
             (set-keymap-parent map (current-local-map))
             (define-key map "\C-c\C-k" 'ag/kill-process)
             (use-local-map map))
           (set (make-local-variable 'dired-sort-inhibit) t)
           (set (make-local-variable 'revert-buffer-function)
                `(lambda (ignore-auto noconfirm)
                   (ag-dired-regexp ,orig-dir ,regexp)))
           (if (fboundp 'dired-simple-subdir-alist)
               (dired-simple-subdir-alist)
             (set (make-local-variable 'dired-subdir-alist)
                  (list (cons default-directory (point-min-marker)))))
           (let ((proc (get-buffer-process (current-buffer))))
             (set-process-filter proc #'ag/dired-filter)
             (set-process-sentinel proc #'ag/dired-sentinel)
             ;; Initialize the process marker; it is used by the filter.
             (move-marker (process-mark proc) 1 (current-buffer)))
           (setq mode-line-process '(":%s")))))

     (fset 'ag-dired-regexp 'ag-dired-regexp-fset)

     (defvar ag-search-cnt 0 "search cnt")
     (defun ag/buffer-name-fset (search-string directory regexp)
       "Return a buffer name formatted according to ag.el conventions."
       (cond
        (ag-reuse-buffers "*ag search*")
        (regexp (format "*ag regexp:%s %d*" search-string (setq ag-search-cnt (1+ ag-search-cnt))))
        (:else (format "*ag:%s %d*" search-string (setq ag-search-cnt (1+ ag-search-cnt))))))
     (fset 'ag/buffer-name 'ag/buffer-name-fset)
     ))

;; magit 确保ssh的ppk正确，换电脑的话要重新生成密钥
(when (memq system-type '(windows-nt ms-dos))
  (setenv "GIT_ASKPASS" "git-gui--askpass") ;解决git push不提示密码的问题
  (setenv "SSH_ASKPASS" "git-gui--askpass")
  ;; (setenv "GIT_SSH" "c:/Program Files/PuTTY/plink.exe") ;遇到弹出POTENTIAL SECURITY BREACH!告警就没法用了
  (setenv "GIT_SSH" "C:/Program Files/TortoiseGit/bin/TortoiseGitPlink.exe");这个安装git for windows时有选项也可以指定，用这个有什么需要点的提示能弹出来，不像plink没法点
  )

;; 要想保存密码不用每次输入得修改.git-credentials和.gitconfig
;; 解决magit和服务器的乱码问题，不需要在.gitconfig中改118n的配置(比如配置成gb2312)
(defun my-git-commit-hook ()
  (set-buffer-file-coding-system 'utf-8-unix))

;; (defun my-git-commit-hook-gbk ()
;;   (set-buffer-file-coding-system 'chinese-gbk-unix))

;; (add-hook 'magit-mode-hook 'my-git-commit-hook)
;; (add-hook 'magit-status-mode-hook 'my-git-commit-hook)
(add-hook 'git-commit-mode-hook 'my-git-commit-hook)
(add-hook 'magit-log-mode-hook
          (lambda ()
            (setq truncate-lines nil)))
;; (add-hook 'magit-revision-mode-hook 'my-git-commit-hook-gbk)

(autoload 'magit-status "magit" nil t)
(autoload 'magit-dispatch-popup "magit" nil t)
(autoload 'magit-blame-addition "magit" nil t)
(autoload 'magit-log-buffer-file "magit" nil t)
(autoload 'magit-clone "magit" nil t)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-x t g") 'magit-blame-addition)
(global-set-key (kbd "C-x t l") 'magit-log-buffer-file)

;; 避免时区差8小时
(eval-after-load "magit"
  '(progn
     (defadvice magit-blame-format-time-string (before magit-blame-format-time-strin-bef activate)
       ""
       (setq tz 0))

     ;; 提高性能
     ;; (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
     ;; (remove-hook 'server-switch-hook 'magit-commit-diff) ;提交时不显示差异，如需显示敲c-c c-d
     ))


;; 星际译王 词典放在自己的home目录下的.stardict/dic/ 要把字典解压成文件夹，url：http://download.huzheng.org
(defun kid-sdcv-to-buffer (&optional input)
  (interactive "P")
  (let ((word (if mark-active
                  (buffer-substring-no-properties (region-beginning) (region-end))
                (current-word nil t))))
    (if input
        (setq word (read-string (format "Search the dictionary for (default %s): " word)
                                nil nil word)))

    (set-buffer (get-buffer-create "*sdcv*"))
    (buffer-disable-undo)
    (erase-buffer)
    (message "searching for %s ..." word)

    (let ((process (start-process  "sdcv" "*sdcv*"  "sdcv" "-n" "--utf8-input" "--utf8-output" (concat "--data-dir=" (expand-file-name user-emacs-directory) ".stardict/dic")  word)))
    ;; (let ((process (start-process  "sdcv" "*sdcv*"  "sdcv" "-n" "--utf8-input" "--utf8-output"  word)))
      (set-process-sentinel
       process
       (lambda (process signal)
         (when (memq (process-status process) '(exit signal))
           (unless (string= (buffer-name) "*sdcv*")
             (setq kid-sdcv-window-configuration (current-window-configuration))
             (switch-to-buffer-other-window "*sdcv*")
             (local-set-key (kbd "RET") 'kid-sdcv-to-buffer)
             (local-set-key (kbd ",") (lambda ()
                                        (interactive)
                                        (quit-window t))));; quit-window t 可以关闭窗口并恢复原先窗口布局,但是buffer被kill
           (goto-char (point-min))
           (open-line 1)))))))

(global-set-key (kbd "<M-f11>") 'kid-sdcv-to-buffer)

;; 显示搜索index
(require 'anzu)
(global-anzu-mode +1)
(setq anzu-search-threshold 200) ;;防止大文件搜索时很卡
(global-set-key (kbd "M-%") 'anzu-query-replace)
(global-set-key (kbd "C-M-%") 'anzu-query-replace-regexp)

;; anzu mode-line不显示括号
(defun anzu--update-mode-line-default-fset (here total)
  (when anzu--state
    (let ((status (cl-case anzu--state
                    (search (format "%s/%d%s"
                                    (anzu--format-here-position here total)
                                    total (if anzu--overflow-p "+" "")))
                    (replace-query (format "%d replace" total))
                    (replace (format "%d/%d" here total)))))
      (propertize status 'face 'anzu-mode-line))))
(fset 'anzu--update-mode-line-default 'anzu--update-mode-line-default-fset)

;; tabbar
(global-set-key (kbd "<C-tab>") 'tabbar-forward-tab)
(global-set-key (kbd "<C-S-tab>") 'tabbar-backward-tab)

;; (require 'aquamacs-tabbar)
;; (tabbar-mode)

;; centaur-tabs
(require 'centaur-tabs)
(centaur-tabs-mode t)
(global-set-key (kbd "C-<prior>")  'centaur-tabs-backward)
(global-set-key (kbd "C-<next>") 'centaur-tabs-forward)
(global-set-key (kbd "<C-tab>") 'centaur-tabs-forward)
(global-set-key (kbd "<C-S-tab>") 'centaur-tabs-backward)

(global-set-key (kbd "<header-line> <wheel-down>") 'centaur-tabs-forward-group)
(global-set-key (kbd "<header-line> <wheel-up>") 'centaur-tabs-backward-group)

(centaur-tabs-headline-match)
(setq centaur-tabs-style "bar")
(setq centaur-tabs-set-icons t)
(setq centaur-tabs-set-bar t)           ;To display a colored bar at the left of the selected tab
(setq centaur-tabs-set-modified-marker t)
(setq centaur-tabs-modified-marker "*")
;; (setq centaur-tabs-height 18)

;; 过滤掉某些buffer功能在aquamacs-tabbar中未使用，加上
;; (defun tabbar-gzj-inhgibit-function ()
;;   ""
;;   (uninterested-buffer (current-buffer)))
;; ;; (add-to-list 'tabbar-inhibit-functions 'tabbar-gzj-inhibit-function)
;; (with-eval-after-load 'tabbar
;;   (setq tabbar-inhibit-functions 'tabbar-gzj-inhibit-function))
;; (with-eval-after-load 'tabbar-window
;;   (defun tabbar-line-fset ()
;;     "Return the header line templates that represent the tab bar.
;; Inhibit display of the tab bar in current window if any of the
;; `tabbar-inhibit-functions' return non-nil."
;;     (cond
;;      ((run-hook-with-args-until-success 'tabbar-inhibit-functions)
;;       ;; Don't show the tab bar.
;;       (setq header-line-format nil))
;;      ((tabbar-current-tabset t)
;;       ;; When available, use a cached tab bar value, else recompute it.
;;       (or (tabbar-template tabbar-current-tabset)
;;           (tabbar-line-format tabbar-current-tabset)))))
;;   (fset 'tabbar-line 'tabbar-line-fset))

;; 防止undo后标签颜色不恢复
;; (defadvice undo(after undo-after activate)
;;   ;;   (on-modifying-buffer) ;; tabbar
;;   (tabbar-update-if-changes-undone)       ; aquamacs-tabbar
;;   )
;; (defadvice redo(after redo-after activate)
;;   ;;   (on-modifying-buffer)  ;; tabbar
;;   (tabbar-window-update-tabsets-when-idle)
;;   )
;; (add-hook 'after-revert-hook 'on-modifying-buffer)
;; (add-hook 'after-revert-hook 'tabbar-window-update-tabsets-when-idle)
;; (define-key special-event-map [iconify-frame] 'ignore)
;; (defadvice iconify-frame (after leave-hidden-frame
;;                                 (&rest args) disable compile)
;;   (aquamacs-handle-frame-iconified (car args)))

;; 重新定义以下函数，关闭按钮不显示图片（windows上显示效果差）
;; (when (memq system-type '(windows-nt ms-dos))
;;   (setq tabbar-use-images nil)
;;   (defsubst tabbar-line-tab (tab)
;;     "Return the display representation of tab TAB.
;; That is, a propertized string used as an `header-line-format' template
;; element.
;; Call `tabbar-tab-label-function' to obtain a label for TAB."
;;     (let* ((selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
;;            (close-button-image (tabbar-find-image tabbar-close-tab-button))
;;            (mouse-face (if selected-p
;;                            'tabbar-selected-highlight
;;                          'tabbar-unselected-highlight))

;;            (text-face (if selected-p
;;                           'tabbar-selected
;;                         'tabbar-unselected))
;;            (close-button
;;             (propertize "[Ⅹ]"
;;                         'tabbar-tab tab
;;                         'local-map (tabbar-make-tab-keymap tab)
;;                         'tabbar-action 'close-tab
;;                         ;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
;;                         'mouse-face mouse-face
;;                         'face text-face
;;                         'pointer 'arrow
;;                         ;; 'display (tabbar-normalize-image close-button-image 0 'nomask)
;;                         ))

;;            (display-label
;;             (propertize (if tabbar-tab-label-function
;;                             (funcall tabbar-tab-label-function tab)
;;                           tab)
;;                         'tabbar-tab tab
;;                         'local-map (tabbar-make-tab-keymap tab)
;;                         ;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
;;                         'mouse-face mouse-face
;;                         'face (cond ((and selected-p
;;                                           (buffer-modified-p (tabbar-tab-value tab)))
;;                                      'tabbar-selected-modified)
;;                                     ((and (not selected-p)
;;                                           (buffer-modified-p (tabbar-tab-value tab)))
;;                                      'tabbar-unselected-modified)
;;                                     ((and selected-p
;;                                           (not (buffer-modified-p (tabbar-tab-value tab))))
;;                                      'tabbar-selected)
;;                                     (t 'tabbar-unselected))
;;                         'pointer 'arrow))
;;            (key-label
;;             (if (and tabbar-show-key-bindings (boundp 'tabbar-line-tabs) tabbar-line-tabs)
;;                 (let* ((mm (member tab tabbar-line-tabs) )
;;                        ;; calc position (i.e., like position from cl-seq)
;;                        (index (if mm (- (length tabbar-line-tabs) (length mm)))))
;;                   (if (and index (fboundp (tabbar-key-command (+ 1 index))))
;;                       (propertize
;;                        (get (tabbar-key-command (+ 1 index)) 'label)
;;                                         ;(format "%s" (+ 1 index))
;;                        'mouse-face mouse-face
;;                        ;; same mouse-face leads to joint mouse activation for all elements
;;                        'face (list 'tabbar-key-binding text-face) ;; does not work
;;                        )
;;                     "")
;;                   ) "")))
;;       (concat close-button display-label key-label tabbar-separator-value))))

;; imenu list
(autoload 'imenu-list-smart-toggle "imenu-list" nil t)
(global-set-key (kbd "M-q") 'imenu-list-smart-toggle) ;不要直接用imenu-list命令，因为不起timer，无法自动刷新

;; maple-imenu
(autoload 'maple-imenu "maple-imenu" nil t)
;; (global-set-key (kbd "M-q") 'maple-imenu)

;; modeline和主题定制
;; doom theme with its mode line
(require 'doom-themes)
;; (doom-themes-visual-bell-config)
;; (doom-themes-neotree-config)
(autoload 'doom-themes-org-config "doom-themes-ext-org.el" nil t)
(doom-themes-org-config)
;; (doom-themes-treemacs-config)           ;这句会导致treemacs无法点击打开文件的tags，但是可以在文件名上右键选择打开
;; (load-theme 'doom-nord t) ;; 这句要用 '(custom-enabled-themes (quote (doom-nord)))，否则tabbar的face有问题
(require 'doom-modeline)
(setq doom-modeline-github nil)
(setq inhibit-compacting-font-caches t) ; laggy issue on Windows
(setq doom-modeline-buffer-file-name-style 'buffer-name)
(setq doom-modeline-vcs-max-length 30)
;; add which-func in inactive window
(doom-modeline-def-segment misc-info-for-all
  "Mode line construct for miscellaneous information.
By default, this shows the information specified by `global-mode-string'."
  '("" mode-line-misc-info))

(doom-modeline-def-modeline 'main-misc-for-all
  '(bar workspace-name window-number modals matches buffer-info remote-host buffer-position word-count parrot selection-info)
  '(objed-state misc-info-for-all persp-name battery grip irc mu4e github debug lsp minor-modes input-method indent-info buffer-encoding major-mode process vcs checker))

(defun doom-modeline-set-main-misc-for-all-modeline (&optional default)
  "Set main mode-line.
If DEFAULT is non-nil, set the default mode-line for all buffers with misc in inactive window also."
  (doom-modeline-set-modeline 'main-misc-for-all default))

(fset 'doom-modeline-set-main-modeline 'doom-modeline-set-main-misc-for-all-modeline)
(doom-modeline-mode 1)

;; org screenshort，得装image magick
(autoload 'org-download-screenshot "org-download" nil t)
(global-set-key (kbd "<C-f11>") 'org-download-screenshot)

(eval-after-load "org-download"
  '(progn
     (defun org-download-insert-link-fset (link filename)
       (if (looking-back "^[ \t]+" (line-beginning-position))
           (delete-region (match-beginning 0) (match-end 0))
         (newline))
       (insert
        (concat
         ;; (funcall org-download-annotate-function link)
         ;; "\n"
         (if (= org-download-image-html-width 0)
             ""
           (format "#+attr_html: :width %dpx\n" org-download-image-html-width))
         (if (= org-download-image-latex-width 0)
             ""
           (format "#+attr_latex: :width %dcm\n" org-download-image-latex-width))
         (format org-download-link-format (file-relative-name filename (file-name-directory (buffer-name))))))
       (org-display-inline-images))
     (fset 'org-download-insert-link 'org-download-insert-link-fset)
     ))

;; org agenda
(setq org-agenda-files (list "f:\\org\\task.org"))
(global-set-key (kbd "C-c l") 'org-agenda)

;; taglist
(autoload 'taglist-list-tags "taglist" nil t)
(global-set-key (kbd "M-Q") 'taglist-list-tags)

;; lsp IDE级插件，有些server比如bash,javascript需要用npm命令安装，npm命令要装https://nodejs.org/en/才有
;; from source编译，要装yarn
;; # install dependencies
;; npm install
;; # compile
;; npm run build
(when (memq system-type '(windows-nt ms-dos))
  (setq lsp-java-server-install-dir "D:/jdt-language-server-latest/")
  (setq lsp-java-java-path "C:\\Program Files\\Java\\jdk1.8.0_202\\bin\\java.exe")
  (setq lsp-java-workspace-cache-dir "d:/lsp-java-workspace/.cache/")
  (setq lsp-java-workspace-dir "d:/lsp-java-workspace/"))

(autoload 'projectile-mode "projectile" nil t)
(global-set-key (kbd "C-S-t") 'projectile-toggle-between-implementation-and-test);切换src和test文件，得先projectile-mode
(autoload 'lsp "lsp-mode" nil t)        ;not lsp-mode but lsp
(autoload 'helm-lsp-workspace-symbol "helm-lsp" nil t)

;; lsp默认支持js-mode不支持json-mode,flycheck默认支持json-mode
(with-eval-after-load 'lsp-mode
  (require 'projectile)                 ;目录下面放.projectile文件才行
  (require 'flycheck)
  (require 'lsp-ui)
  (require 'yasnippet)
  (require 'company-yasnippet)
  (require 'company-lsp)
  ;; (require 'cquery)
  (require 'ccls)
  (require 'lsp-java)
  (require 'helm-lsp)
  ;; (require 'helm-xref)
  (require 'lsp-treemacs);; lsp-treemacs-errors-list lsp-treemacs-quick-fix lsp-treemacs-symbols-list
  (require 'lsp-origami)
  (projectile-mode)
  (add-hook 'java-mode-hook 'lsp)
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'c++-mode-hook 'lsp)
  (add-hook 'python-mode-hook 'lsp)
  ;; (add-hook 'js-mode-hook 'lsp)
  (add-hook 'sh-mode-hook 'lsp)
  (add-hook 'kotlin-mode-hook 'lsp)
  (add-hook 'nxml-mode-hook 'lsp)
  (add-hook 'js-mode-hook 'lsp)

  (add-hook 'origami-mode-hook #'lsp-origami-mode) ;支持折叠

  ;;防止在注释里lsp不能补全时使用其他后端会卡，另外带上company-yasnippet ，太卡，另外补全成员的时候不应该提示
  ;; (defadvice lsp--auto-configure (after lsp--auto-configure-after activate)
  ;;   (add-to-list 'company-backends '(company-lsp :with company-yasnippet)))


  (yas-global-mode t)
  (global-diff-hl-mode)
  ;; (setq lsp-auto-guess-root t)

  (setq lsp-prefer-flymake nil)
  (setq lsp-ui-imenu-enable nil)        ;打开大文件太卡
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-doc-enable nil)          ;用手动lsp-describe-thing-at-point替代
  (setq lsp-ui-flycheck-enable t)
  ;; (setq lsp-auto-configure nil)
  (global-company-mode t)
  (setq company-lsp-enable-recompletion nil)

  (global-flycheck-mode t)
  ;; (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  ;; (global-set-key (kbd "C-M-.") 'lsp-ui-find-workspace-symbol)
  (global-set-key (kbd "C-M-.") 'helm-lsp-workspace-symbol)

  (global-set-key (kbd "<f1>") 'lsp-ui-peek-find-definitions)
  (global-set-key (kbd "<S-f1>") 'lsp-describe-thing-at-point) ;可以替代lsp-ui-doc
  (global-set-key (kbd "<C-f12>") 'lsp-execute-code-action)
  (global-set-key (kbd "<C-M-b>") 'lsp-find-implementation)
  (global-set-key (kbd "<f12>") 'xref-find-references)
  (global-set-key (kbd "M-.") 'lsp-find-definition)

  (define-key lsp-ui-peek-mode-map (kbd "f") 'lsp-ui-peek--goto-xref)

  ;; (defadvice lsp--auto-configure (after lsp--auto-configure-af activate)
  ;;   (when (functionp 'company-tabnine)
  ;;     (setq company-backends (push '(company-lsp :with company-tabnine) company-backends))
  ;;     ))

  ;; imenu只显示返回值和函数名，参数不显示
  (defun lsp--symbol-to-imenu-elem-fset (sym)
    (let* ((start-point (lsp--symbol-get-start-point sym))
           (name (gethash "name" sym))
           (container (gethash "containerName" sym)))
      (cons (if (and lsp-imenu-show-container-name container)
                ;; (concat container lsp-imenu-container-name-separator name)
                (substring container 0 (string-match "(" container))
              name
              ;; (substring name 0 (string-match "(" name))
              )
            start-point)))

  ;; (fset 'lsp--symbol-to-imenu-elem 'lsp--symbol-to-imenu-elem-fset)

  (defun lsp--symbol-to-hierarchical-imenu-elem-fset (sym)
    (let* ((start-point (lsp--symbol-get-start-point sym))
           (name (gethash "name" sym))
           (name-trim (substring name 0 (string-match "(" name))))
      (if (gethash "children" sym)
          (cons name-trim
                (cons (cons (format "(%s)" (lsp--get-symbol-type sym)) start-point)
                      (lsp--imenu-create-hierarchical-index (gethash "children" sym))))
        (cons (format "%s (%s)" name-trim (lsp--get-symbol-type sym)) start-point))))

  ;; (fset 'lsp--symbol-to-hierarchical-imenu-elem 'lsp--symbol-to-hierarchical-imenu-elem-fset)

  ;; java-script 追加json-mode
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "javascript-typescript-stdio")
                    :major-modes '(json-mode)
                    :priority -3
                    :server-id 'jsts-ls))
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection "typescript-language-server")
                    :major-modes '(json-mode)
                    :priority -2
                    :server-id 'ts-ls))

  ;; kotlin
  (lsp-register-client
   (make-lsp-client :new-connection (lsp-stdio-connection '("D:\\kotlin\\server\\build\\install\\server\\bin\\kotlin-language-server.bat"))
                    :major-modes '(kotlin-mode)
                    :priority 1
                    :server-id 'kt-ls))

  ;; java settings
  ;; lsp-java的Treemacs和Classpath browsing功能需要用Eclipse Che Language Server
  ;; lsp-java-jdt-download-url - JDT JS download url. Use http://download.eclipse.org/che/che-ls-jdt/snapshots/che-jdt-language-server-latest.tar.gz if you want to use Eclipse Che JDT LS.
  (with-eval-after-load 'lsp-java
    (setq lsp-ui-imenu-enable t)
    ;; (require 'lsp-java-treemacs)
    ;; use STS4
    ;; (require 'lsp-java-boot)

    ;; to enable the lenses
    ;; (add-hook 'lsp-mode-hook #'lsp-lens-mode)
    ;; (add-hook 'java-mode-hook #'lsp-java-boot-lens-mode)
    ;; (lsp-java-treemacs-register)
    ;; (dap-mode t)
    ;; (dap-ui-mode t)
    ;; (defun lsp-java-treemacs--is-root-fset (dir-or-project)
    ;;   "Return whether DIR-OR-PROJECT is root of a project."
    ;;   (let ((dir (if (stringp dir-or-project)
    ;;                  dir-or-project
    ;;                (treemacs-project->path dir-or-project))))

    ;;     (when-lsp-workspace (lsp-java--find-workspace (lsp--path-to-uri dir)) ;diff here
    ;;                         (-contains? (lsp-java--get-project-uris lsp--cur-workspace)
    ;;                                     (lsp--path-to-uri dir)))))

    ;; (fset 'lsp-java-treemacs--is-root 'lsp-java-treemacs--is-root-fset)

    ;; (defun lsp-java-treemacs-unregister-fset ()
    ;;   "Unregister extension."
    ;;   (interactive)
    ;;   (remove-hook 'lsp-workspace-folders-change 'lsp-java-treemacs--folders-change)
    ;;   (treemacs-remove-project-extension 'treemacs-EXTERNAL-LIBRARY-extension
    ;;                                      'top) ;diff here
    ;;   (treemacs-remove-directory-extension 'treemacs-EXTERNAL-LIBRARY-extension
    ;;                                        'top)) ;diff here

    ;; (fset 'lsp-java-treemacs-unregister 'lsp-java-treemacs-unregister-fset)
    )
  ;; xref按键重定义
  (define-key xref--button-map [mouse-1] 'ignore)
  (define-key xref--button-map (kbd "<double-mouse-1>") 'xref-show-location-at-point)
  (defun xref--mouse-2-fset (event)
    "Move point to the button and show the xref definition."
    (interactive "e")
    (mouse-set-point event)
    (forward-line 0)
    ;; (xref--search-property 'xref-item)
    (xref-show-location-at-point))
  (fset 'xref--mouse-2 'xref--mouse-2-fset)
  )

;; ccls
(with-eval-after-load 'ccls
  (setq ccls-executable "D:\\software\\ccls\\build\\MinSizeRel\\ccls.exe")
  ;; (setq company-transformers nil company-lsp-async t company-lsp-cache-candidates nil)
  ;; (setq ccls-args '("--log-file=d:/ccls.log"))
  ;; Use t for true, :json-false for false, :json-null for null.
  ;; (setq-default ccls-initialization-options '(:index (:threads 1 :comments 0 :initialBlacklist [".*"] :initialWhitelist [".*/dir/.*"])))
  (define-key c-mode-map (kbd "<S-f12>") 'ccls-call-hierarchy)
  (define-key c++-mode-map (kbd "<S-f12>") 'ccls-call-hierarchy)

  ;; (setq ccls-sem-highlight-method 'font-lock)
  ;; alternatively, (setq ccls-sem-highlight-method 'overlay)

  ;; For rainbow semantic highlighting
  ;; (ccls-use-default-rainbow-sem-highlight)
  
  (defun ccls/callee () (interactive) (lsp-ui-peek-find-custom "$ccls/call" '(:callee t)))
  (defun ccls/caller () (interactive) (lsp-ui-peek-find-custom "$ccls/call"))
  (defun ccls/vars (kind) (lsp-ui-peek-find-custom "$ccls/vars" `(:kind ,kind)))
  (defun ccls/base (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels)))
  (defun ccls/derived (levels) (lsp-ui-peek-find-custom "$ccls/inheritance" `(:levels ,levels :derived t)))
  (defun ccls/member (kind) (interactive) (lsp-ui-peek-find-custom "$ccls/member" `(:kind ,kind)))

  ;; References w/ Role::Address bit (e.g. variables explicitly being taken addresses)
  (defun ccls/references-address ()
         (interactive)
         (lsp-ui-peek-find-custom "textDocument/references"
                                  (plist-put (lsp--text-document-position-params) :role 128)))
  ;; References w/ Role::Role
  (defun ccls/references-read () (interactive)
         (lsp-ui-peek-find-custom "textDocument/references"
                                  (plist-put (lsp--text-document-position-params) :role 8)))

  ;; References w/ Role::Write
  (defun ccls/references-write ()
         (interactive)
         (lsp-ui-peek-find-custom "textDocument/references"
                                  (plist-put (lsp--text-document-position-params) :role 16)))

  ;; References w/ Role::Dynamic bit (macro expansions)
  (defun ccls/references-macro () (interactive)
         (lsp-ui-peek-find-custom "textDocument/references"
                                  (plist-put (lsp--text-document-position-params) :role 64)))

  ;; References w/o Role::Call bit (e.g. where functions are taken addresses)
  (defun ccls/references-not-call () (interactive)
         (lsp-ui-peek-find-custom "textDocument/references"
                                  (plist-put (lsp--text-document-position-params) :excludeRole 32)))

  ;; 显示的符号修改
  (defun ccls-tree--make-prefix-fset (node number nchildren depth)
         "."
         (let* ((padding (if (= depth 0) "" (make-string (* 2 (- depth 1)) ?\ )))
                (symbol (if (= depth 0)
                          (if (ccls-tree-node-parent node)
                            "< "
                            "")
                          (if (ccls-tree-node-has-children node)
                              (if (ccls-tree-node-expanded node) "└- " "└+ ")
                            (if (eq number (- nchildren 1)) "└* " "├* ")))))
                            (concat padding (propertize symbol 'face 'ccls-tree-icon-face))))

  (fset 'ccls-tree--make-prefix 'ccls-tree--make-prefix-fset)
  (define-key ccls-tree-mode-map (kbd "SPC") 'ccls-tree-press)
  (define-key ccls-tree-mode-map [mouse-1] 'ignore )
  (define-key ccls-tree-mode-map [mouse-2] 'ccls-tree-press )
  (define-key ccls-tree-mode-map [mouse-3] 'ccls-tree-toggle-expand)
  (define-key ccls-tree-mode-map (kbd "n") (lambda () "" (interactive)
                                               (forward-line 1)
                                               (back-to-indentation)))
  (define-key ccls-tree-mode-map (kbd "p") (lambda () "" (interactive)
                                               (forward-line -1)
                                               (back-to-indentation)))
  (add-hook 'ccls-tree-mode-hook 'set-c-word-mode)
)

;; cquery config
(with-eval-after-load 'cquery
  (if (memq system-type '(windows-nt ms-dos))
      (setq cquery-executable "d:/software/cquery/build/release/bin/cquery")
    (setq cquery-executable "~/cquery/build/release/bin/cquery"))
  ;; Use t for true, :json-false for false, :json-null for null
  ;; (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack")) ;; msgpack占用空间小，但是查看困难，并且结构体变更，要手动更新索引
  ;; container现在在xref里还没有显示，无法使用，配置是:xref (:container t), comments有乱码先不用 , :completion (:detailedLabel t)跟不设置区别不大
  (setq-default cquery-extra-init-params '(:index (:threads 1 :comments 0 :blacklist (".*") :whitelist (".*/dira/dirb/.*" ".*/dirc/dird/.*"))))
  ;; (setq cquery-extra-args '("--log-stdin-stdout-to-stderr" "--log-file=/tmp/cq.log"))
;;;; enable semantic highlighting:
  ;; (setq cquery-sem-highlight-method 'overlay)
  ;; (setq cquery-sem-highlight-method 'font-lock)
  (define-key c-mode-map (kbd "<S-f12>") 'cquery-call-hierarchy)
  (define-key c++-mode-map (kbd "<S-f12>") 'cquery-call-hierarchy)

  ;;提示cquery is not enabled in buffer就把调cquery--cquery-buffer-check的地方都注掉

  ;;进程异常时，记录有残留，执行这句复原
  (global-set-key (kbd "<C-S-f12>") (lambda () "" (interactive)
                                      (setq lsp--workspaces (make-hash-table :test #'equal))))
  (define-key cquery-tree-mode-map (kbd "SPC") 'cquery-tree-press)
  (define-key cquery-tree-mode-map [mouse-1] 'ignore )
  (define-key cquery-tree-mode-map [mouse-2] 'cquery-tree-press )
  (define-key cquery-tree-mode-map [mouse-3] 'cquery-tree-toggle-expand )
  (define-key cquery-tree-mode-map (kbd "n") (lambda () "" (interactive)
                                               (forward-line 1)
                                               (back-to-indentation)))
  (define-key cquery-tree-mode-map (kbd "p") (lambda () "" (interactive)
                                               (forward-line -1)
                                               (back-to-indentation)))
  (add-hook 'cquery-tree-mode-hook 'set-c-word-mode)
  ;; (cquery-use-default-rainbow-sem-highlight)
  ;; 其他功能
  ;; (cquery-xref-find-custom "$cquery/base")
  ;; (cquery-xref-find-custom "$cquery/callers")
  ;; (cquery-xref-find-custom "$cquery/derived")
  ;; (cquery-xref-find-custom "$cquery/vars")
  ;; (cquery-xref-find-custom "$cquery/random")
  ;; (cquery-xref-find-custom "$cquery/references-address")"
  ;; (cquery-xref-find-custom "$cquery/references-read")
  ;; (cquery-xref-find-custom "$cquery/references-write")
  ;; cquery-call-hierarchy带c-u查的是callee，不带查的是caller

  ;; 解决乱码
  (defun cquery-tree--make-prefix-fset (node number nchildren depth)
    "."
    (let* ((padding (if (= depth 0) "" (make-string (* 2 (- depth 1)) ?\ )))
           (symbol (if (= depth 0)
                       (if (cquery-tree-node-parent node)
                           "< "
                         "")
                     (if (cquery-tree-node-has-children node)
                         (if (cquery-tree-node-expanded node) "└- " "└+ ")
                       (if (eq number (- nchildren 1)) "└* " "├* ")))))
      (concat padding (propertize symbol 'face 'cquery-tree-icon-face))))
  (fset 'cquery-tree--make-prefix 'cquery-tree--make-prefix-fset)

  (defadvice cquery-member-hierarchy (around cquery-member-hierarchy-ar activate)
    (setq temp cquery-tree-initial-levels)
    (setq cquery-tree-initial-levels 2)
    ad-do-it
    (setq cquery-tree-initial-levels temp))
  )

;; pkg-info for flycheck
(autoload 'pkg-info-version-info "pkg-info" nil t)

;; clipmon监视剪贴板
(autoload 'clipmon-mode "clipmon" nil t)
;; (setq clipmon-autoinsert-sound nil)
;; clipmon-autoinsert-toggle 自动插入当前buffer，只能监视其他程序，当前程序不行

;; treemacs
(global-set-key (kbd "<M-f6>") 'treemacs-select-window)
(autoload 'treemacs "treemacs" nil t)
(autoload 'treemacs-select-window "treemacs" nil t)
(setq treemacs--icon-size 16)

(with-eval-after-load 'treemacs
  (require 'treemacs-icons-dired)
  ;; (require 'treemacs-magit)
  (treemacs-git-mode 'deferred)
  (if (memq system-type '(windows-nt ms-dos))
      (progn
        ;; (setq treemacs-max-git-entries 100)
        (setq treemacs-python-executable "c:/Python37/python.exe")))
  (global-set-key (kbd "<S-f6>") 'treemacs-find-file)
  (global-set-key (kbd "<C-S-f6>") 'treemacs-find-tag)

  (add-hook 'treemacs-mode-hook
            (lambda ()
              ;; (setq treemacs-collapse-dirs 3) ;太卡，而且有时会导致同步文件位置出错
              (treemacs-icons-dired-mode)
              ;; (treemacs-tag-follow-mode)
              (treemacs-follow-mode -1) ;treemacs-find-file 手动focus
              ;; (treemacs-filewatch-mode -1)                                        ;太卡
              (define-key treemacs-mode-map (kbd "tt") 'treemacs-tag-follow-mode) ;treemacs-find-tag 手动focus
              (define-key treemacs-mode-map (kbd "e") 'treemacs-toggle-node)
              (define-key treemacs-mode-map (kbd "f") 'treemacs-visit-node-no-split)
              (define-key treemacs-mode-map (kbd "/") 'isearch-forward)
              (define-key treemacs-mode-map (kbd "?") 'isearch-backward)
              )))

;; dap-mode 调试
(autoload 'dap-mode "dap-mode" nil t)
(autoload 'dap-ui-mode "dap-ui" nil t)
(with-eval-after-load 'dap-mode
  (require 'dap-java)
  (require 'dap-python))

;; 对齐线
(autoload 'highlight-indent-guides-mode "highlight-indent-guides" nil t)
;; (add-hook 'nxml-mode-hook 'highlight-indent-guides-mode)
;; (add-hook 'emacs-lisp-mode-hook 'highlight-indent-guides-mode)

(with-eval-after-load 'highlight-indent-guides
  (setq highlight-indent-guides-method 'character)
  (setq highlight-indent-guides-character ?\|)
  ;; (setq highlight-indent-guides-delay 0.7)
  )

(autoload 'indent-guide-global-mode "indent-guide" nil t)

;; kotlin mode 跟java转换的一种语言
(autoload 'kotlin-mode "kotlin-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.kt$" . kotlin-mode))

;; yaml mode
(autoload 'yaml-mode "yaml-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml\\'" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; swiper
;; 替代helm-gtags
;; (autoload 'counsel-gtags-mode "counsel-gtags" nil t)
(autoload 'counsel-gtags-find-file "counsel-gtags" nil t)
;; (autoload 'counsel-gtags-find-symbol "counsel-gtags" nil t)
(autoload 'counsel-gtags-find-definition "counsel-gtags" nil t)
;; (autoload 'counsel-gtags-find-reference "counsel-gtags" nil t)
;; (autoload 'counsel-gtags-dwim "counsel-gtags" nil t)
;; (autoload 'counsel-gtags-create-tags "counsel-gtags" nil t)
;; (autoload 'counsel-gtags-update-tags "counsel-gtags" nil t)

(global-set-key (kbd "<C-S-f5>") 'counsel-gtags-find-file)
(global-set-key (kbd "<C-S-f7>") 'counsel-gtags-find-definition)
;; (global-set-key (kbd "C-\\") 'counsel-gtags-dwim)
;; (global-set-key (kbd "<S-f5>") 'counsel-gtags-create-tags) ;可以指定路径和label
;; (global-set-key (kbd "<f5>") 'counsel-gtags-update-tags) ;c-u 全局刷新 ，c-u c-u 创建
;; (global-set-key (kbd "C-c s") 'counsel-gtags-find-symbol)
;; (global-set-key (kbd "C-c r") 'counsel-gtags-find-reference)

;; 接管输入
(autoload 'ivy-mode "ivy" nil t)
(global-set-key (kbd "<M-apps>") 'ivy-resume)
(global-set-key (kbd "C-c C-r") 'ivy-resume)

(with-eval-after-load 'ivy
  ;; (setq ivy-re-builders-alist
  ;;       '((t . ivy--regex-fuzzy)))
  ;; (ivy-toggle-fuzzy)
  ;; (require 'ivy-posframe)
  ;; (setq ivy-display-function #'ivy-posframe-display)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-center)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-window-center)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-frame-bottom-left)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-window-bottom-left)
  ;; (setq ivy-display-function #'ivy-posframe-display-at-point)
  ;; (ivy-posframe-enable)
  )

;; (ivy-mode)
;; counsel-yank-pop显示历史默认M-y
;; counsel-git查看当前工程下的文件通过git
;; counsel-faces可以显示face list
;; (global-set-key (kbd "<C-f10>") 'counsel-locate)
;; (autoload 'counsel-locate "counsel" nil t)

(autoload 'counsel-rg "counsel" nil t)
(autoload 'counsel-git "counsel" nil t)
(autoload 'counsel-mode "counsel" nil t)
;; (with-eval-after-load 'counsel
;;   (when (eq system-type 'darwin)
;;     (setq counsel-locate-cmd 'counsel-locate-cmd-mdfind))
;;   (define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history))
;; (counsel-mode)
;; 接管搜索
(autoload 'swiper "swiper" nil t)

;; (global-set-key (kbd "<f9>") 'swiper)
;; (with-eval-after-load 'swiper
;;   (global-set-key (kbd "<f9>") 'swiper)
;;   (global-set-key (kbd "<C-M-f9>") 'swiper-occur)
;; (define-key isearch-mode-map (kbd "<f9>") (lambda () (interactive)
;;                                             (unless (featurep 'swiper)
;;                                               (require 'swiper))
;;                                             (swiper-from-isearch)))
;;   )

;; 多光标操作
(autoload 'mc/mark-all-like-this "multiple-cursors" nil t)
(autoload 'mc/edit-lines "multiple-cursors" nil t)
(global-set-key (kbd "C-c C-e") 'mc/mark-all-like-this) ;选中后C-y粘贴替换
(global-set-key (kbd "C-c C-s") 'mc/edit-lines)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)


;; nedtree explorer
(autoload 'neotree-toggle "neotree" nil t)
(global-set-key (kbd "<M-f7>") 'neotree-toggle)

;; 折叠
(autoload 'origami-mode "origami" nil t)
;; (add-hook 'prog-mode-hook
;;           (lambda () (origami-mode)))

(autoload 'yafolding-mode "yafolding" nil t) ;侧栏有标记，基于缩进
(autoload 'yafolding-toggle-element "yafolding" nil t)
(define-key global-map (kbd "M-[") 'yafolding-toggle-element)
(with-eval-after-load 'yafolding
  (global-set-key (kbd "<left-fringe> <mouse-1>") 'yafolding-toggle-element)
  (define-key yafolding-mode-map (kbd "<C-return>") nil))

;; (add-hook 'prog-mode-hook
;;           (lambda () (yafolding-mode)))

;; evil fold备用，依赖origami-mode
;; (autoload 'evil-toggle-fold "evil" nil t)
;; (defadvice evil-toggle-fold(before evil-toggle-fold-bf activate)
;;   (unless origami-mode
;;     (origami-mode t)))

;; fold region, 创建fold后用c-` toggle
(autoload 'vimish-fold "vimish-fold" nil t)
(global-set-key (kbd "C-.") 'vimish-fold)
(global-set-key (kbd "C->") 'vimish-fold-delete)

;; 符号高亮
(autoload 'symbol-overlay-put "symbol-overlay" nil t)
(autoload 'symbol-overlay-jump-next "symbol-overlay" nil t)
(autoload 'symbol-overlay-jump-prev "symbol-overlay" nil t)

(global-set-key (kbd "<M-f8>") 'symbol-overlay-put)
(global-set-key (kbd "<C-f8>") 'symbol-overlay-remove-all)
(global-set-key (kbd "M-n") 'symbol-overlay-jump-next)
(global-set-key (kbd "M-p") 'symbol-overlay-jump-prev)
(global-set-key (kbd "C-c n") 'symbol-overlay-switch-forward) ;切到下一下高亮的符号，没有高亮时不管用
(global-set-key (kbd "C-c p") 'symbol-overlay-switch-backward)
;; (symbol-overlay-mode t)                   ;自动高亮，不是全局的

;; purpose
(autoload 'purpose-mode "window-purpose" nil t)
(autoload 'purpose-toggle-window-buffer-dedicated "window-purpose"nil t) ;该窗口不会被占
(global-set-key (kbd "<M-S-f10>") 'purpose-mode)                         ;该窗口用于某一类buffer
(global-set-key (kbd "<C-S-f10>") 'purpose-toggle-window-buffer-dedicated)

;; nyan
;; (autoload 'nyan-mode "nyan-mode" nil t)

;; find-file
(autoload 'find-file-in-project "find-file-in-project" nil t)
(global-set-key (kbd "<M-S-f6>") 'find-file-in-project)
(setq ffip-use-rust-fd t)

;; json reformat
;; 通过package已经加载的json-mode-beautify命令C-c C-f就是把一段json报文美化成有段落缩进的效果，但是转出来的顺序是乱的
;; web-beautify转的正确，需要依赖npm -g install js-beautify
(autoload 'web-beautify-js "web-beautify" nil t)
(autoload 'web-beautify-css "web-beautify" nil t)
(autoload 'web-beautify-html "web-beautify" nil t)
(global-set-key (kbd "C-c C-b") 'web-beautify-js)
(global-set-key (kbd "C-c C-h") 'web-beautify-html)


;; smartparens
(autoload 'smartparens-mode "smartparens-config" nil  t)
;; (add-hook 'prog-mode-hook #'smartparens-mode)
;; 移动的按键 sp-smartparens-bindings

;; dired-hacks
;; dired-rainbow太旧，已经不管用了
(autoload 'dired-collapse-mode "dired-collapse" nil t)
(autoload 'dired-filter-group-mode "dired-filter" nil t)
(setq dired-filter-group-saved-groups '(("default"
                                         ("PDF"
                                          (extension . "pdf"))
                                         ("LaTeX"
                                          (extension "tex" "bib"))
                                         ("Org"
                                          (extension . "org"))
                                         ("Document"
                                          (extension "doc" "docx" "xls" "xlsx" "ppt" "pptx"))
                                         ("Picture"
                                          (extension "png" "jpg" "jpeg" "gif" "ttf"))
                                         ("Execute"
                                          (extension "exe" "jar"))
                                         ("Media"
                                          (extension "ogg" "flv" "mpg" "avi" "mp4" "mp3"))
                                         ("Archives"
                                          (extension "zip" "rar" "gz" "bz2" "tar")))))
(autoload 'dired-narrow-fuzzy "dired-narrow" nil t) ;动态过滤，按g恢复

;; 显示java properties中的中文
(autoload 'properties-mode "properties-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.properties$" . properties-mode))

;; 搜索
(autoload 'snails "snails" nil t)
;; multiple scratch buffers 创建一个跟当前buffer mode一样的scratch buffer
(autoload 'scratch "scratch" nil t)

;; 比较目录
(autoload 'ztree-diff "ztree" nil t)
;;-----------------------------------------------------------plugin end-----------------------------------------------------------;;

;;-----------------------------------------------------------define func begin----------------------------------------------------;;
;; toggle hide/show #if
(defun my-hif-toggle-block ()
  "toggle hide/show-ifdef-block --lgfang"
  (interactive)
  (require 'hideif)
  (let* ((top-bottom (hif-find-ifdef-block))
         (top (car top-bottom)))
    (goto-char top)
    (hif-end-of-line)
    (setq top (point))
    (if (hif-overlay-at top)
        (show-ifdef-block)
      (hide-ifdef-block))))
(define-key global-map (kbd "C-{") 'my-hif-toggle-block)

(defun hif-overlay-at (position)
  "An imitation of the one in hide-show --lgfang"
  (let ((overlays (overlays-at position))
        ov found)
    (while (and (not found) (setq ov (car overlays)))
      (setq found (eq (overlay-get ov 'invisible) 'hide-ifdef)
            overlays (cdr overlays)))
    found))

;; 添加删除注释
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
If no region is selected and current line is not blank and we are not at the end of the line,
then comment current line.
Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-'" 'qiang-comment-dwim-line) ;; 已有comment-line c-x c-;代替 c-c c-c注释region


;; 拷贝代码自动格式化默认是粘贴完后按c-m-\会格式化粘贴内容)
(dolist (command '(yank yank-pop))      ;要想粘贴后不自动缩进，要借助helm-show-kill-ring，用这个粘贴不缩进
  (eval
   `(defadvice ,command (after indent-region activate)
      (and (not current-prefix-arg)
           (member major-mode
                   '(emacs-lisp-mode
                     lisp-mode
                     c-mode
                     c++-mode
                     python-mode
                     java-mode
                     yaml-mode
                     nxml-mode
                     javascript-mode
                     kotlin-mode
                     ))
           (let ((mark-even-if-inactive transient-mark-mode))
             (indent-region (region-beginning) (region-end) nil)
             ;; (c-indent-line-or-region t t)
             )))))

;; 跳到匹配的括号处，不要配置%当快捷键
(defun his-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
    (cond ((string-match "[[{(<（]" next-char) (forward-sexp 1))
          ((string-match "[\]})>）]" prev-char) (backward-sexp 1))
          )))

;; 选中括号间的内容
(defun select-match ()
  "select between match paren"
  (interactive)
  (set-mark-command nil)
  (his-match-paren 1))

(global-set-key (kbd "C-'") 'his-match-paren)
(global-set-key (kbd "C-\"") 'select-match)

;; 复制文件路径(支持buffer中和dired中)
(defun copy-file-name (&optional full)
  "Copy file name of current-buffer.
If FULL is t, copy full file name."
  (interactive "P")
  (if (eq major-mode 'dired-mode)
      (dired-copy-filename-as-kill full)
    (let ((file (file-name-nondirectory (buffer-file-name) )))
      (if full
          (setq file (expand-file-name file)))
      (if (eq full 0)
          (kill-new (setq file (replace-regexp-in-string "/" "\\\\" file)))
        (kill-new file))
      (message "File `%s' copied." file))))

;; dired下m-0 w复制全路径，并且把/换成\ ,M-9不转换
(defadvice dired-copy-filename-as-kill(after copy-full-path activate)
  (let ((strmod (current-kill 0)))
    (if (eq last-command 'kill-region)
        ()
      (when arg
        (if (eq arg 0)
            (kill-new (setq strmod (replace-regexp-in-string "/" "\\\\" strmod)))
          (kill-new (setq strmod (car (dired-get-marked-files))))))
      (message "%s" strmod))))

(global-set-key (kbd "<M-f3>") 'copy-file-name) ;加上任意的参数就是复制全路径，比如m-0
(global-set-key (kbd "<C-f3>") 'ergoemacs-open-in-desktop)
(global-set-key (kbd "<C-f4>") 'ergoemacs-open-in-external-app) ;; windows下没用，在dired上用&就行
;;剪切、复制当前行
(defadvice kill-ring-save (before slickcopy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

(defadvice kill-region (before slickcut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))


;;hide ^M
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; 利用evil-jump实现回跳机制, 每个窗口有独立的pop历史
(dolist (command '(avy-goto-char avy-goto-char-timer lsp-ui-peek-find-definitions helm-gtags-dwim helm-gtags-find-rtag helm-gtags-find-tag helm-gtags-select helm-gtags-select-path counsel-gtags-dwim counsel-gtags-find-symbol counsel-gtags-find-file my-ag ag-this-file occur rgrep gtags-find-tag-by-event semantic-analyze-proto-impl-toggle ff-find-other-file find-file-at-point xref-find-definitions xref-find-apropos xref-find-references cquery-tree-press-and-switch lsp-ui-find-workspace-symbol  lsp-find-definition lsp-find-declaration  lsp-find-implementation lsp-find-type-definition symbol-overlay-jump-next symbol-overlay-jump-prev helm-ag-buffers helm-ag-project-root))
  (eval
   `(defadvice ,command (before jump-mru activate)
      (unless (featurep 'evil-jumps)
        (require 'evil))
      (when (featurep 'evil-jumps)
        (evil-set-jump))
      ;; (window-configuration-to-register :prev-win-layout)
      )))

;; 设置单词连接
(defun set-c-word-mode ()
  ""
  (interactive)
  ;; (require 'cc-mode) 
  ;; (set-syntax-table c++-mode-syntax-table) ;;以上这两句会影响c++-mode的语法高亮，比如注释无法正常高亮
  ;; (modify-syntax-entry ?- ".")			;-作为标点符号，起到分隔单词作用
  (modify-syntax-entry ?& ".")
  (modify-syntax-entry ?$ ".")
  (modify-syntax-entry ?< ".")
  (modify-syntax-entry ?> ".")
  (modify-syntax-entry ?= ".")
  (modify-syntax-entry ?/ ".")
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w")
  ;; (setq-local bm-cycle-all-buffers nil)
  )

(global-set-key (kbd "C-?") 'set-c-word-mode)

(defun kill-spec-buffers ()
  ""
  (interactive)
  (dolist (buffer (buffer-list))
    (when (uninterested-buffer buffer)
      (kill-buffer buffer))))

(global-set-key (kbd "<C-S-f9>") 'kill-spec-buffers)
;; 也可以用clean-buffer-list,midnight-mode

;; reuse buffer in DIRED
(defadvice dired-find-file (around dired-find-file-single-buffer activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer))
        (filename (dired-get-file-for-visit)))
    ad-do-it
    (when (and (file-directory-p filename)
               (not (eq (current-buffer) orig)))
      (kill-buffer orig))))
(defadvice dired-up-directory (around dired-up-directory-single-buffer activate)
  "Replace current buffer if file is a directory."
  (interactive)
  (let ((orig (current-buffer)))
    ad-do-it
    (kill-buffer orig)))

;; 大文件处理
(defun check-large-file-hook ()
  ""
  (when (< (* 200 1024) (buffer-size))
    ;; (setq-local jit-lock-context-time 1.5)
    ;; (setq-local jit-lock-defer-time 0.5)
    (setq-local font-lock-maximum-decoration 2)
    (font-lock-refresh-defaults)
    (setq-local semantic-idle-scheduler-idle-time 60)
    (setq-local company-idle-delay 3)
    (setq-local cquery-sem-highlight-method nil)
    ;; (eldoc-mode -1)
    ;; (font-lock-mode -1 )
    ;; (jit-lock-mode nil)
    ;; (diff-hl-mode -1)
    (message "Large file." )
    ))

(defun unix-to-dos-trim-M ()
  (interactive)
  (unless (eq buffer-file-coding-system 'chinese-gbk-dos)
    (set-buffer-file-coding-system 'chinese-gbk-dos t))
  (save-excursion
    (beginning-of-buffer)
    (while (re-search-forward "\^M" nil t)
      (replace-match "" nil nil)))
  (save-buffer))
(global-set-key (kbd "C-c m") 'unix-to-dos-trim-M) ;注意在大于200K的文件中替换时会卡住，要c-g后反复用此命令

;; 重新打开文件
(defun reopen-file()
  ""
  (interactive)
  (let ((pos (point))
        (file (buffer-file-name)))
    (kill-this-buffer)
    (find-file file)
    (goto-char pos)))

;; 能够去除光标下的高亮
(defun hi-lock--regexps-at-point-fset ()
  (let ((regexps '()))
    ;; When using overlays, there is no ambiguity on the best
    ;; choice of regexp.
    (let ((regexp (concat "\\_<" (thing-at-point 'symbol) "\\_>")))
      (when regexp (push regexp regexps)))
    regexps))
(defun hi-lock-unface-buffer-fset (regexp)
  "Remove highlighting of each match to REGEXP set by hi-lock.
Interactively, prompt for REGEXP, accepting only regexps
previously inserted by hi-lock interactive functions.
If REGEXP is t (or if \\[universal-argument] was specified interactively),
then remove all hi-lock highlighting."
  (interactive
   (cond
    (current-prefix-arg (list t))
    ((and (display-popup-menus-p)
          (listp last-nonmenu-event)
          use-dialog-box)
     (catch 'snafu
       (or
        (x-popup-menu
         t
         (cons
          `keymap
          (cons "Select Pattern to Unhighlight"
                (mapcar (lambda (pattern)
                          (list (car pattern)
                                (format
                                 "%s (%s)" (car pattern)
                                 (hi-lock-keyword->face pattern))
                                (cons nil nil)
                                (car pattern)))
                        hi-lock-interactive-patterns))))
        ;; If the user clicks outside the menu, meaning that they
        ;; change their mind, x-popup-menu returns nil, and
        ;; interactive signals a wrong number of arguments error.
        ;; To prevent that, we return an empty string, which will
        ;; effectively disable the rest of the function.
        (throw 'snafu '("")))))
    (t
     ;; Un-highlighting triggered via keyboard action.
     (unless hi-lock-interactive-patterns
       (error "No highlighting to remove"))
     ;; Infer the regexp to un-highlight based on cursor position.
     (let* ((defaults (or (hi-lock--regexps-at-point)
                          (mapcar #'car hi-lock-interactive-patterns))))
       ;; (list
       ;;  (completing-read (if (null defaults)
       ;;                       "Regexp to unhighlight: "
       ;;                     (format "Regexp to unhighlight (default %s): "
       ;;                             (car defaults)))
       ;;                   hi-lock-interactive-patterns
       ;;                    nil t nil nil defaults))
       (list (car defaults))			;不用读取用户输入，直接用光标下的单词
       ))))
  (dolist (keyword (if (eq regexp t) hi-lock-interactive-patterns
                     (list (assoc regexp hi-lock-interactive-patterns))))
    (when keyword
      (let ((face (hi-lock-keyword->face keyword)))
        ;; Make `face' the next one to use by default.
        (when (symbolp face)          ;Don't add it if it's a list (bug#13297).
          (add-to-list 'hi-lock--unused-faces (face-name face))))
      ;; FIXME: Calling `font-lock-remove-keywords' causes
      ;; `font-lock-specified-p' to go from nil to non-nil (because it
      ;; calls font-lock-set-defaults).  This is yet-another bug in
      ;; font-lock-add/remove-keywords, which we circumvent here by
      ;; testing `font-lock-fontified' (bug#19796).
      (if font-lock-fontified (font-lock-remove-keywords nil (list keyword)))
      (setq hi-lock-interactive-patterns
            (delq keyword hi-lock-interactive-patterns))
      (remove-overlays
       nil nil 'hi-lock-overlay-regexp (hi-lock--hashcons (car keyword)))
      (font-lock-flush))))

(eval-after-load "hi-lock"
  '(progn
     (fset 'hi-lock--regexps-at-point 'hi-lock--regexps-at-point-fset)
     (fset 'hi-lock-unface-buffer 'hi-lock-unface-buffer-fset)
     ))

;; C++中给函数前面加上类名
(with-eval-after-load 'semantic/format
  (lambda ()
    (define-mode-local-override semantic-format-tag-uml-abbreviate
      c++-mode (token &optional parent color)
      "Return an UML string describing TOKEN for C and C++.
Optional PARENT and COLOR as specified with
`semantic-abbreviate-tag-default'."
      ;; If we have special template things, append.
      (concat  (semantic-format-tag-uml-abbreviate-default-fset token parent color)
               (semantic-c-template-string token parent color)))

    (defun semantic-format-tag-uml-abbreviate-default-fset (tag &optional parent color)
      "Return a UML style abbreviation for TAG.
Optional argument PARENT is the parent type if TAG is a detail.
Optional argument COLOR means highlight the prototype with font-lock colors."
      (let* ((name (semantic-format-tag-name tag parent color))
             (type  (semantic--format-tag-uml-type tag color))
             (protstr (semantic-format-tag-uml-protection tag parent color))
             (tag-parent-str
              (or (when (and (semantic-tag-of-class-p tag 'function)
                             (semantic-tag-function-parent tag))
                    (concat (semantic-tag-function-parent tag)
                            semantic-format-parent-separator))
                  ""))
             (text nil))
        (setq text
              (concat
               tag-parent-str
               protstr
               (if type (concat name type)
                 name)))
        (if color
            (setq text (semantic--format-uml-post-colorize text tag parent)))
        text))
    (define-mode-local-override semantic-format-tag-uml-prototype
      c++-mode (token &optional parent color)
      "Return an UML string describing TOKEN for C and C++.
Optional PARENT and COLOR as specified with
`semantic-abbreviate-tag-default'."
      ;; If we have special template things, append.
      (concat  (semantic-format-tag-uml-prototype-default-fset token parent color)
               (semantic-c-template-string token parent color)))
    (defun semantic-format-tag-uml-prototype-default-fset (tag &optional parent color)
      "Return a UML style prototype for TAG.
Optional argument PARENT is the parent type if TAG is a detail.
Optional argument COLOR means highlight the prototype with font-lock colors."
      (let* ((class (semantic-tag-class tag))
             (cp (semantic-format-tag-name tag parent color))
             (type (semantic--format-tag-uml-type tag color))
             (prot (semantic-format-tag-uml-protection tag parent color))
             (tag-parent-str
              (or (when (and (semantic-tag-of-class-p tag 'function)
                             (semantic-tag-function-parent tag))
                    (concat (semantic-tag-function-parent tag)
                            semantic-format-parent-separator))
                  ""))
             (argtext
              (cond ((eq class 'function)
                     (concat
                      " ("
                      (semantic--format-tag-arguments
                       (semantic-tag-function-arguments tag)
                       #'semantic-format-tag-uml-prototype
                       color)
                      ")"))
                    ((eq class 'type)
                     "{}")))
             (text nil))
        (setq text (concat tag-parent-str prot cp argtext type))
        (if color
            (setq text (semantic--format-uml-post-colorize text tag parent)))
        text
        ))))

;; 在资源管理器中打开
(defun open-in-desktop-select ()
  (interactive)
  (let ((file (buffer-name)))
    (if (string-equal major-mode "dired-mode")
        ;; (setq file (dired-get-filename 'no-dir)) ;xp
        (setq file (replace-regexp-in-string "/" "\\\\" (dired-get-filename) )) ;win7
      ;; (setq file (file-name-nondirectory (buffer-file-name) )) ;xp
      (setq file (replace-regexp-in-string "/" "\\\\" (buffer-file-name) ))) ;win7
    (call-process-shell-command (concat "explorer" "/select," file))
    )
  )

(defun ergoemacs-open-in-desktop ()
  "Show current file in desktop (OS's file manager)."
  (interactive)
  (cond
   ((eq system-type 'windows-nt)
    ;; (w32-shell-execute "explore" (replace-regexp-in-string "/" "\\" default-directory t t))
    (open-in-desktop-select)
    )
   ((eq system-type 'darwin) (shell-command "open ."))
   ((eq system-type 'gnu/linux)
    (let ((process-connection-type nil))
      (start-process "" nil "xdg-open" ".")))))

;; 用默认的程序打开，windows下用&命令直接打开
(defcustom ergoemacs-maximum-number-of-file-to-open 5
  "Maximum number of files to open.
If less than or equal to zero, there is no limit."
  :type 'integerp
  :group 'ergoemacs-mode)
(defun ergoemacs-open-in-external-app (&optional file)
  ""
  (interactive)
  (let* ((my-file-list
          (cond
           ((consp file) file)
           (file (list file))
           ((eq major-mode 'dired-mode) (dired-get-marked-files))
           ((eq major-mode 'locate-mode) (dired-get-marked-files))
           ((not file) (list (or (buffer-file-name)
                                 (error "This buffer is not visiting a file"))))))
         (do-it (or (<= (length my-file-list) ergoemacs-maximum-number-of-file-to-open)
                    (>= 0 ergoemacs-maximum-number-of-file-to-open)
                    (y-or-n-p (format "Open more than %s files? " ergoemacs-maximum-number-of-file-to-open)))))
    (when do-it
      (cond
       ((eq system-type 'windows-nt)
        (dolist (f-path my-file-list)
          (w32-shell-execute
           "open" (replace-regexp-in-string "/" "\\" f-path t t))))
       ((eq system-type 'darwin)
        (dolist (f-path my-file-list)
          (shell-command (format "open \"%s\"" f-path))))
       ((eq system-type 'gnu/linux)
        (dolist (f-path my-file-list)
          (let (process-connection-type)
            (start-process "" nil "xdg-open" f-path))))))))

(defun kill-ring-save-keep-highlight (beg end)
  "Keep the region active after the kill"
  (interactive "r")
  (prog1 (kill-ring-save beg end)
    (setq deactivate-mark nil)))

(global-set-key (kbd "<C-insert>") 'kill-ring-save-keep-highlight)
;; 垃圾回收调整，避免卡顿
(defmacro k-time (&rest body)
  "Measure and return the time it takes evaluating BODY."
  `(let ((time (current-time)))
     ,@body
     (float-time (time-since time))))

(defvar k-gc-timer
  (run-with-idle-timer 15 t
                       (lambda ()
                         (k-time (garbage-collect))
                         )))
;;-----------------------------------------------------------define func end------------------------------------------------;;
;;-----------------------------------------------------------hook-----------------------------------------------------------;;
(c-add-style "gzj"
             '("stroustrup"
               (c-basic-offset . 4)		; Guessed value
               (c-offsets-alist
                (arglist-cont . 0)		; Guessed value
                (arglist-intro . +)		; Guessed value
                (block-close . 0)		; Guessed value
                (case-label . +)		; Guessed value
                (defun-block-intro . +)	; Guessed value
                (defun-close . 0)		; Guessed value
                (defun-open . 0)		; Guessed value
                (do-while-closure . 0)  ; Guessed value
                (else-clause . 0)		; Guessed value
                (extern-lang-close . 0)	; Guessed value
                (inextern-lang . 0)		; Guessed value
                (label . 0)				; Guessed value
                (statement . 0)			; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-open . 0) ; Guessed value
                (statement-cont . +)    ; Guessed value
                (substatement . 0)      ; Guessed value
                (substatement-open . 0)	  ; Guessed value
                (topmost-intro . 0)		  ; Guessed value
                (topmost-intro-cont . 0) ; Guessed value
                (access-label . -)
                (annotation-top-cont . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont-nonempty . c-lineup-arglist)
                (block-open . 0)
                (brace-entry-open . 0)
                (brace-list-close . 0)
                (brace-list-entry . 0)
                (brace-list-intro . +)
                (brace-list-open . 0)
                (c . c-lineup-C-comments)
                (catch-clause . 0)
                (class-close . 0)
                (class-open . 0)
                (comment-intro . 0)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro . 0)
                (cpp-macro . -1000)
                (cpp-macro-cont . +)
                (extern-lang-open . 0)
                (friend . 0)
                (func-decl-cont . 0)
                (inclass . +)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-close . 0)
                (inline-open . 0)
                (inmodule . +)
                (innamespace . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . +)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-close . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-intro . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement-label . 0)
                (template-args-cont c-lineup-template-args +))))

(c-add-style "javagzj"
             '("java"
               (c-basic-offset . 4)	; Guessed value
               (c-offsets-alist
                (annotation-top-cont . 0)   ; Guessed value
                (arglist-intro . ++)	; Guessed value
                (block-close . 0)	; Guessed value
                (case-label . +)	; Guessed value
                (class-close . 0)	; Guessed value
                (class-open . 0)	; Guessed value
                (defun-block-intro . +)	; Guessed value
                (else-clause . 0)	; Guessed value
                (func-decl-cont . ++)	; Guessed value
                (inclass . +)		; Guessed value
                (inline-close . 0)	; Guessed value
                (statement . 0)		; Guessed value
                (statement-block-intro . +) ; Guessed value
                (statement-case-intro . +) ; Guessed value
                (statement-cont . ++)	; Guessed value
                (substatement-open . 0)	; Guessed value
                (topmost-intro . 0)	; Guessed value
                (access-label . 0)
                (annotation-var-cont . +)
                (arglist-close . c-lineup-close-paren)
                (arglist-cont c-lineup-gcc-asm-reg 0)
                (arglist-cont-nonempty . c-lineup-arglist)
                (block-open . 0)
                (brace-entry-open . 0)
                (brace-list-close . 0)
                (brace-list-entry . c-lineup-under-anchor)
                (brace-list-intro . +)
                (brace-list-open . 0)
                (c . c-lineup-C-comments)
                (catch-clause . 0)
                (comment-intro . c-lineup-comment)
                (composition-close . 0)
                (composition-open . 0)
                (cpp-define-intro c-lineup-cpp-define +)
                (cpp-macro . -1000)
                (cpp-macro-cont . +)
                (defun-close . 0)
                (defun-open . 0)
                (do-while-closure . 0)
                (extern-lang-close . 0)
                (extern-lang-open . 0)
                (friend . 0)
                (incomposition . +)
                (inexpr-class . +)
                (inexpr-statement . +)
                (inextern-lang . +)
                (inher-cont . c-lineup-multi-inher)
                (inher-intro . +)
                (inlambda . c-lineup-inexpr-block)
                (inline-open . 0)
                (inmodule . +)
                (innamespace . +)
                (knr-argdecl . 0)
                (knr-argdecl-intro . 5)
                (label . +)
                (lambda-intro-cont . +)
                (member-init-cont . c-lineup-multi-inher)
                (member-init-intro . +)
                (module-close . 0)
                (module-open . 0)
                (namespace-close . 0)
                (namespace-open . 0)
                (objc-method-args-cont . c-lineup-ObjC-method-args)
                (objc-method-call-cont c-lineup-ObjC-method-call-colons c-lineup-ObjC-method-call +)
                (objc-method-intro .
                                   [0])
                (statement-case-open . +)
                (stream-op . c-lineup-streamop)
                (string . -1000)
                (substatement . +)
                (substatement-label . +)
                (template-args-cont c-lineup-template-args +)
                (topmost-intro-cont . +))))

(add-hook 'prog-mode-hook
          (lambda ()
            (abbrev-mode -1)))

(dolist (hook '(c-mode-hook c++-mode-hook));c-mode-common-hook 不只是c 和c++,java也算
  (add-hook hook
            (lambda()
              (modify-syntax-entry ?_ "w")    ;_ 当成单词的一部分
              (c-set-style "gzj")      ;定制C/C++缩进风格,到实际工作环境中要用guess style(main mode菜单里有个style子菜单)来添加详细的缩进风格。Press ‘C-c C-o’ to see the syntax at point
              ;; (fci-mode 1)
              ;; (hs-minor-mode 1)
              ;; (hide-ifdef-mode 1)
              (check-large-file-hook)
              (font-lock-add-keywords nil
                                      '(("\\(\\_<\\(\\w\\|\\s_\\)+\\_>\\)[    ]*("
                                         1  font-lock-function-name-face keep))
                                      1)
              ;; (superword-mode)                ;连字符不分割单词,影响move和edit，但是鼠标双击选择不管用 ，相对subword-mode(through CamelCase words)
              (set-default 'semantic-imenu-summary-function 'semantic-format-tag-uml-abbreviate)
              )))
(add-hook 'java-mode-hook
          (lambda ()
            ;; (prefer-coding-system 'utf-8) ;这个会改变shell的编码
            (modify-syntax-entry ?_ "w")    ;_ 当成单词的一部分
            (modify-syntax-entry ?- "w")    ;_ 当成单词的一部分
            ;; (setq-local company-idle-delay 0)
            (font-lock-add-keywords nil
                                    '(("\\(\\_<\\(\\w\\|\\s_\\)+\\_>\\)[    ]*("
                                       1  font-lock-function-name-face keep))
                                    1)
            (c-set-style "javagzj")  ))

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (modify-syntax-entry ?- "w")
            ;; (flycheck-mode 1)
            ;; (yas-minor-mode 1)
            ;; (hs-minor-mode 1)
            (company-mode 1)
            (eldoc-mode 1)
            (setq-local company-backends (push '(company-tabnine :with company-yasnippet) company-backends))
            (define-key emacs-lisp-mode-map (kbd "M-.") 'xref-find-definitions)
            ))

(add-hook 'dired-mode-hook
          (lambda ()
            (require 'dired-ranger);; 复制粘贴 dired-ranger-copy dired-ranger-paste dired-ranger-move ，剪贴板查看dired-ranger-copy-ring
            (define-key dired-mode-map (kbd ";") 'dired-narrow-fuzzy) ;默认的&也行
            ;; paste时按c-u不清空剪贴板，这样可以重复粘贴
            (define-key dired-mode-map "b" 'dired-up-directory)
            ;; (define-key dired-mode-map "e" (lambda () "" (interactive)
            ;;                                  (ergoemacs-open-in-desktop t)))
            (define-key dired-mode-map (kbd "e") 'ergoemacs-open-in-desktop)
            (define-key dired-mode-map (kbd ",") 'ergoemacs-open-in-external-app) ;默认的&也行
            (define-key dired-mode-map "/" 'isearch-forward)
            (define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
            (define-key dired-mode-map (kbd "M-s") 'er/expand-region)
            (define-key dired-mode-map [mouse-2] 'dired-mouse-find-file)
            (define-key dired-mode-map "z" 'vc-update)
            ;; dired中用默认打开方式打开文件
            (define-key dired-mode-map (kbd "&") (lambda () "" (interactive)
                                                   (if (eq system-type 'windows-nt)
                                                       (progn
                                                         (with-no-warnings
                                                           (w32-shell-execute "open" (car (dired-get-marked-files)))))
                                                     (dired-do-async-shell-command))))
            (diff-hl-dired-mode 1)
            ;; (unless (or (equal (buffer-name) "c:/")
            ;;             (equal (buffer-name) "d:/")
            ;;             (equal (buffer-name) "e:/")
            ;;             (equal (buffer-name) "f:/")
            ;;             (equal (buffer-name) "g:/"))
            ;;   (dired-collapse-mode 1))
                                        ;在盘符根目录下使用会报权限错误导致根目录打不开
            (dired-filter-group-mode 1)
            ;; (require 'all-the-icons-dired)
            ;; (all-the-icons-dired-mode)
            (require 'treemacs-icons-dired)
            (treemacs-icons-dired-mode 1)
            (define-key dired-mode-map (kbd "`") 'dired-filter-group-toggle-header)
            (define-key dired-mode-map (kbd "<S-tab>") 'dired-filter-group-backward-drawer)
            (dired-async-mode 1)
            ;; (setq-local jit-lock-context-time 0.5)
            ;; (setq-local jit-lock-defer-time nil)
            (unless (memq 'Git vc-handled-backends)
              (setq-local vc-handled-backends (append '(Git) vc-handled-backends)))
            ))

;; shell相关设置
(add-hook 'shell-mode-hook
          (lambda () "DOCSTRING" (interactive)
            ;; (set-buffer-process-coding-system 'utf-8 'utf-8) ;防止shell乱码
            (define-key comint-mode-map (kbd "M-.") 'comint-previous-matching-input-from-input)
            (define-key comint-mode-map (kbd "M-,") 'comint-next-matching-input-from-input)
            (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
            (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
            ;; (yas-minor-mode 1)
            (company-mode -1)
            ))

;; python
(add-hook 'python-mode-hook
          (lambda () "" (interactive)
            (modify-syntax-entry ?_ "w")
            (modify-syntax-entry ?- "w")
            ))

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(remove-hook 'comint-output-filter-functions 'comint-postoutput-scroll-to-bottom)

;; telnet登录主机后，export LANG=zh_CN.GBK 或 export LC_ALL=en_US.ISO-8859-1 这个管用 ,export LC_CTYPE=zh_CN.GB2312

;; gtags symref 的结果都设置为C语法，主要为了highlight-symbol能正确
(dolist (hook '(gtags-select-mode-hook semantic-symref-results-mode-hook ag-mode-hook occur-mode-hook imenu-list-major-mode-hook eshell-mode-hook treemacs-mode-hook cquery-tree-mode-hook ccls-tree-mode-hook helm-update-hook))
  (add-hook hook
            (lambda()
              (setq truncate-lines t)
              (set-c-word-mode)
              )))
;; 设置单词边界
(dolist (hook '(nxml-mode-hook yaml-mode-hook org-mode-hook))
  (add-hook hook
            (lambda()
              (set-c-word-mode))))

(add-hook 'font-lock-mode-hook
          (lambda () "DOCSTRING" (interactive)
            (remove-dos-eol)
            ))

;; org 设置
;; 标题自动加时间戳 '(16)代表两个c-u
(defadvice org-insert-heading(after org-insert-heading-after activate)
  (org-time-stamp '(16))
  (search-backward "<")
  (save-excursion (insert " ")))        ;跳到开头并插个空格
;; 显示缩进
(setq org-startup-indented t)
;; org导出pdf, org要用utf-8保存
(setq org-latex-pdf-process (quote ("xelatex -interaction nonstopmode -output-directory %o %f" "xelatex -interaction nonstopmode -output-directory %o %f" "xelatex -interaction nonstopmode -output-directory %o %f")))
(add-hook 'org-mode-hook
          (lambda () "DOCSTRING" (interactive)
            ;; (iimage-mode t)
            (require 'htmlize)
            (auto-fill-mode t)
            (org-redisplay-inline-images)
            ;; (require 'org-download)
            (define-key org-mode-map [(control tab)] nil)
            (define-key org-mode-map (kbd "<f5>") 'org-redisplay-inline-images)
            (setq truncate-lines nil)
            ))
(setq org-export-with-sub-superscripts '{}) ;设置让 Org Mode 在默认情况下，不转义 _ 字符,这样就会用 {} 来转义了
;; (setq-default org-use-sub-superscripts nil) ;禁用下划线转义

(eval-after-load "which-func"
  '(progn
     ;; 保证which-func强制刷新每个窗口
     (defun which-func-update-fset ()
       ;; "Update the Which-Function mode display for all windows."
       (walk-windows 'which-func-update-1 nil 'visible))
     ;; (which-func-update-1 (selected-window)))

     (fset 'which-func-update 'which-func-update-fset)

     ;; 让which-func在mode line前面显示
     (setq mode-line-misc-info (delete '(which-func-mode
                                         ("" which-func-format " ")) mode-line-misc-info))
     (setq mode-line-front-space (append '(which-func-mode
                                           ("" which-func-format " ")) mode-line-front-space))))
;;-----------------------------------------------------------热键-----------------------------------------------------------;;

;;修改搜索和保存的快捷键
(define-key isearch-mode-map [f3] 'isearch-repeat-forward)
(define-key isearch-mode-map [f8] 'isearch-repeat-forward)
(define-key isearch-mode-map [f4] 'isearch-repeat-backward)
(define-key isearch-mode-map [S-f8] 'isearch-repeat-backward)
;; isearch下的按键 默认： m-r切换regexp， m-e编辑minibuff ，m-c切换大小写敏感
(define-key isearch-mode-map "\C-v" 'isearch-yank-kill)
(define-key isearch-mode-map "\M-o" 'isearch-occur)
(define-key isearch-mode-map "\M-w" 'isearch-toggle-word)
(define-key isearch-mode-map "\M-/" 'isearch-complete)

;; occur按键
(define-key occur-mode-map "p" 'occur-prev)
(define-key occur-mode-map "n" 'occur-next)
(define-key occur-mode-map (kbd "SPC") 'occur-mode-display-occurrence)

;; 搜索光标下的单词
(global-set-key (kbd "<f8>") 'isearch-forward-symbol-at-point)
;; (global-set-key (kbd "<M-f8>") 'highlight-symbol-at-point) ;高亮光标下的单词
(global-set-key (kbd "<C-M-f8>") 'unhighlight-regexp)        ;删除高亮，c-0全删
(global-set-key (kbd "<M-S-f8>") 'highlight-regexp)

;;使用find递归查找文件
;; (global-set-key (kbd "<M-f7>") 'find-name-dired) ;找文件名 用ag-dired代替
;; (global-set-key (kbd "<C-f7>") 'find-grep-dired) ;找文件内容 用ag-files和my-ag代替
;; (global-set-key (kbd "<C-M-f7>") 'kill-find)

;; 窗口管理
(global-set-key (kbd "C-S-w") 'kill-buffer-and-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-below)
(global-set-key (kbd "M-3") 'split-window-right)
(global-set-key (kbd "M-4") 'delete-window)
(global-set-key (kbd "<M-f4>") 'kill-this-buffer)
(global-set-key (kbd "<M-S-down>") 'windmove-down)
(global-set-key (kbd "<M-S-up>") 'windmove-up)
(global-set-key (kbd "<M-S-left>") 'windmove-left)
(global-set-key (kbd "<M-S-right>") 'windmove-right)
(global-set-key (kbd "C-S-o") 'other-frame)
(global-set-key (kbd "C-S-n") 'make-frame-command)
(global-set-key (kbd "<S-f4>") 'delete-frame)


;; 文件跳转
(global-set-key (kbd "<C-f6>") 'find-file-at-point) ;ffap
(global-set-key (kbd "M-o") 'ff-find-other-file) ;声明和实现之间跳转

;; rename buffer可用于给shell改名，起多个shell用
;; (global-set-key (kbd "<M-f2>") 'rename-buffer) ;或者c-u M-x shell
(global-set-key (kbd "<M-f2>") 'bookmark-jump)

;; 重新加载文件
(global-set-key (kbd "<C-f1>") 'revert-buffer)
(global-set-key (kbd "<M-f1>") 'reopen-file)

;; 对齐
(global-set-key (kbd "C-`") 'align)

;; shell
(global-set-key (kbd "<S-f10>") 'shell)
(global-set-key (kbd "<f10>") 'eshell)
(autoload 'aweshell-toggle "aweshell" nil  t)


;; 行号栏选择行
(global-set-key (kbd "<left-margin> <down-mouse-1>") 'mouse-drag-region)
(global-set-key (kbd "<left-margin> <mouse-1>") 'mouse-set-point)
(global-set-key (kbd "<left-margin> <drag-mouse-1>") 'mouse-set-region)
(global-set-key (kbd "<left-fringe> <down-mouse-1>") 'mouse-drag-region)
(global-set-key (kbd "<left-fringe> <mouse-1>") 'mouse-set-point)
(global-set-key (kbd "<left-fringe> <drag-mouse-1>") 'mouse-set-region)
(global-set-key (kbd "<left-margin> <wheel-down>") 'mwheel-scroll)
(global-set-key (kbd "<left-margin> <wheel-up>") 'mwheel-scroll)

;; icomplete
(eval-after-load "icomplete"
  '(progn
     (define-key icomplete-minibuffer-map (kbd "<return>") 'minibuffer-force-complete-and-exit)))
;; set-mark 默认C-@ ，c-x c-x跳回
;; (global-set-key (kbd "C-,") 'set-mark-command) ;mac上用右边的option改成ctrl才可以按c-,左边的ctrl不好使

;; whitespace
(global-set-key (kbd "C-=") 'whitespace-mode)
(global-set-key (kbd "C-+") 'whitespace-cleanup-region)
;; hide/show
;; (global-set-key (kbd "M-[") 'hs-toggle-hiding)
;; (autoload 'hs-toggle-hiding "hideshow" nil t)
;; (defadvice hs-toggle-hiding (around hs-toggle-hiding-ar activate)
;;   ""
;;   (interactive)
;;   (if hs-minor-mode
;;       ad-do-it
;;     (progn
;;       (hs-minor-mode t)
;;       ad-do-it)))

;; rgrep
;; (global-set-key (kbd "<C-f5>") 'rgrep)
;; (global-set-key (kbd "<C-S-f5>") 'lgrep)
;; diff
(global-set-key (kbd "C-;") 'ediff-buffers)
;; vc-dir
(eval-after-load "vc-dir"
  '(progn
     (define-key vc-dir-mode-map (kbd "r") 'vc-revert)
     (define-key vc-dir-mode-map (kbd "d") 'vc-diff)))
;; server-start
(global-set-key (kbd "<C-lwindow>") 'server-start)
;; Calc
(global-set-key (kbd "C-c a") 'calc)
(put 'narrow-to-region 'disabled nil)
;;evil jump(window-local jump)
(autoload 'evil-jump-backward "evil" nil t)
(autoload 'evil-jump-forward "evil" nil t)

(global-set-key (kbd "M-,") 'evil-jump-backward)
(global-set-key (kbd "C-M-,") 'evil-jump-forward)
;; indent select region
(global-set-key (kbd "<S-tab>") 'indent-rigidly)
;; 列模式
(global-set-key (kbd "<C-return>") 'cua-rectangle-mark-mode)
;; 列模式另外一个选择
;; c-x spc激活列模式，C-x r开头的命令来操作详见https://www.gnu.org/software/emacs/manual/html_node/emacs/Rectangles.html#Rectangles
;; 常用的c-x r t替换字符串
(global-set-key (kbd "C-x r a") 'string-insert-rectangle)

(global-set-key (kbd "C-v") 'yank)      ;翻页用page down代替

;; face修改，用copy-face刷掉原来的face属性
(defun change-face ()
  ""
  (require 'doom-modeline)
  ;; (require 'wid-edit)
  (copy-face 'doom-modeline-inactive-bar 'tabbar-default)
  (set-face-attribute 'tabbar-default nil
                      :height 100
                      :family "Consolas"
                      )

  (copy-face 'line-number-current-line 'tabbar-selected)
  ;; (copy-face 'doom-modeline-buffer-major-mode 'tabbar-selected)

  (copy-face 'tabbar-selected 'tabbar-selected-highlight)

  (copy-face 'mode-line-inactive 'tabbar-unselected) ;浅色主题用mode-line，深色的用mode-line-inactive
  (copy-face 'tabbar-unselected 'tabbar-unselected-highlight)

  (copy-face 'tabbar-unselected 'tabbar-modified)
  (set-face-attribute 'tabbar-modified nil
                      :foreground (face-foreground 'error)
                      )
  (copy-face 'tabbar-modified 'tabbar-selected-modified)
  (copy-face 'tabbar-modified 'tabbar-unselected-modified)
  )
;; 浅色主题就只用下面一句就行
(with-eval-after-load 'tabbar
  (set-face-attribute 'tabbar-default nil
                      :height 100
                      :family "Consolas"
                      )
  ;; (change-face)
  )
;; 新窗口利用face
;; (add-hook 'after-make-frame-functions
;;           (lambda (_)                   ;这里如果不用(_)会报参数错误
;;             (change-face)))
;; (defadvice load-theme (after load-theme-af activate)
;;   (change-face))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(color-rg-font-lock-function-location ((t (:foreground "DarkGoldenrod4" :weight bold))))
 '(color-rg-font-lock-header-line-edit-mode ((t (:foreground "goldenrod4" :weight bold))))
 '(color-rg-font-lock-header-line-keyword ((t (:foreground "DarkGoldenrod4" :weight bold))))
 '(epe-pipeline-time-face ((t (:foreground "dodger blue"))))
 '(helm-ls-git-modified-not-staged-face ((t (:foreground "medium blue"))))
 '(helm-moccur-buffer ((t (:foreground "dark green" :underline t))))
 '(helm-xref-file-name ((t (:foreground "dark cyan"))))
 '(lsp-ui-sideline-code-action ((t (:foreground "firebrick"))))
 '(neo-vc-default-face ((t (:foreground "dark gray"))))
 '(taglist-tag-type ((t (:foreground "dark salmon" :height 1.0)))))
