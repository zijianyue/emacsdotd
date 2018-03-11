;;-----------------------------------------------------------外观-----------------------------------------------------------;;
;; 字体保证中文是英文的两倍宽
;; Setting English Font

;; (package-initialize)

(set-face-attribute
 'default nil :font "Source code pro 12")

;; 新开的窗口保持字体
(add-to-list 'default-frame-alist '(font . "Source code pro 12"))

;;Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
					charset
					(font-spec :family "Heiti SC" :size 14))) ;Heiti SC能中英文等高

;; 获取site-lisp路径
(defvar site-lisp-directory nil)
(setq site-lisp-directory (expand-file-name (concat data-directory "../site-lisp")))

(add-to-list 'custom-theme-load-path (concat site-lisp-directory "/spacemacs/spacemacs-theme"))
(add-to-list 'custom-theme-load-path (concat site-lisp-directory "/monokai-emacs"))

;; spacemacs theme setting
(setq spacemacs-theme-comment-bg nil)
(setq spacemacs-theme-org-height nil)
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
(setenv "MSYS" "C:\\MinGW\\msys\\1.0\\bin")
(setenv "MINGW" "C:\\MinGW\\bin")
(setenv "PUTTY" "C:\\Program Files (x86)\\PuTTY")
(setenv "LLVM" "C:\\Program Files (x86)\\LLVM\\bin")
(setenv "CMAKE" "C:\\Program Files (x86)\\CMake\\bin")
(setenv "GTAGSBIN" "c:\\gtags\\bin")
(setenv "PYTHON" "C:\\Python27")		;用27的话ycmd可以使用semantic补全
(setenv "CYGWIN" "C:\\cygwin\\bin")
(setenv "CPPCHECK" "C:\\Program Files (x86)\\Cppcheck")
(setenv "PDFLATEX" "F:\\CTEX\\MiKTeX\\miktex\\bin")
(setenv "PYTHONIOENCODING" "utf-8")     ;防止raw_input出错
(setenv "GITCMD" "C:\\Program Files\\Git\\cmd")
;; (setenv "LC_ALL" "C")			   ;for diff-hl in emacs25
;; (setenv "GTAGSLABEL" "pygments")

(setq python-shell-prompt-detect-enabled nil) ;用python27时需要加这个不然有warning
(setq python-shell-completion-native-enable nil) ;用python27时需要加这个不然有warning

(setenv "PATH"
		(concat
         (getenv "GITCMD")
		 path-separator
		 (getenv "PYTHON")
		 path-separator
		 (getenv "MSYS")
		 path-separator
		 (getenv "MINGW")
		 path-separator
		 (getenv "PUTTY")
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

(add-to-list 'exec-path (getenv "GITCMD") t)
(add-to-list 'exec-path (getenv "PYTHON") t)
(add-to-list 'exec-path (getenv "MINGW") t)
(add-to-list 'exec-path (getenv "MSYS") t)
(add-to-list 'exec-path (getenv "LLVM") t)
(add-to-list 'exec-path (getenv "CMAKE") t)
(add-to-list 'exec-path (getenv "GTAGSBIN") t)
(add-to-list 'exec-path (getenv "CYGWIN") t)
(add-to-list 'exec-path (getenv "CPPCHECK") t)
(add-to-list 'exec-path (getenv "PDFLATEX") t)

;; windows的find跟gnu 的grep有冲突
(setq find-program (concat "\"" (getenv "MSYS") "\\find.exe\""))
(setq grep-program "grep -nH -F")		;-F按普通字符串搜索
;; 默认目录
;; (setq default-directory "d:/")

;; 启动mode
(setq initial-major-mode 'text-mode)

;; elpa
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("melpa" . "http://melpa.milkbox.net/packages/")
						 ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
;; mini buffer 的大小保持不变
;; (setq resize-mini-windows nil)
;; 没有提示音,也不闪屏
(setq ring-bell-function 'ignore)

;; Load CEDET 
;; (require 'semantic )
;; (require 'semantic/decorate )
(require 'srecode)

;; (add-to-list 'semantic-default-submodes 'global-semantic-decoration-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode t)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-edits-mode t)

;; (global-srecode-minor-mode t)
;; 设置模板路径,把模板放到"~/.emacs.d/.srecode/"，避免拷来拷去
(eval-after-load "srecode/map"
  '(progn
     (setq srecode-map-load-path (list (expand-file-name "~/.emacs.d/srecode/")
                                       (srecode-map-base-template-dir)
                                       ))))
;; (semantic-mode t)
;; (global-ede-mode t)
(setq semantic-c-obey-conditional-section-parsing-flag nil) ; ignore #ifdef
;; let cedet call ctags to find things which cedet can not find
;; (semantic-load-enable-all-ectags-support)
;; (semantic-load-enable-primary-ectags-support)
;; (semantic-ectags-add-language-support lua-mode "lua" "f")
;; (add-hook 'lua-mode-hook 'semantic-ectags-simple-setup)

;; (semanticdb-enable-gnu-global-databases 'c-mode) ;;会导致访问\\这种目录中的文件并且里面没有GTAGS文件时挂死
;; (semanticdb-enable-gnu-global-databases 'c++-mode)
(set-default 'semantic-case-fold t)
;; (setq semantic-c-takeover-hideif t)		;帮助hideif识别#if
;; (setq ede-locate-setup-options (quote (ede-locate-global ede-locate-idutils))) ;用gtags帮助cedet找头文件

;; (global-set-key (kbd "M-n") 'semantic-ia-show-summary)
;; semantic-ia-show-doc 备用

;;修改标题栏，显示buffer的名字
(setq frame-title-format "%b [%+] %f")
(setq icon-title-format "%b [%+] %f")

;; 改变 Emacs 固执的要你回答 yes 的行为。按 y 或空格键表示 yes，n 表示 no。
(fset 'yes-or-no-p 'y-or-n-p)

;; 不折行，影响性能
;; (set-default 'truncate-lines t)
;; (setq truncate-partial-width-windows nil) ;; 左右分屏时折行
;; (if (eq 25 emacs-major-version)
;; 	(horizontal-scroll-bar-mode 1))

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

;; hi lock颜色
(setq hi-lock-face-defaults '("hi-yellow" "hi-pink" "hi-green" "hi-blue" "hi-black-b" "hi-blue-b" "hi-red-b" "hi-green-b"))
;; 自动添加的设置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ac-delay 0.3)
 '(ac-disable-faces nil)
 '(ac-expand-on-auto-complete nil)
 '(ac-ignore-case t)
 '(ac-trigger-key "TAB")
 '(ac-use-fuzzy t)
 '(ac-use-menu-map t)
 '(ad-redefinition-action (quote accept))
 '(ag-highlight-search t)
 '(auto-save-default nil)
 '(autopair-blink nil)
 '(aw-scope (quote frame))
 '(back-button-local-keystrokes nil)
 '(back-button-mode-lighter "")
 '(backward-delete-char-untabify-method nil)
 '(bookmark-save-flag 1)
 '(bookmark-sort-flag nil)
 '(c-electric-pound-behavior (quote (alignleft)))
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include/*" "../*")))
 '(column-number-mode t)
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case t)
 '(company-dabbrev-other-buffers t)
 '(company-idle-delay 0)
 '(company-show-numbers t)
 '(company-tooltip-align-annotations t)
 '(company-transformers (quote (company-sort-by-occurrence)))
 '(company-ycmd-request-sync-timeout 0)
 '(compilation-message-face (quote default))
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(cua-mode t nil (cua-base))
 '(cursor-type t)
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("dfc028294b9d9f56d62e2802b77b1e6d7ffee23314324c8b6d4ace7c71338258" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "c924950f6b5b92a064c5ad7063bb34fd3facead47cd0d761a31e7e76252996f7" "72ac74b21322d3b51235f3b709c43c0721012e493ea844a358c7cd4d57857f1f" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "92cfc474738101780aafd15a378bb22476af6e8573daa8031a9e4406b69b9eb8" default)))
 '(delete-by-moving-to-trash t)
 '(diff-hl-flydiff-delay 4)
 '(dired-dwim-target t)
 '(dired-listing-switches "-alh")
 '(dired-recursive-copies (quote always))
 '(dired-recursive-deletes (quote always))
 '(ediff-split-window-function (quote split-window-horizontally))
 '(electric-indent-mode t)
 '(electric-pair-inhibit-predicate (quote electric-pair-conservative-inhibit))
 '(electric-pair-mode t)
 '(enable-local-variables :all)
 '(eww-search-prefix "http://cn.bing.com/search?q=")
 '(explicit-shell-file-name "bash")
 '(fa-insert-method (quote name-and-parens-and-hint))
 '(fci-eol-char 32)
 '(fci-rule-color "#3C3D37")
 '(fill-column 120)
 '(flycheck-check-syntax-automatically nil)
 '(flycheck-checker-error-threshold nil)
 '(flycheck-emacs-lisp-load-path (quote inherit))
 '(flycheck-indication-mode (quote right-fringe))
 '(flycheck-navigation-minimum-level (quote error))
 '(flymake-fringe-indicator-position (quote right-fringe))
 '(frame-resize-pixelwise t)
 '(git-commit-fill-column 200)
 '(git-commit-style-convention-checks nil)
 '(git-commit-summary-max-length 200)
 '(git-gutter:handled-backends (quote (git hg bzr svn)))
 '(git-gutter:update-interval 2)
 '(global-auto-revert-mode t)
 '(global-diff-hl-mode nil)
 '(global-eldoc-mode nil)
 '(global-hl-line-sticky-flag t)
 '(grep-template "grep <X> <C> -nH -F <R> <F>")
 '(gtags-ignore-case nil)
 '(helm-ag-base-command "ag --nocolor --nogroup -S -Q ")
 '(helm-ag-fuzzy-match t)
 '(helm-allow-mouse t)
 '(helm-always-two-windows t)
 '(helm-buffer-max-length 40)
 '(helm-candidate-number-limit 2000)
 '(helm-case-fold-search t)
 '(helm-ff-skip-boring-files t)
 '(helm-for-files-preferred-list
   (quote
    (helm-source-buffers-list helm-source-bookmarks helm-source-recentf)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-cache-max-result-size 504857600)
 '(helm-gtags-cache-select-result t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-maximum-candidates 2000)
 '(helm-gtags-suggested-key-mapping t)
 '(helm-gtags-update-interval-second 3)
 '(helm-semantic-display-style
   (quote
    ((python-mode . semantic-format-tag-summarize)
     (c-mode . semantic-format-tag-uml-prototype)
     (c++-mode . semantic-format-tag-uml-prototype)
     (emacs-lisp-mode . semantic-format-tag-abbreviate-emacs-lisp-mode))))
 '(helm-truncate-lines t t)
 '(hide-ifdef-shadow t)
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#3C3D37" . 0)
     ("#679A01" . 20)
     ("#4BBEAE" . 30)
     ("#1DB4D0" . 50)
     ("#9A8F21" . 60)
     ("#A75B00" . 70)
     ("#F309DF" . 85)
     ("#3C3D37" . 100))))
 '(icomplete-show-matches-on-no-input t)
 '(ido-mode (quote both) nil (ido))
 '(imenu-list-focus-after-activation t)
 '(imenu-list-idle-update-delay 1.0)
 '(imenu-max-item-length 120)
 '(imenu-max-items 1000)
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(jit-lock-context-time 1.5)
 '(jit-lock-defer-time 0.5)
 '(large-file-warning-threshold 40000000)
 '(ls-lisp-verbosity nil)
 '(magit-diff-use-overlays nil)
 '(magit-log-arguments (quote ("-n32" "--stat")))
 '(magit-log-margin (quote (t "%Y-%m-%d %H:%M " magit-log-margin-width t 18)))
 '(magit-log-section-commit-count 0)
 '(magit-refresh-status-buffer nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mode-require-final-newline nil)
 '(moo-select-method (quote helm))
 '(mouse-wheel-progressive-speed nil)
 '(org-download-screenshot-file "f:/org/screenshot.png")
 '(org-download-screenshot-method "convert clipboard: %s")
 '(org-log-done (quote time))
 '(org-src-fontify-natively t)
 '(org-support-shift-select t)
 '(password-cache-expiry nil)
 '(pcmpl-gnu-tarfile-regexp "")
 '(pos-tip-background-color "#FFFACE")
 '(pos-tip-foreground-color "#272822")
 '(powerline-default-separator (quote box))
 '(powerline-gui-use-vcs-glyph t)
 '(recentf-auto-cleanup 600)
 '(rg-custom-type-aliases nil)
 '(rg-show-header nil)
 '(rscope-keymap-prefix "p")
 '(save-place t nil (saveplace))
 '(semantic-c-dependency-system-include-path
   (quote
    ("C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include" "C:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/atlmfc/include" "C:/Program Files (x86)/Windows Kits/10/Include/10.0.10150.0/ucrt" "C:/Program Files (x86)/Windows Kits/8.1/Include/um" "C:/Program Files (x86)/Windows Kits/8.1/Include/shared" "C:/Program Files (x86)/Windows Kits/8.1/Include/winrt")))
 '(semantic-idle-scheduler-idle-time 15)
 '(semantic-idle-scheduler-work-idle-time 600)
 '(semantic-imenu-bucketize-file nil)
 '(semantic-lex-spp-use-headers-flag t)
 '(semantic-symref-results-summary-function (quote semantic-format-tag-abbreviate))
 '(shell-completion-execonly nil)
 '(show-paren-mode t)
 '(show-paren-when-point-in-periphery t)
 '(show-paren-when-point-inside-paren t)
 '(size-indication-mode t)
 '(sln-mode-devenv-2008 "Devenv.com")
 '(switch-window-shortcut-style (quote (quote qwerty)))
 '(tab-width 4)
 '(tabbar-cycle-scope (quote tabs))
 '(tabbar-ruler-excluded-buffers
   (quote
    ("*Messages*" "*Completions*" "*ESS*" "*Packages*" "*log-edit-files*" "*helm-mini*" "*helm-mode-describe-variable*" "*helm for files*" "*helm gtags*" "*Ilist*" "*taglist\"\"")))
 '(tabbar-ruler-fancy-close-image t)
 '(tabbar-ruler-fancy-current-tab-separator (quote inherit))
 '(tabbar-ruler-fancy-tab-separator nil)
 '(tabbar-ruler-pad-selected nil)
 '(tabbar-ruler-tab-height nil)
 '(tabbar-ruler-tab-padding nil)
 '(tool-bar-mode nil)
 '(undo-outer-limit 20000000)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(user-full-name "gezijian")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(vc-svn-program "C:\\Program Files\\TortoiseSVN\\bin\\svn")
 '(vlf-batch-size 10000000)
 '(weechat-color-list
   (unspecified "#272822" "#3C3D37" "#F70057" "#F92672" "#86C30D" "#A6E22E" "#BEB244" "#E6DB74" "#40CAE4" "#66D9EF" "#FB35EA" "#FD5FF0" "#74DBCD" "#A1EFE4" "#F8F8F2" "#F8F8F0"))
 '(which-function-mode t)
 '(whitespace-line-column 120)
 '(winner-mode t)
 '(xref-prompt-for-identifier
   (quote
    (not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-prompt-for-identifier)))
 '(yas-also-auto-indent-first-line t)
 '(ycmd-confirm-fixit nil)
 '(ycmd-delete-process-delay 15)
 '(ycmd-file-type-map
   (quote
    ((c++-mode "cpp")
     (c-mode "c")
     (caml-mode "ocaml")
     (csharp-mode "cs")
     (d-mode "d")
     (erlang-mode "erlang")
     (go-mode "go")
     (js-mode "javascript")
     (js2-mode "javascript")
     (objc-mode "objc")
     (perl-mode "perl")
     (cperl-mode "perl")
     (php-mode "php")
     (python-mode "python")
     (ruby-mode "ruby")
     (rust-mode "rust")
     (scala-mode "scala")
     (tuareg-mode "ocaml")
     (typescript-mode "typescript"))))
 '(ycmd-idle-change-delay 3)
 '(ycmd-parse-conditions (quote (save idle-change mode-enabled buffer-focus)))
 '(ycmd-seed-identifiers-with-keywords t)
 '(ycmd-server-args (quote ("--idle_suicide_seconds=10800")))
 '(ycmd-startup-timeout 20))
;;-----------------------------------------------------------plugin begin-----------------------------------------------------------;;
;; gtags
(setq gtags-suggested-key-mapping nil)
(setq gtags-disable-pushy-mouse-mapping t)
(autoload 'gtags-mode "gtags" nil t)
(eval-after-load "gtags"
  '(progn
	 (define-key gtags-mode-map [C-down-mouse-1] 'ignore)
	 (define-key gtags-mode-map [C-down-mouse-3] 'ignore)
	 (define-key gtags-mode-map [mouse-3] 'ignore)
	 (define-key gtags-mode-map [mouse-2] 'gtags-find-tag-by-event)
	 (define-key gtags-mode-map (kbd "<C-mouse-3>") 'gtags-pop-stack)
	 (define-key gtags-mode-map (kbd "<mouse-3>") 'gtags-pop-stack)
	 (define-key gtags-mode-map (kbd "<C-mouse-1>") 'gtags-find-tag-by-event)
	 (define-key gtags-mode-map (kbd "C-c i") 'gtags-find-with-idutils)
	 (define-key gtags-select-mode-map "p" 'previous-line)
	 (define-key gtags-select-mode-map "n" 'next-line)
	 (define-key gtags-select-mode-map "q" 'gtags-pop-stack)
	 (define-key gtags-select-mode-map [C-down-mouse-3] 'ignore)
	 (define-key gtags-select-mode-map [mouse-3] 'ignore)
	 (define-key gtags-select-mode-map [C-down-mouse-1] 'ignore)
	 (define-key gtags-select-mode-map [mouse-2] 'gtags-select-tag-by-event)
	 (define-key gtags-select-mode-map (kbd "<C-mouse-3>") 'gtags-pop-stack)
	 (define-key gtags-select-mode-map (kbd "<mouse-3>") 'gtags-pop-stack)
	 (define-key gtags-select-mode-map (kbd "<C-mouse-1>") 'gtags-select-tag-by-event)
	 ))

;; 选中单位
;; 从git clone下来的目录名带.el，.el目录不会自动添加到load-path
(add-to-list 'load-path (concat site-lisp-directory "/expand-region.el") ) 
(autoload 'er/expand-region "expand-region" nil t)
(global-set-key (kbd "M-s") 'er/expand-region)

;; undo redo
(require 'redo+)
(setq undo-no-redo t)
(global-set-key (kbd "C-/") 'redo)

;; stl(解析vector map等)
(setq stl-base-dir-14 "c:/Program Files (x86)/Microsoft Visual Studio 14.0/VC/include")

;; 设置成c++文件类型
(add-to-list 'auto-mode-alist (cons stl-base-dir-14 'c++-mode))

;; (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
(add-to-list 'auto-mode-alist '("\\.hpp\\'" . c++-mode))

;; 工程设置
(defun create-spec-ede-project (root-file known)
  (when (file-exists-p root-file)
	(if known
		(ede-cpp-root-project "code" :file root-file
							  :include-path '( "/include" "/server" "/upf"
											   "/upf_dubhe/export" "/UPF_SMI/Include" "/Service/TG/MM/RM/Source/PMM")
							  :spp-files '( "Service/TG/MM/RM/Source/PMM/RMPmm_Const.h"
											"Service/TG/MM/RM/Include/RM_switch.h"
											"Service/TG/MM/RM/Include/RM_Debug.h"
											"ede_switch.h" ;ON OFF宏写成(1)(0)的话不能识别
											)
							  :spp-table '(("IN" . "")
										   ("OUT" . "")
										   ("INOUT" . "") ;如果在函数参数前加上这样的宏会导致无法识别
										   ))
	  (ede-cpp-root-project "code" :file root-file))))

(defun create-known-ede-project(&optional select)
  (interactive "P")
  (if select
	  (setq root-file (read-file-name "Open a root file in proj: "))
	(setq root-file "./GTAGS"))
  (create-spec-ede-project root-file t)
  ;; (find-sln root-file)
  ;; (cscope-set-initial-directory (file-name-directory root-file))
  (message "Known EDE Project Created." ))

(defun create-unknown-ede-project(&optional select)
  (interactive "P")
  (if select
	  (setq root-file (read-file-name "Open a root file in proj: "))
	(setq root-file "./GTAGS"))
  (create-spec-ede-project root-file nil)
  ;; (find-sln root-file)
  ;; (cscope-set-initial-directory (file-name-directory root-file))
  (message "UnKnown EDE Project Created." ))

(global-set-key (kbd "C-c e") 'create-known-ede-project)
(global-set-key (kbd "C-c u") 'create-unknown-ede-project)

(create-spec-ede-project "e:/projects/tempspace/test4c/GTAGS" nil)
(create-spec-ede-project "e:/projects/eNavi2_800X480_ChangeUI/GTAGS" t)
(create-spec-ede-project "e:/projects/Clarion_13MY_Dev_For_MM/GTAGS" t)

;; company
(autoload 'company-mode "company" nil t)
(autoload 'global-company-mode "company" nil t)

(eval-after-load "company"
  '(progn
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
;; (eval-after-load "yasnippet"
;;   '(progn
;;      (add-to-list 'yas-snippet-dirs (concat site-lisp-directory "/snippets"))))
;; (setq yas-snippet-dirs "~/.emacs.d/snippets") ;; 默认就是这个
;; sln解析
(autoload 'find-sln "sln-mode" nil t)
(eval-after-load "project-buffer-mode"
  '(progn
	 (require 'project-buffer-mode+)
	 (project-buffer-mode-p-setup)
	 (require 'project-buffer-occur)
	 (define-key project-buffer-mode-map [?r] 'project-buffer-occur);; 要想全局搜索需要加C-u
	 (define-key project-buffer-mode-map [?m] 'project-buffer-occur-case-sensitive)
	 ;; (define-key global-map (kbd "<M-f6>") 'project-buffer-mode-p-go-to-attached-project-buffer)
	 ;; (define-key global-map (kbd "<C-f6>") 'project-buffer-mode-p-run-project-buffer-build-action)
	 ))

;; (global-set-key (kbd "C-c l") 'find-sln)

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
(autoload 'helm-show-kill-ring "helm-config" nil t)
(autoload 'helm-semantic-or-imenu "helm-config" nil t)
(autoload 'helm-for-files "helm-config" nil t)
(autoload 'helm-resume "helm-config" nil t)
(autoload 'helm-M-x "helm-config" nil t)
(autoload 'helm-find-files "helm-config" nil t)


(autoload 'helm-gtags-mode "helm-gtags" nil t)
(autoload 'helm-gtags-select "helm-gtags" nil t)
(autoload 'helm-gtags-select-path "helm-gtags" nil t)
(autoload 'helm-gtags-find-tag "helm-gtags" nil t)
(autoload 'helm-gtags-find-files "helm-gtags" nil t)
(autoload 'helm-gtags-create-tags "helm-gtags" nil t)
(autoload 'helm-gtags-update-tags "helm-gtags" nil t)
(autoload 'helm-gtags-dwim "helm-gtags" nil t)
(autoload 'helm-gtags-find-rtag "helm-gtags" nil t)

(autoload 'gtags-find-file "gtags" nil t)

(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)

(autoload 'helm-occur "helm-gtags" nil t)
(autoload 'helm-swoop "helm-swoop" nil t)
(autoload 'helm-swoop-from-isearch "helm-swoop" nil t)

(autoload 'helm-ag-this-file "helm-ag" nil t)


(eval-after-load "helm"
  '(progn
	 (define-key helm-map (kbd "<tab>") 'helm-execute-persistent-action) ; rebihnd tab to do persistent action
	 (define-key helm-map (kbd "C-i") 'helm-execute-persistent-action) ; make TAB works in terminal
	 (define-key helm-map (kbd "C-z")  'helm-select-action) ; list actions using C-z
	 (define-key helm-map (kbd "<f12>") 'helm-buffer-run-kill-buffers) ;默认是M-D, M-spc是mark, M-a是全选， M-m是toggle mark
	 ))

(eval-after-load "helm-files"
  '(progn
	 (define-key helm-find-files-map (kbd "<C-backspace>") 'backward-kill-word)
	 (define-key helm-read-file-map (kbd "<C-backspace>") 'backward-kill-word)
	 ))

(global-set-key (kbd "C-S-k") 'helm-all-mark-rings)
(global-set-key (kbd "C-S-v") 'helm-show-kill-ring)
(global-set-key (kbd "<apps>") 'helm-semantic-or-imenu)
(global-set-key (kbd "<C-apps>") 'helm-for-files)
(global-set-key (kbd "<S-apps>") 'helm-resume)
(global-set-key (kbd "<M-apps>") 'helm-ag-this-file)
(global-set-key (kbd "M-]") 'helm-swoop)
(global-set-key (kbd "M-X") 'helm-M-x)
(global-set-key (kbd "C-x f") 'helm-find-files)

(global-set-key (kbd "C-c b") 'helm-gtags-find-files)
(global-set-key (kbd "C-c B") 'gtags-find-file)
(global-set-key (kbd "C-c d") 'helm-gtags-find-tag)
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
	 (defadvice helm-gtags--update-tags-command(before helm-gtags-update-tags-bef activate)
	   (if (bound-and-true-p ycmd-mode)
		   (progn
			 (unless (ycmd-running-p) (ycmd-open))
			 (ycmd-parse-buffer)))
	   ;; (semantic-force-refresh)
	   )
	 
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
	 (define-key helm-gtags-mode-map (kbd "C-M-,") 'helm-gtags-show-stack)
	 ))

(add-hook 'helm-update-hook
		  (lambda ()
			(setq truncate-lines t)))
;; 自定义的mru
(defvar semantic-tags-location-ring (make-ring 30))

;; flycheck
;; (defvar package-user-dir "")			;防止check lisp出错
(autoload 'flycheck-mode "flycheck" nil t)
(autoload 'global-flycheck-mode "flycheck" nil t)

(global-set-key (kbd "M-g l") 'flycheck-list-errors)
(global-set-key (kbd "<M-f5>") (lambda () "" (interactive)
								 (require 'flycheck)
								 (unless flycheck-mode (flycheck-mode 1))
								 (flycheck-buffer)
								 ))

;; 行号性能改善
(require 'nlinum )
(global-nlinum-mode 1)
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

;; markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; 打开大文件
(require 'vlf-setup)
(eval-after-load "vlf"
  '(progn
	 (setq vlf-tune-enabled 'stats)
	 (define-key vlf-prefix-map (kbd "C-c j") vlf-mode-map)))

(defadvice vlf (after vlf-after activate)
  ""
  (remove-dos-eol)
  (nlinum-mode 1)
  (anzu-mode 1))

;; ace
(define-key cua--cua-keys-keymap [(meta v)] nil)
(autoload 'ace-window "ace-window" nil t)
(autoload 'ace-jump-char-mode "ace-jump-mode" nil t)

(eval-after-load "ace-window"
  '(progn
	 (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))))

(eval-after-load "ace-jump-mode"
  '(progn
	 (setq ace-jump-mode-move-keys (loop for i from ?a to ?z collect i))))

(global-set-key (kbd "M-v") 'ace-window)
(global-set-key (kbd "M-j") 'ace-jump-char-mode)


;; 查看diff

;; (require 'diff-hl-margin )
;; (global-diff-hl-mode)
(autoload 'diff-hl-dired-mode "diff-hl-dired" nil t)
(autoload 'global-diff-hl-mode "diff-hl-margin" nil t)
(autoload 'diff-hl-mode "diff-hl" nil t)
(autoload 'turn-on-diff-hl-mode "diff-hl" nil t)
(autoload 'diff-hl-flydiff-mode "diff-hl-flydiff" nil t)
;; (diff-hl-flydiff-mode 1)
;; (add-hook 'prog-mode-hook 'turn-on-diff-hl-mode)
;; (add-hook 'vc-dir-mode-hook 'turn-on-diff-hl-mode)
(eval-after-load "diff-hl"
  '(progn
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

(defun toggle-git-backend ()
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
(defadvice diff-hl-mode(around diff-hl-mode-ar activate)
  (if (not diff-hl-mode)
      (progn
        (setq vc-handled-backends (append '(Git) vc-handled-backends))
        (if (and (not (eq major-mode 'vc-dir-mode))
                 ;; (not (vc-backend buffer-file-name))
                 )
            (reopen-file))
        ad-do-it
        (setq vc-handled-backends (delq 'Git vc-handled-backends)))
    (progn
      (setq vc-handled-backends (delq 'Git vc-handled-backends)))))

(defadvice global-diff-hl-mode(before global-diff-hl-mode-bef activate)
  (if (not global-diff-hl-mode)
      (progn
        (add-to-list 'vc-handled-backends 'Git)
        (ad-deactivate 'diff-hl-mode)
        (if (and (not (eq major-mode 'vc-dir-mode))
                 ;; (not (vc-backend buffer-file-name))
                 )
            (reopen-file)))
    (progn
      (setq vc-handled-backends (delq 'Git vc-handled-backends)))))
;; wgrep
(autoload 'wgrep-setup "wgrep")
(add-hook 'grep-setup-hook 'wgrep-setup)
(setq wgrep-enable-key "r")

(autoload 'wgrep-pt-setup "wgrep-pt")
(add-hook 'pt-search-mode-hook 'wgrep-pt-setup)

;; pt
(autoload 'pt-regexp "pt" nil t)

;; fast silver searcher
(autoload 'my-ag "ag" nil t)
(autoload 'ag-this-file "ag" nil t)
(autoload 'ag-dired "ag" nil t)
(autoload 'ag-dired-regexp "ag" nil t)

(global-set-key (kbd "<f9>") 'ag-this-file)
(global-set-key (kbd "<C-f9>") 'my-ag)
(global-set-key (kbd "<S-f6>") 'vc-git-grep) ;速度最快,区分大小写
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

;; magit
;; 环境变量PATH里面一定要有C:\Program Files\Git\cmd, 不能有C:\Program Files\TortoiseGit\bin，否则git命令在shell里不好使
(setenv "GIT_ASKPASS" "git-gui--askpass") ;解决git push不提示密码的问题
(setenv "SSH_ASKPASS" "git-gui--askpass")
(setenv "GIT_SSH" "c:/Program Files (x86)/PuTTY/plink.exe")
;; 要想保存密码不用每次输入得修改.git-credentials和.gitconfig
;; 解决magit和服务器的乱码问题，不需要在.gitconfig中改118n的配置(比如配置成gb2312)
(defun my-git-commit-hook ()
  (set-buffer-file-coding-system 'utf-8-unix))

;; (defun my-git-commit-hook-gbk ()
;;   (set-buffer-file-coding-system 'chinese-gbk-unix))

;; 删除自带的git支持，在触发相关命令时再打开
(setq-default vc-handled-backends (delq 'Git vc-handled-backends))

;; (add-hook 'magit-mode-hook 'my-git-commit-hook)
;; (add-hook 'magit-status-mode-hook 'my-git-commit-hook)
;; (add-hook 'git-commit-mode-hook 'my-git-commit-hook)
(add-hook 'magit-log-mode-hook
		  (lambda ()
			(setq truncate-lines nil)))
;; (add-hook 'magit-revision-mode-hook 'my-git-commit-hook-gbk)

(autoload 'magit-status "magit" nil t)
(autoload 'magit-dispatch-popup "magit" nil t)
(autoload 'magit-blame "magit" nil t)
(autoload 'magit-log-buffer-file "magit" nil t)
(autoload 'magit-clone "magit" nil t)

(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(global-set-key (kbd "C-x t g") 'magit-blame)
(global-set-key (kbd "C-x t l") 'magit-log-buffer-file)

;; 避免时区差8小时
(eval-after-load "magit"
  '(progn
	 (defadvice magit-blame-format-time-string (before magit-blame-format-time-strin-bef activate)
	   ""
	   (setq tz 0))
	 ;; magit-git-output-coding-system默认值改为nil防止diff乱码，但是会影响stash和blame，所以在这临时改为utf-8
	 ;; (defadvice magit-insert-stashes (around magit-insert-stashes-ar activate)
	 ;;   ""
	 ;;   (setq magit-git-output-coding-system 'utf-8)
	 ;;   ad-do-it
	 ;;   (setq magit-git-output-coding-system nil)
	 ;;   )
     ;; (defadvice magit-git-wash (around magit-git-wash-ar activate)
	 ;;   ""
     ;;   (if (eq washer 'magit-diff-wash-diffs)
     ;;       (progn
     ;;         (message "git-diff")
     ;;         (setq magit-git-output-coding-system 'nil)))
     ;;   ad-do-it
	 ;;   (setq magit-git-output-coding-system 'utf-8)
	 ;;   )
     
     (defadvice magit-insert-diff (around magit-insert-diff-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )
     (defadvice magit-insert-revision-diff (around magit-insert-revision-diff-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )
     (defadvice magit-insert-unstaged-changes (around magit-insert-unstaged-changes-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )
     (defadvice magit-insert-staged-changes (around magit-insert-staged-changes-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )
     (defadvice magit-stash-insert-section (around magit-stash-insert-section-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )
     (defadvice magit-merge-preview-refresh-buffer (around magit-merge-preview-refresh-buffer-ar activate)
	   ""
	   (setq magit-git-output-coding-system 'nil)
	   ad-do-it
	   (setq magit-git-output-coding-system 'utf-8)
	   )


     
	 ;; (defadvice magit-rev-format (around magit-rev-format-ar activate)
	 ;;   ""
	 ;;   (setq magit-git-output-coding-system 'utf-8)
	 ;;   ad-do-it
	 ;;   (setq magit-git-output-coding-system nil)
	 ;;   )
	 ;; (defadvice magit-blame (around magit-blame-ar activate)
	 ;;   ""
	 ;;   (setq-local magit-git-output-coding-system 'utf-8)
	 ;;   ad-do-it
	 ;;   ;; (setq magit-git-output-coding-system nil)
	 ;;   )

     ;; 提高性能
	 (remove-hook 'magit-refs-sections-hook 'magit-insert-tags)
	 (remove-hook 'server-switch-hook 'magit-commit-diff) ;提交时不显示差异，如需显示敲c-c c-d
	 ))

;; purpose
(autoload 'purpose-mode "window-purpose" nil t)
(autoload 'purpose-toggle-window-buffer-dedicated "window-purpose"nil t)
(global-set-key (kbd "<C-f10>") 'purpose-mode)
(global-set-key (kbd "<C-S-f10>") 'purpose-toggle-window-buffer-dedicated)

;; 星际译王 词典放在自己的home目录下的.startdict/dic/ 要把字典解压成文件夹，url：http://download.huzheng.org
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

    (let ((process (start-process  "sdcv" "*sdcv*"  "sdcv" "-n" "--utf8-input" "--utf8-output" word)))
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

(setq tabbar-ruler-use-mode-icons nil)

(require 'tabbar-ruler)
(copy-face 'font-lock-function-name-face 'tabbar-selected)
;; 防止undo后标签颜色不恢复
;; (add-hook 'post-command-hook 'after-modifying-buffer);;这个是在每个命令执行后
(defadvice undo(after undo-after activate)
  (on-modifying-buffer)
  )
(defadvice redo(after redo-after activate)
  (on-modifying-buffer)
  )
(add-hook 'after-revert-hook 'on-modifying-buffer)

(defadvice tabbar-buffer-close-tab(after tabbar-buffer-close-tab-after activate)
  (tabbar-display-update)
  )
(defun tabbar-ruler-group-user-buffers-helper-dired ()
  (list (cond ((string-equal "*" (substring (buffer-name) 0 1)) "emacs's buffers")
			  (t "user's buffers"))))
(setq tabbar-buffer-groups-function 'tabbar-ruler-group-user-buffers-helper-dired)

;; 切换主题后刷新tabbar背景色
(defadvice enable-theme(after enable-theme-after activate)
  (tabbar-install-faces)
  (copy-face 'font-lock-function-name-face 'tabbar-selected)
  )
(defadvice disable-theme(after disable-theme-after activate)
  (tabbar-install-faces)
  (copy-face 'font-lock-function-name-face 'tabbar-selected)
  )
(defadvice make-frame-command(after make-frame-command-after activate)
  (tabbar-install-faces)
  (copy-face 'font-lock-function-name-face 'tabbar-selected)
  )
;; ycmd
;; 文件中不能有当前编码无法识别的字符，否则ycmd会出错
;; 会报(wrong-type-argument number-or-marker-p nil)错误
;; 解决办法：c-x RET f输入utf-8回车，会提示乱码的位置

;; 标准加载方式
;; (require 'ycmd)
;; (add-hook 'after-init-hook #'global-ycmd-mode)
;; (require 'company-ycmd)
;; (company-ycmd-setup)
;; (require 'flycheck-ycmd)
;; (flycheck-ycmd-setup)

;; (autoload 'ycmd-mode "ycmd" nil t)
;; (autoload 'global-ycmd-mode "ycmd" nil t)

(global-set-key (kbd "M-.") (lambda () "" (interactive)
							  (require 'ycmd )
							  (unless (ycmd-running-p) (ycmd-open))
							  (unless ycmd-mode (ycmd-mode 1))
							  (ycmd-goto-imprecise)
							  ))
;; (global-set-key (kbd "M-.") 'ycmd-goto-imprecise)
(global-set-key (kbd "M-p") (lambda () "" (interactive)
							  (require 'ycmd )
							  (unless (ycmd-running-p) (ycmd-open))
							  (unless ycmd-mode (ycmd-mode 1))
							  (ycmd-get-type t)
							  ))
;; (global-set-key (kbd "M-p") 'ycmd-get-type)
(global-set-key (kbd "C-.") (lambda () "" (interactive)
							  (require 'ycmd )
							  (unless (ycmd-running-p) (ycmd-open))
							  (unless ycmd-mode (ycmd-mode 1))
							  (ycmd-get-parent)
							  ))
(global-set-key (kbd "C-c p") 'ycmd-get-type)
(global-set-key (kbd "C-c o") 'ycmd-goto)

(global-set-key (kbd "C-c t") 'ycmd-fixit)

(eval-after-load "company-ycmd"
  '(progn
	 ;; 让company-ycmd能够在字符串和注释中补全
	 (defun company-ycmd--prefix-fset ()
	   "Prefix-command handler for the company backend."
	   (and ycmd-mode
			buffer-file-name
			(ycmd-running-p)
			;; (or (not (company-in-string-or-comment))
			;; 	(company-ycmd--in-include))
			(or (company-grab-symbol-cons "\\.\\|->\\|::\\|/" 2)
				'stop)))
	 (fset 'company-ycmd--prefix 'company-ycmd--prefix-fset)))

(eval-after-load "ycmd"
  '(progn
	 (defun ycmd--options-contents-fset (hmac-secret)
	   ""
	   (let ((hmac-secret (base64-encode-string hmac-secret))
			 (global-config (or ycmd-global-config ""))
			 (extra-conf-whitelist (or ycmd-extra-conf-whitelist []))
			 (confirm-extra-conf (if (eq ycmd-extra-conf-handler 'load) 0 1))
			 (gocode-binary-path (or ycmd-gocode-binary-path ""))
			 (godef-binary-path (or ycmd-godef-binary-path ""))
			 (rust-src-path (or ycmd-rust-src-path ""))
			 (racerd-binary-path (or ycmd-racerd-binary-path ""))
			 (python-binary-path (or ycmd-python-binary-path "")))
		 `((filepath_completion_use_working_dir . 0)
		   (auto_trigger . 1)
		   (min_num_of_chars_for_completion . 2) ;写死2，保证server 2个字符就可以补全
		   (min_num_identifier_candidate_chars . 0)
		   (semantic_triggers . ())
		   (filetype_specific_completion_to_disable (gitcommit . 1))
		   (collect_identifiers_from_comments_and_strings . 0)
		   (max_num_identifier_candidates . ,ycmd-max-num-identifier-candidates)
		   (extra_conf_globlist . ,extra-conf-whitelist)
		   (global_ycm_extra_conf . ,global-config)
		   (confirm_extra_conf . ,confirm-extra-conf)
		   (max_diagnostics_to_display . 1000) ;原来是30
		   (auto_start_csharp_server . 1)
		   (auto_stop_csharp_server . 1)
		   (use_ultisnips_completer . 1)
		   (csharp_server_port . 0)
		   (hmac_secret . ,hmac-secret)
		   (server_keep_logfiles . 1)
		   (gocode_binary_path . ,gocode-binary-path)
		   (godef_binary_path . ,godef-binary-path)
		   (rust_src_path . ,rust-src-path)
		   (racerd_binary_path . ,racerd-binary-path)
		   (python_binary_path . ,python-binary-path))))
	 (fset 'ycmd--options-contents 'ycmd--options-contents-fset)
	 ))

;; -u解决hang的问题
;; (set-variable 'ycmd-server-command '("c:/python27/python.exe" "-u" "D:/ycmd-master/ycmd"))
(setq ycmd-server-command (list "python" (expand-file-name "~/ycmd/ycmd")))

(set-variable 'ycmd-global-config "C:/Users/g00280886/AppData/Roaming/global_config.py")
(setq ycmd-extra-conf-handler 'load)
;; (setq ycmd--log-enabled t)
(setq url-show-status nil)
;; (setq ycmd-request-message-level -1)
(setq request-message-level -1)

(eval-after-load "ycmd"
  '(progn
	 (message "ycmd")
	 (global-ycmd-mode 1)
	 (require 'company-ycmd)  
	 (company-ycmd-setup)
	 (global-company-mode 1)
     (global-srecode-minor-mode t)
     (yas-global-mode 1)
     (require 'taglist)
     (add-hook 'ycmd-file-parse-result-hook 'tag-list-update-safe-for-ycmd)

	 ;; 起个定时器刷新
	 (setq reparse-timer (run-at-time 5 3 'reparse-current-buffer))

	 (defun do-reparse ()
	   (message "do reparse and ycmd timer deactive")
	   (ycmd--conditional-parse)
	   (cancel-timer reparse-timer))
	 
	 (defun reparse-current-buffer ()
	   ""
	   (interactive "")
	   (company-ycmd--init)
	   (when (bound-and-true-p ycmd-mode)
		 (message "reparse ycmd timer active")
		 (cond ((or (eq ycmd--last-status-change 'unparsed)
					(eq ycmd--last-status-change 'errored))
				(do-reparse))
			   ((eq ycmd--last-status-change 'parsed)
				(cancel-timer reparse-timer)))))
	 
	 ;; (add-hook 'c-mode-common-hook
	 ;; 		   (lambda ()
	 ;; 			 (setq reparse-timer (run-at-time 5 3 'reparse-current-buffer))
	 ;; 			 ))

	 ;; 强制用语法补全，函数参数，全局变量等都能补
	 (defun company-ycmd-semantic-complete ()
	   (interactive)
	   (let ((ycmd-force-semantic-completion t))
		 (company-complete)))
	 (global-set-key (kbd "<M-S-return>") 'company-ycmd-semantic-complete)
	 
	 (require 'flycheck-ycmd)
	 ;; 下面函数有bug，由于路径中存在反斜杠导致flycheck的错误无法显示
	 (defun flycheck-ycmd--result-to-error-fset (result checker)
	   "Convert ycmd parse RESULT for CHECKER into a flycheck error object."
	   (let-alist result
		 (when (string-equal (replace-regexp-in-string "\\\\" "/" .location.filepath ) (buffer-file-name))
		   (flycheck-error-new
			:line .location.line_num
			:column .location.column_num
			:buffer (current-buffer)
			:filename .location.filepath
			:message (concat .text (when (eq .fixit_available t) " (FixIt)"))
			:checker checker
			:level (assoc-default .kind flycheck-ycmd--level-map 'string-equal 'error)))))
	 (fset 'flycheck-ycmd--result-to-error 'flycheck-ycmd--result-to-error-fset)
	 (flycheck-ycmd-setup)
	 (global-flycheck-mode 1)

     (unless (featurep 'lsp-mode)
       (require 'ycmd-eldoc)
       (add-hook 'ycmd-mode-hook 'ycmd-eldoc-mode)
       (global-eldoc-mode 1)
       (unless (< (* 150 1024) (buffer-size))
         (ycmd-eldoc-mode +1)))

	 ;; (setq ycmd-force-semantic-completion t)
	 ))

;; imenu list
(autoload 'imenu-list-smart-toggle "imenu-list" nil t)
(global-set-key (kbd "M-Q") 'imenu-list-smart-toggle) ;不要直接用imenu-list命令，因为不起timer，无法自动刷新

;; spacemacs
(require 'spaceline-config)
(spaceline-helm-mode 1)
(spaceline-info-mode 1)
(setq anzu-cons-mode-line-p nil)		;防止有两个anzu

;; 用diminish控制minor mode的显示
(require 'diminish)
;; (eval-after-load "auto-complete" '(diminish 'auto-complete-mode))
(eval-after-load "anzu" '(diminish 'anzu-mode))
(eval-after-load "hideif" '(diminish 'hide-ifdef-mode))
(eval-after-load "hideshow" '(diminish 'hs-minor-mode))
;; (eval-after-load "helm-gtags" '(diminish 'helm-gtags-mode " HG"))
(eval-after-load "helm-gtags" '(diminish 'helm-gtags-mode))
(eval-after-load "yasnippet" '(diminish 'yas-minor-mode))

;; 鼠标指向dos处时，弹出文件编码信息
(spaceline-define-segment buffer-encoding-abbrev-mouse
  "The line ending convention used in the buffer with mouse prompt of buffer encoding info."
  (let ((buf-coding (format "%s" buffer-file-coding-system)))
    (if (string-match "\\(dos\\|unix\\|mac\\)" buf-coding)
        (setq buf-coding (match-string 1 buf-coding))
      buf-coding)
	(propertize buf-coding
				'help-echo (if buffer-file-coding-system
							   (format "Buffer coding system (%s): %s
mouse-1: Describe coding system
mouse-3: Set coding system"
									   (if enable-multibyte-characters "multi-byte" "unibyte")
									   (symbol-name buffer-file-coding-system))
							 "Buffer coding system: none specified"))))

;; 让which-func强制刷新
(spaceline-define-segment which-function-ignore-active
  (when (bound-and-true-p which-function-mode)
    (let* ((current (format-mode-line which-func-current)))
      (when (string-match "{\\(.*\\)}" current)
        (setq current (match-string 1 current)))
      (propertize current
                  'local-map which-func-keymap
                  'face 'which-func
                  'mouse-face 'mode-line-highlight
                  'help-echo "mouse-1: go to beginning\n\
mouse-2: toggle rest visibility\n\
mouse-3: go to end"))))

;; 自定义theme使用上面两个segment
(defun spaceline--theme-mod (left second-left &rest additional-segments)
  "Convenience function for the spacemacs and emacs themes."
  (spaceline-install `(,left
					   anzu
					   auto-compile
					   ,second-left
					   major-mode
					   (process :when active)
					   ((flycheck-error flycheck-warning flycheck-info)
						:when active)
					   (minor-modes :when active)
					   (mu4e-alert-segment :when active)
					   (erc-track :when active)
					   (version-control :when active)
					   (org-pomodoro :when active)
					   (org-clock :when active)
					   nyan-cat)

    `(which-function-ignore-active
      (python-pyvenv :fallback python-pyenv)
      (battery :when active)
      selection-info
      input-method
      ((buffer-encoding-abbrev-mouse
        point-position
        line-column)
       :separator " | ")
      (global :when active)
      ,@additional-segments
      buffer-position
      hud))

  (setq-default mode-line-format '("%e" (:eval (spaceline-ml-main)))))

(defun spaceline-emacs-theme-mod (&rest additional-segments)
  "Install a modeline close to the one used by Spacemacs, but which
looks better without third-party dependencies.

ADDITIONAL-SEGMENTS are inserted on the right, between `global' and
`buffer-position'."
  (apply 'spaceline--theme-mod
         '(((((persp-name :fallback workspace-number)
              window-number) :separator "|")
            buffer-modified
            buffer-size)
           :face highlight-face)
         '(buffer-id remote-host)
         additional-segments))

(spaceline-emacs-theme-mod)

;; org screenshort
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
(setq org-agenda-files (list "c:/Users/g00280886/Desktop/task.org"))
(global-set-key (kbd "C-c l") 'org-agenda)

;; taglist
(autoload 'taglist-list-tags "taglist" nil t)
(global-set-key (kbd "M-q") 'taglist-list-tags)

;; rg
(autoload 'rg "rg" nil t )
(autoload 'rg-dwim "rg" nil t )
(eval-after-load "rg"
  '(progn
     (rg-enable-default-bindings (kbd "C-c w"))
     (add-hook 'rg-mode-hook 'wgrep-ag-setup)
     (defun rg-save-search-as-name-fset ()
       ""
       (interactive)
       (let ((buffer (rg-rename-target)))
         (with-current-buffer buffer
           (rename-buffer (concat "*rg " (nth 0 rg-last-search) "*")))))
     (defun rg-list-searches-fset ()
       "List all `rg-mode' buffers in `ibuffer'."
       (interactive)
       (let ((other-window (equal current-prefix-arg '(4))))
         (ibuffer other-window rg-search-list-buffer-name '((mode . rg-mode)) nil nil nil
                  '((mark " "
                          (name 16 16 nil :elide) " "
                          (rg-search-term 28 28 nil :elide) " "
                          (rg-hit-count 7 7) " "
                          (rg-file-types 7 7) " "
                          (process 10 10)
                          (rg-search-dir 20 -1 nil :elide) " ")))
         (add-hook 'rg-filter-hook #'rg-ibuffer-search-updated)
         (add-hook 'buffer-list-update-hook #'rg-ibuffer-search-updated)
         (with-current-buffer rg-search-list-buffer-name
           (set (make-local-variable 'ibuffer-use-header-line) nil)
           (ibuffer-clear-filter-groups)
           (add-hook 'kill-buffer-hook #'rg-ibuffer-buffer-killed nil t))))
     
     ;; (fset 'rg-save-search-as-name 'rg-save-search-as-name-fset)
     (define-key rg-mode-map "s" 'rg-save-search-as-name-fset)
     (define-key rg-mode-map "l" 'rg-list-searches-fset)
     ))

;; cquery 全面的开发工具
(add-to-list 'load-path (concat site-lisp-directory "/cquery/ht.el") ) 

(with-eval-after-load 'lsp-mode
  ;; (require 'lsp-flycheck)
  (global-flycheck-mode t)
  
  (yas-global-mode t)
  (require 'company-lsp)
  (push 'company-lsp company-backends)
  (global-company-mode t)
  ;; (setq company-lsp-async t)
  ;; (setq company-lsp-cache-candidates t)
  ;; (setq company-lsp-enable-recompletion t) ;比如第一次补全出std::，会继续补
  (require 'lsp-imenu)
  (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  ;; (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-flycheck-enable nil)
  ;; (setq lsp-ui-imenu-enable nil)
  ;; (setq lsp-ui-peek-enable nil)
  ;; (setq lsp-ui-sideline-enable nil)

  (require 'helm-xref)
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  (require 'ivy-xref)
  ;; (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  ;; (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (define-key ivy-minibuffer-map (kbd "C-M-m") 'ivy-partial-or-done)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-call)

  (global-set-key (kbd "M-.") 'xref-find-definitions)
  ;; (global-set-key (kbd "M-,") 'xref-pop-marker-stack)

  ;; 以下是在xref中定义的快捷键
;;;(define-key esc-map "?" #'xref-find-references)
;;;(define-key esc-map [?\C-.] #'xref-find-apropos)
;;;(define-key ctl-x-4-map "." #'xref-find-definitions-other-window)
;;;(define-key ctl-x-5-map "." #'xref-find-definitions-other-frame)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (remove-function (local 'eldoc-documentation-function) 'ycmd-eldoc--documentation-function)))
  )
(autoload 'lsp-cquery-enable "cquery" nil t)
(with-eval-after-load 'cquery
  ;; (setq cquery-executable "f:/cquery/cquery/build/release/bin/cquery")
  (setq cquery-executable (expand-file-name "~/cquery/build/release/bin/cquery"))
  ;; (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack")) ;; msgpack占用空间小，但是查看困难，并且结构体变更，要手动更新索引
  ;; (setq cquery-extra-init-params '(:indexWhitelist ("COMMON/include" "MPLS" "OPEN_SRC/protobuf-c-1.2.1") :indexBlacklist (".")))
  ;; (setq cquery-extra-init-params '(:indexBlacklist ("DIRA" "DIRB"))) :completion (:detailedLabel t) 
  (setq cquery-extra-init-params '(:xref (:container t)))

  ;; (setq cquery-extra-args '("--log-stdin-stdout-to-stderr" "--log-file=/tmp/cq.log"))
;;;; enable semantic highlighting:
  (setq cquery-sem-highlight-method 'overlay)
  ;; (setq cquery-sem-highlight-method 'font-lock)
  (add-hook 'c-mode-common-hook 'lsp-cquery-enable)
  (define-key cquery-tree-mode-map (kbd "SPC") 'cquery-tree-press)
  (define-key cquery-tree-mode-map (kbd "n") (lambda () "" (interactive)
                                               (forward-line 1)
                                               (back-to-indentation)))
  (define-key cquery-tree-mode-map (kbd "p") (lambda () "" (interactive)
                                               (forward-line -1)
                                               (back-to-indentation)))

  (define-key cquery-tree-mode-map [mouse-1] 'ignore )
  (define-key cquery-tree-mode-map [mouse-3] 'cquery-tree-toggle-expand )
  ;; (cquery-use-default-rainbow-sem-highlight)
  ;; 其他功能
  ;; (cquery-xref-find-custom "$cquery/base")
  ;; (cquery-xref-find-custom "$cquery/callers")
  ;; (cquery-xref-find-custom "$cquery/derived")
  ;; (cquery-xref-find-custom "$cquery/vars")
  (defun cquery-tree--make-prefix-fset (node number nchildren depth)
    "."
    (let* ((padding (if (= depth 0) "" (make-string (* 2 (- depth 1)) ?\ )))
           (symbol (if (= depth 0)
                       (if (cquery-tree-node-parent node)
                           "< "
                         "")
                     (if (cquery-tree-node-has-children node)
                         (if (cquery-tree-node-expanded node) "└-" "└+")
                       (if (eq number (- nchildren 1)) "└╸" "├╸")))))
      (concat padding (propertize symbol 'face 'cquery-tree-icon-face))))
  (fset 'cquery-tree--make-prefix 'cquery-tree--make-prefix-fset)
  
  )

;; clipmon监视剪贴板
(autoload 'clipmon-mode "clipmon" nil t)
;; clipmon-autoinsert-toggle 自动插入当前buffer

;;-----------------------------------------------------------plugin end-----------------------------------------------------------;;

;;-----------------------------------------------------------define func begin----------------------------------------------------;;
;; 资源管理器中打开
(defun open-in-desktop-select (&optional dired)
  (interactive "P")
  (let ((file (buffer-name)))
	(if dired
		;; (setq file (dired-get-filename 'no-dir)) ;xp
		(setq file (replace-regexp-in-string "/" "\\\\" (dired-get-filename) )) ;win7
	  ;; (setq file (file-name-nondirectory (buffer-file-name) )) ;xp
	  (setq file (replace-regexp-in-string "/" "\\\\" (buffer-file-name) ))) ;win7
	(call-process-shell-command (concat "explorer" "/select," file))
	)
  )


(defun open-in-desktop-select-dired(arg)
  (interactive "P")
  (open-in-desktop-select t)
  )

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

(defun hif-overlay-at (position)
  "An imitation of the one in hide-show --lgfang"
  (let ((overlays (overlays-at position))
        ov found)
    (while (and (not found) (setq ov (car overlays)))
      (setq found (eq (overlay-get ov 'invisible) 'hide-ifdef)
            overlays (cdr overlays)))
    found))

;; #if 0灰色
;; (defun my-c-mode-font-lock-if0 (limit)
;;   (save-restriction
;; 	(widen)
;; 	(save-excursion
;; 	  (goto-char (point-min)) ;;性能太差
;; 	  ;; (goto-char (search-backward "#if 0"))
;; 	  (let ((depth 0) str start start-depth)
;; 		(while (re-search-forward "^\\s-*#\\s-*\\(if\\|else\\|endif\\)" limit 'move)
;; 		  (setq str (match-string 1))
;; 		  (if (string= str "if")
;; 			  (progn
;; 				(setq depth (1+ depth))
;; 				(when (and (null start) (looking-at "\\s-+0"))
;; 				  (setq start (match-end 0)
;; 						start-depth depth)))
;; 			(when (and start (= depth start-depth))
;; 			  (c-put-font-lock-face start (match-beginning 0) 'window-divider)
;; 			  (setq start nil))
;; 			(when (string= str "endif")
;; 			  (setq depth (1- depth)))))
;; 		(when (and start (> depth 0))
;; 		  (c-put-font-lock-face start (point) 'window-divider)))))
;;   nil)

;; (defun my-c-mode-common-hook-if0 ()
;;   (font-lock-add-keywords
;;    nil
;;    '((my-c-mode-font-lock-if0 (0 shadow prepend))) 'add-to-end))

;; (eval-after-load "cpp"
;;   '(progn
;; 	 (defun cpp-highlight-buffer-fset (arg)
;; 	   ""
;; 	   (interactive "P")
;; 	   (unless (or (eq t buffer-invisibility-spec)
;; 				   (memq 'cpp buffer-invisibility-spec))
;; 		 (add-to-invisibility-spec 'cpp))
;; 	   (setq cpp-parse-symbols nil)
;; 	   (cpp-parse-reset)
;; 	   (if (null cpp-edit-list)
;; 		   (cpp-edit-load))
;; 	   (let (cpp-state-stack)
;; 		 (save-excursion
;; 		   (goto-char (point-min))
;; 		   (cpp-progress-message "Parsing...")
;; 		   (while (re-search-forward cpp-parse-regexp nil t)
;; 			 (cpp-progress-message "Parsing...%d%%"
;; 								   (floor (* 100.0 (- (point) (point-min)))
;; 										  (buffer-size)))
;; 			 (let ((match (replace-regexp-in-string "\^M" "" (buffer-substring (match-beginning 0) (match-end 0)))))
;; 			   (cond ((or (string-equal match "'")
;; 						  (string-equal match "\""))
;; 					  (goto-char (match-beginning 0))
;; 					  (condition-case nil
;; 						  (forward-sexp)
;; 						(error (cpp-parse-error
;; 								"Unterminated string or character"))))
;; 					 ((string-equal match "/*")
;; 					  (or (search-forward "*/" nil t)
;; 						  (error "Unterminated comment")))
;; 					 ((string-equal match "//")
;; 					  (skip-chars-forward "^\n\r"))
;; 					 (t
;; 					  (end-of-line 1)
;; 					  (let ((from (match-beginning 1))
;; 							(to (1+ (point)))
;; 							(type (replace-regexp-in-string "\^M" "" (buffer-substring (match-beginning 2)
;; 													(match-end 2))))
;; 							(expr (replace-regexp-in-string "\^M" "" (buffer-substring (match-end 1) (point))))) ;原来的代码处理不了^M
;; 						(cond ((string-equal type "ifdef")
;; 							   (cpp-parse-open t expr from to))
;; 							  ((string-equal type "ifndef")
;; 							   (cpp-parse-open nil expr from to))
;; 							  ((string-equal type "if")
;; 							   (cpp-parse-open t expr from to))
;; 							  ((string-equal type "elif")
;; 							   (let (cpp-known-face cpp-unknown-face)
;; 								 (cpp-parse-close from to))
;; 							   (cpp-parse-open t expr from to))
;; 							  ((string-equal type "else")
;; 							   (or cpp-state-stack
;; 								   (cpp-parse-error "Top level #else"))
;; 							   (let ((entry (list (not (nth 0 (car cpp-state-stack)))
;; 												  (nth 1 (car cpp-state-stack))
;; 												  from to)))
;; 								 (cpp-parse-close from to)
;; 								 (setq cpp-state-stack (cons entry cpp-state-stack))))
;; 							  ((string-equal type "endif")
;; 							   (cpp-parse-close from to))
;; 							  (t
;; 							   (cpp-parse-error "Parser error"))))))))
;; 		   (message "Parsing...done"))
;; 		 (if cpp-state-stack
;; 			 (save-excursion
;; 			   (goto-char (nth 3 (car cpp-state-stack)))
;; 			   (cpp-parse-error "Unclosed conditional"))))
;; 	   (or arg
;; 		   (null cpp-parse-symbols)
;; 		   (cpp-parse-edit)))

;; 	 (fset 'cpp-highlight-buffer 'cpp-highlight-buffer-fset)
;; 	 ))

;; (defun cpp-highlight-if-0/1 ()
;;   "Modify the face of text in between #if 0 ... #endif."
;;   (interactive)
;;   (setq cpp-known-face '(foreground-color . "dim gray"))
;;   (setq cpp-unknown-face 'default)
;;   (setq cpp-face-type 'dark)
;;   (setq cpp-known-writable 't)
;;   (setq cpp-unknown-writable 't)
;;   (setq cpp-edit-list
;;         '((#("1" 0 1
;;              (fontified nil))
;;            nil
;;            (foreground-color . "dim gray")
;;            both nil)
;;           (#("0" 0 1
;;              (fontified nil))
;;            (foreground-color . "dim gray")
;;            nil
;;            both nil)))
;;   (cpp-highlight-buffer t))


;; (defun jpk/c-mode-hook ()
;;   (cpp-highlight-if-0/1)
;;   (add-hook 'after-save-hook 'cpp-highlight-if-0/1 'append 'local)
;;   )

;; (add-hook 'after-revert-hook 'cpp-highlight-if-0/1)

;; 预定义宏
;; (setq hide-ifdef-define-alist 
;;       '( (list-name-1 GPATH_* HAVE_FUNC_2) 
;;          (list-name-2 HAVE_HEADER_1) ) ) 
;; (add-hook 'hide-ifdef-mode-hook 
;;           '(lambda () (hide-ifdef-use-define-alist 'list-name-1) ) ) 

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

(global-set-key "\M-'" 'qiang-comment-dwim-line) ;; 已有comment-line c-x c-;代替


;; 拷贝代码自动格式化默认是粘贴完后按c-m-\会格式化粘贴内容)
(dolist (command '(yank yank-pop))
  (eval
   `(defadvice ,command (after indent-region activate)
	  (and (not current-prefix-arg)
		   (member major-mode
				   '(emacs-lisp-mode
					 lisp-mode
					 c-mode
					 c++-mode
					 ))
		   (let ((mark-even-if-inactive transient-mark-mode))
			 (indent-region (region-beginning) (region-end) nil))))))

;; 跳到匹配的括号处
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
  (cua-set-mark)
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
(global-set-key (kbd "<C-f4>") 'open-in-desktop-select)

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

(defun setup-program-keybindings()
  (interactive)
  (local-set-key (kbd "<f12>") 'semantic-ia-fast-jump)
  (local-set-key (kbd "<S-f12>") 'semantic-complete-jump)
  (local-set-key (kbd "M-`") 'ia-fast-jump-other)
  (local-set-key (kbd "<C-f12>") 'semantic-symref-just-symbol)
  (local-set-key (kbd "<M-S-f12>") 'semantic-symref-anything)
  (local-set-key (kbd "<C-S-f12>") 'semantic-symref)
  (local-set-key (kbd "<M-f12>") 'semantic-analyze-proto-impl-toggle)
  (local-set-key (kbd "<M-down>") 'senator-next-tag)
  (local-set-key (kbd "<M-up>") 'senator-previous-tag)
  )

;;hide ^M
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; symref加强
(eval-after-load "cc-mode"
  '(progn
	 (require 'semantic/symref/list )
	 ))

;; 解决symref result中用鼠标点结果时会在当前窗口打开,中键不好使，用右键
(defun symref-results-right-click-event (event)
  ""
  (interactive "e")
  (mouse-set-point event)
  (push-button))

;; 重写cedet函数 begin
(eval-after-load "cedet-global"
  '(progn
	 (defun cedet-gnu-global-search-fset (searchtext texttype type scope)
	   "add -s"
	   (let ((flgs (cond ((eq type 'file)
						  "-a")
						 (t "-xa")))
			 (scopeflgs (cond
						 ((eq scope 'project)
						  ""
						  )
						 ((eq scope 'target)
						  "l")))
			 (stflag (cond ((or (eq texttype 'tagname)
								(eq texttype 'tagregexp))
							"")
						   ((eq texttype 'tagcompletions)
							"c")
						   ((eq texttype 'regexp)
							"g")
						   ((eq texttype 'symbolname)
							"s")
						   (t "r"))))
		 (cedet-gnu-global-call (list (concat flgs scopeflgs stflag)
									  searchtext))))

	 (fset 'cedet-gnu-global-search 'cedet-gnu-global-search-fset)
	 ))


(defun semantic-symref-hit-to-tag-via-buffer-fset (hit searchtxt searchtype &optional open-buffers)
  "avoid missing reference"
  (let* ((line (car hit))
		 (file (cdr hit))
		 (buff (find-buffer-visiting file))
		 (tag nil)
		 (tagList nil)
		 (whichFunc nil)
		 )
    (cond
     ;; We have a buffer already.  Check it out.
     (buff
      (set-buffer buff))

     ;; We have a table, but it needs a refresh.
     ;; This means we should load in that buffer.
     (t
      (let ((kbuff
			 (if open-buffers
				 ;; Even if we keep the buffers open, don't
				 ;; let EDE ask lots of questions.
				 (let ((ede-auto-add-method 'never))
				   (find-file-noselect file t))
			   ;; When not keeping the buffers open, then
			   ;; don't setup all the fancy froo-froo features
			   ;; either.
			   (semantic-find-file-noselect file t))))
		(set-buffer kbuff)
		(push kbuff semantic-symref-recently-opened-buffers)
		(semantic-fetch-tags)
		))
     )

    ;; Too much baggage in goto-line
    ;; (goto-line line)
    (goto-char (point-min))
    (forward-line (1- line))

    ;; Search forward for the matching text
    (when (re-search-forward searchtxt
							 (point-at-eol)
							 t)
      (goto-char (match-beginning 0))
      )

    (setq tag (semantic-current-tag))
	(unless (zerop (current-indentation))
	  (setq whichFunc (which-function)))
    ;; If we are searching for a tag, but bound the tag we are looking
    ;; for, see if it resides in some other parent tag.
    ;;
    ;; If there is no parent tag, then we still need to hang the originator
    ;; in our list.
    (when (and (eq searchtype 'symbol)
			   (string= (semantic-tag-name tag) searchtxt))
      (setq tag (or (semantic-current-tag-parent) tag)))

	;; 找不到tag时，使用which-fuction匹配本文件所有tag来查
	(unless tag
	  (let ((foundFlag-p nil )
			(i 0))

		(setq tagList (semantic-fetch-tags))
		(while (and
				(not foundFlag-p)
				(<= i (length tagList)))

		  ;; if found, set foundFlag-p
		  
		  (when (equal (semantic-tag-name (elt tagList i)) whichFunc)
			(setq foundFlag-p t )
			(setq tag (elt tagList i)))

		  (setq i (1+ i))))
	  )
	;; 再找不到就创建一个空tag
	(unless tag
	  (setq tag (semantic-tag "/* COMMENT */" 'variable))
	  (semantic--tag-put-property tag :filename (buffer-file-name)))

    ;; Copy the tag, which adds a :filename property.
    (when tag
      (setq tag (semantic-tag-copy tag nil t))
      ;; Ad this hit to the tag.
      (semantic--tag-put-property tag :hit (list line)))
    tag))
(eval-after-load "symref"
  '(progn
	 (fset 'semantic-symref-hit-to-tag-via-buffer 'semantic-symref-hit-to-tag-via-buffer-fset)))

;; semantic-symref-results-dump是symref生成按钮的函数
(defun semantic-symref-produce-list-on-results-fset (res str)
  "(semantic-symref-result-get-tags res nil)"
  (when (not res) (error "No references found"))
  (semantic-symref-result-get-tags res nil)
  (message "Gathering References...done")
  ;; Build a references buffer.
  (let ((buff (get-buffer-create (format "*Symref %s" str))))
    (switch-to-buffer-other-window buff)
    (set-buffer buff)
    (semantic-symref-results-mode)
    (set (make-local-variable 'semantic-symref-current-results) res)
    (semantic-symref-results-dump res)
    (goto-char (point-min))))


(defun semantic-symref-rb-toggle-expand-tag-fset (&optional button)
  "kill non-open buffer and add line num"
  (interactive)
  (let* ((tag (button-get button 'tag))
		 (kill-flag t)
		 (all-buff-list (buffer-list))
		 (buff (semantic-tag-buffer tag))
		 (hits (semantic--tag-get-property tag :hit))
		 (state (button-get button 'state))
		 (text nil))
	
	(let ((foundFlag-p nil )
		  (tag-filename (semantic--tag-get-property tag :filename))
		  (i 0))

	  (while (and
			  (not foundFlag-p)
			  (<= i (length all-buff-list)))

		;; if found, set foundFlag-p
		
		(when (and (buffer-live-p (elt all-buff-list i))
				   (equal (buffer-file-name (elt all-buff-list i)) tag-filename))
		  (setq foundFlag-p t )
		  (setq kill-flag nil))

		(setq i (1+ i))))

    (cond
     ((eq state 'closed)
      (with-current-buffer buff
		(dolist (H hits)
		  (goto-char (point-min))
		  (forward-line (1- H))
		  (beginning-of-line)
		  (back-to-indentation)
		  (setq text (cons (buffer-substring (point) (point-at-eol)) text)))
		(setq text (nreverse text)))
      (goto-char (button-start button))
      (forward-char 1)
      (let ((inhibit-read-only t))
		(delete-char 1)
		(insert "-")
		(button-put button 'state 'open)
		(save-excursion
		  (end-of-line)
		  (while text
			(insert "\n")
			(insert "    ")
			(insert-button (format "[%s] %s" (car hits) (car text))
						   'mouse-face 'highlight
						   'face nil
						   'action 'semantic-symref-rb-goto-match
						   'tag tag
						   'line (car hits))
			(setq text (cdr text)
				  hits (cdr hits))))))
     ((eq state 'open)
      (let ((inhibit-read-only t))
		(button-put button 'state 'closed)
		;; Delete the various bits.
		(goto-char (button-start button))
		(forward-char 1)
		(delete-char 1)
		(insert "+")
		(save-excursion
		  (end-of-line)
		  (forward-char 1)
		  (delete-region (point)
						 (save-excursion
						   (forward-char 1)
						   (forward-line (length hits))
						   (point)))))))
	(if kill-flag
		(kill-buffer buff))
	))

(defun semantic-tag-buffer-fset (tag)
  "打开文件不记入recentf，并且打开较快，用完后最好手动kill"
  (let ((buff (semantic-tag-in-buffer-p tag)))
    (if buff
		buff
      ;; TAG has an originating file, read that file into a buffer, and
      ;; return it.
	  (if (semantic--tag-get-property tag :filename)
		  (save-match-data
			(semantic-find-file-noselect (semantic--tag-get-property tag :filename) t))
		;; TAG is not in Emacs right now, no buffer is available.
		))))

(fset 'semantic-tag-buffer 'semantic-tag-buffer-fset)

(defun semantic-symref-fset ()
  ""
  (interactive)
  (semantic-fetch-tags)
  (let (symbol res)
	(setq symbol (semantic-current-tag))
	;; Gather results and tags
	(message "Gathering References for %s ..." (semantic-tag-name symbol))
	(setq res (semantic-symref-find-references-by-name (semantic-tag-name symbol)))
	(semantic-symref-produce-list-on-results res (semantic-tag-name symbol))))

(eval-after-load "list"
  '(progn
	 (fset 'semantic-symref-rb-toggle-expand-tag 'semantic-symref-rb-toggle-expand-tag-fset)
	 (fset 'semantic-symref 'semantic-symref-fset)
	 (fset 'semantic-symref-produce-list-on-results 'semantic-symref-produce-list-on-results-fset)
     ;; (fset 'semantic-symref-results-dump 'semantic-symref-results-dump-fset)
     ;; (fset 'semantic-symref-rb-toggle-expand-tag 'semantic-symref-rb-toggle-expand-tag-fset)
     ))

;; 重写cedet函数 end

(defun semantic-symref-find-references-by-symbolname (name &optional scope tool-return)
  ""
  (interactive "sName: ")
  (let* ((inst (semantic-symref-instantiate
				:searchfor name
				:searchtype 'symbolname
				:searchscope (or scope 'project)
				:resulttype 'line))
		 (result (semantic-symref-get-result inst)))
	(when tool-return
	  (set tool-return inst))
	(prog1
		(setq semantic-symref-last-result result)
	  (when (called-interactively-p 'interactive)
		(semantic-symref-data-debug-last-result))))
  )

;; 在symref result里继续symref
(defun symref-in-result()
  ""
  (interactive)
  (let (symbol res flag)
	(setq symbol (thing-at-point 'symbol))
	(setq flag nil)
	(walk-windows
	 #'(lambda (w)
		 (unless flag
		   (other-window 1)
		   (while (or (eq major-mode 'c-mode)
					  (eq major-mode 'c++-mode))
			 ;; (push-button)
			 ;; Gather results and tags
			 (message "Gathering References for %s ..." symbol)
			 (setq res (cond
						((semantic-symref-find-references-by-name symbol))
						((semantic-symref-find-references-by-symbolname symbol))))
			 (semantic-symref-produce-list-on-results res symbol)
			 (setq flag t))
		   )))))


(defun semantic-symref-just-symbol (&optional text)
  ""
  (interactive "*P")
  (semantic-fetch-tags)
  (let (symbol res)
	(setq symbol (thing-at-point 'symbol))
	(if (or text (not symbol))
		(setq symbol (grep-read-regexp)))
	(if (eq text 0)
		(setq symbol (concat "\\<" symbol "\\>")))
	;; Gather results and tags
	(message "Gathering References for %s ..." symbol)
	(setq res (cond
			   ((semantic-symref-find-references-by-name symbol))
			   ((semantic-symref-find-references-by-symbolname symbol))))
	(semantic-symref-produce-list-on-results res symbol)))

(defun semantic-symref-anything (&optional text)
  ""
  (interactive "*P")
  (semantic-fetch-tags)
  (let (symbol res)
	(setq symbol (thing-at-point 'symbol))
	(if (or text (not symbol))
		(setq symbol (grep-read-regexp)))
	(if (eq text 0)
		(setq symbol (concat "\\<" symbol "\\>")))
	;; Gather results and tags
	(message "Gathering References for %s ..." symbol)
	(setq res (semantic-symref-find-text symbol))
	(semantic-symref-produce-list-on-results res symbol)))

(defun semantic-pop-tag-mark ()             
  "popup the tag save by semantic-goto-definition"   
  (interactive)                                                    
  (if (ring-empty-p semantic-tags-location-ring)                   
	  (message "%s" "No more tags available")                      
	(let* ((marker (ring-remove semantic-tags-location-ring 0))    
		   (buff (marker-buffer marker))                        
		   (pos (marker-position marker)))                   
	  (if (not buff)                                               
		  (message "Buffer has been deleted")                    
		(switch-to-buffer buff)                                    
		(goto-char pos))                                           
	  (set-marker marker nil nil))))

(dolist (command '(semantic-ia-fast-jump semantic-complete-jump helm-gtags-dwim helm-gtags-find-rtag helm-gtags-find-tag helm-gtags-select helm-gtags-select-path
                                         semantic-decoration-include-visit my-ag ag-this-file occur rgrep gtags-find-tag-by-event ycmd-goto ycmd-goto-imprecise
                                         semantic-analyze-proto-impl-toggle semantic-decoration-include-visit ff-find-other-file semantic-symref-just-symbol
                                         semantic-symref-anything semantic-symref-fset xref-find-definitions xref-find-apropos xref-find-references))
  (eval
   `(defadvice ,command (before jump-mru activate)
      (ring-insert semantic-tags-location-ring (point-marker))
      (unless (featurep 'evil-jumps)
        (require 'evil))
      (when (featurep 'evil-jumps)
        (evil--jumps-push))
      (window-configuration-to-register :prev-win-layout)
      )))


(defadvice helm-gtags-find-tag-other-window (after helm-gtags-tag-other-back activate)
  ""
  (select-window (previous-window)))

(defadvice semantic-symref-hide-buffer (after semantic-symref-hide-buffer-after activate)
  ""
  (jump-to-register :prev-win-layout))

(defun ia-fast-jump-other ()
  (interactive "")
  (let ((pos (point)))
	(save-selected-window
	  (switch-to-buffer-other-window (current-buffer))
	  (goto-char pos)
	  (semantic-ia-fast-jump (point)))
	))

(defun set-c-word-mode ()
  ""
  (interactive)
  ;; (require 'cc-mode)
  ;; (set-syntax-table c++-mode-syntax-table)
  ;; (modify-syntax-entry ?- ".")			;-作为标点符号，起到分隔单词作用
  (modify-syntax-entry ?& ".")
  (modify-syntax-entry ?$ ".")
  (modify-syntax-entry ?< ".")
  (modify-syntax-entry ?> ".")
  (modify-syntax-entry ?= ".")
  (modify-syntax-entry ?/ ".")
  (modify-syntax-entry ?_ "w")
  (modify-syntax-entry ?- "w")
  (setq-local bm-cycle-all-buffers nil))

(global-set-key (kbd "C-+") 'set-c-word-mode)

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
  (when (< (* 150 1024) (buffer-size))
	;; (nlinum-mode -1)
	(setq-local jit-lock-context-time 5)
	(setq-local jit-lock-defer-time 5)
	(setq-local font-lock-maximum-decoration 2)
	(font-lock-refresh-defaults)
	(setq-local semantic-idle-scheduler-idle-time 60)
	(setq-local company-idle-delay 3)
    ;; (if (featurep 'ycmd-eldoc)
    ;;     (setq-local ycmd-mode-hook (delq 'ycmd-eldoc-mode ycmd-mode-hook)))
    (if (featurep 'lsp-mode)
        (setq-local lsp-highlight-symbol-at-point nil))
    (eldoc-mode -1)
    ;; (ad-deactivate 'yank)
    ;; (ad-deactivate 'yank-pop)
    ;; (ad-deactivate 'undo)

	;; (font-lock-mode -1 )
	;; (jit-lock-mode nil)
	;; (diff-hl-mode -1)
	))
;; 大文件不开semantic
;; (add-to-list 'semantic-inhibit-functions
;;              (lambda () (< (* 400 1024) (buffer-size))))

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

;; 选中当前行
(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))

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
	   ;; 					 nil t nil nil defaults))
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
    ))
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
				(else-clause . 0)		; Guessed value
				(extern-lang-close . 0)	; Guessed value
				(func-decl-cont . 0)	; Guessed value
				(inextern-lang . 0)		; Guessed value
				(label . 0)				; Guessed value
				(statement . 0)			; Guessed value
				(statement-block-intro . +) ; Guessed value
				(statement-case-open . 0) ; Guessed value
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
				(comment-intro . c-lineup-comment)
				(composition-close . 0)
				(composition-open . 0)
				(cpp-define-intro . 0)
				(cpp-macro . -1000)
				(cpp-macro-cont . +)
				(do-while-closure . 0)
				(extern-lang-open . 0)
				(friend . 0)
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
				(statement-cont . +)
				(stream-op . c-lineup-streamop)
				(string . -1000)
				(substatement . +)
				(substatement-label . 0)
				(template-args-cont c-lineup-template-args +))))

(add-hook 'c-mode-common-hook
		  (lambda ()
			(modify-syntax-entry ?_ "w")    ;_ 当成单词的一部分
			(c-set-style "gzj")      ;定制C/C++缩进风格,到实际工作环境中要用guess style(main mode菜单里有个style子菜单)来添加详细的缩进风格。Press ‘C-c C-o’ to see the syntax at point
			;; (fci-mode 1)
			(setup-program-keybindings)
			;; (hs-minor-mode 1)
			;; (hide-ifdef-mode 1)
			(setq-local ac-auto-start nil)
			(setq-local indent-tabs-mode nil)
			;; (company-mode 1)
			(abbrev-mode 0)
			;; (flycheck-mode 1)
            ;; (yas-minor-mode 1)          
			;; (my-c-mode-common-hook-if0)
			;; (jpk/c-mode-hook)
			;; (setq-local company-idle-delay 0.5)
			(check-large-file-hook)
			;; (srecode-minor-mode 1)
			(font-lock-add-keywords nil
									'(("\\(\\_<\\(\\w\\|\\s_\\)+\\_>\\)[ 	]*("
									   1  font-lock-function-name-face keep))
									1)
			;; (superword-mode)                ;连字符不分割单词,影响move和edit，但是鼠标双击选择不管用 ，相对subword-mode
			(define-key c-mode-base-map (kbd "C-{") 'my-hif-toggle-block)
			(define-key semantic-symref-results-mode-map (kbd "<C-f12>") 'symref-in-result)
			(define-key semantic-symref-results-mode-map (kbd "s") 'symref-in-result)
            (define-key semantic-symref-results-mode-map [mouse-3] 'symref-results-right-click-event)
			(set-default 'semantic-imenu-summary-function 'semantic-format-tag-uml-abbreviate)
			))

(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(modify-syntax-entry ?- "w")
			(setup-program-keybindings)
			;; (flycheck-mode 1)
            ;; (yas-minor-mode 1)
			;; (hs-minor-mode 1)
			(company-mode 1)
			(setq-local indent-tabs-mode nil)
			(setq-local company-backends (push '(company-capf :with company-yasnippet :with company-dabbrev-code) company-backends))
			))

(add-hook 'dired-mode-hook
		  (lambda ()
			(define-key dired-mode-map "b" 'dired-up-directory)
			(define-key dired-mode-map "e" 'open-in-desktop-select-dired)
			(define-key dired-mode-map (kbd "<C-f3>") 'open-in-desktop-select-dired)
			(define-key dired-mode-map "/" 'isearch-forward)
			(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)
			(define-key dired-mode-map "c" 'create-known-ede-project)
			(define-key dired-mode-map (kbd "M-s") 'er/expand-region)
			(diff-hl-dired-mode 1)
			(dired-async-mode 1)
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
			(company-mode 0)
			))

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(remove-hook 'comint-output-filter-functions 'comint-postoutput-scroll-to-bottom)

;; telnet登录主机后，export LANG=zh_CN.GBK 或 export LC_ALL=en_US.ISO-8859-1 这个管用 ,export LC_CTYPE=zh_CN.GB2312

;; gtags symref 的结果都设置为C语法，主要为了highlight-symbol能正确
(eval-after-load "cc-mode"
  '(progn
	 (dolist (hook '(gtags-select-mode-hook semantic-symref-results-mode-hook cscope-list-entry-hook rscope-list-entry-hook ag-mode-hook))
	   (add-hook hook
				 (lambda()
				   (setq truncate-lines t)
				   (set-syntax-table c++-mode-syntax-table)
				   (modify-syntax-entry ?_ "w")    ;_ 当成单词的一部分
				   )))))

(add-hook 'font-lock-mode-hook
		  (lambda () "DOCSTRING" (interactive)
			(remove-dos-eol)
			))

;; python
(add-hook 'python-mode-hook
          (lambda ()
            ;; (yas-minor-mode 1)
            (setenv "GTAGSLABEL" "pygments")
            (setenv "LANG" "en_US.UTF8"))) ;执行的py脚本中如何有中文字符串时，python shell中不乱码


;; org 设置
;; 显示缩进
(setq org-startup-indented t)
;; org导出pdf, org要用utf-8保存
(setq org-latex-pdf-process (quote ("xelatex -interaction nonstopmode -output-directory %o %f" "xelatex -interaction nonstopmode -output-directory %o %f" "xelatex -interaction nonstopmode -output-directory %o %f")))
(add-hook 'org-mode-hook
		  (lambda () "DOCSTRING" (interactive)
			;; (iimage-mode t)
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
(global-set-key (kbd "<M-f8>") 'highlight-symbol-at-point) ;高亮光标下的单词
(global-set-key (kbd "<C-f8>") 'unhighlight-regexp)        ;删除高亮，c-0全删
(global-set-key (kbd "<M-S-f8>") 'highlight-regexp)

;;使用find递归查找文件
(global-set-key (kbd "<M-f7>") 'find-name-dired) ;找文件名
(global-set-key (kbd "<C-f7>") 'find-grep-dired) ;找文件内容
(global-set-key (kbd "<C-M-f7>") 'kill-find)

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
(global-set-key (kbd "<M-f9>") 'delete-frame)


;; 文件跳转
(global-set-key (kbd "<M-f6>") 'semantic-decoration-include-visit)
(global-set-key (kbd "<C-f6>") 'find-file-at-point) ;ffap
(global-set-key (kbd "M-o") 'ff-find-other-file) ;声明和实现之间跳转

;; rename buffer可用于给shell改名，起多个shell用
(global-set-key (kbd "<M-f2>") 'rename-buffer) ;或者c-u M-x shell

;; 重新加载文件
(global-set-key (kbd "<f1>") 'revert-buffer)
(global-set-key (kbd "<M-f1>") 'reopen-file)

;; 对齐
(global-set-key (kbd "C-`") 'align)

;; shell
(global-set-key (kbd "<f10>") 'shell)

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
;; set-mark
(global-set-key (kbd "C-,") 'cua-set-mark)
;; whitespace
(global-set-key (kbd "C-=") 'whitespace-mode)
(global-set-key (kbd "C-+") 'whitespace-cleanup-region)
;; hide/show
(global-set-key (kbd "M-[") 'hs-toggle-hiding)
(autoload 'hs-toggle-hiding "hideshow" nil t)
(defadvice hs-toggle-hiding (around hs-toggle-hiding-ar activate)
  ""
  (interactive)
  (if hs-minor-mode
      ad-do-it
    (progn
      (hs-minor-mode t)
      ad-do-it)))

;; rgrep
(global-set-key (kbd "<C-f5>") 'rgrep)
(global-set-key (kbd "<C-S-f5>") 'lgrep)
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
(global-set-key (kbd "M-,") 'evil-jump-backward)
(global-set-key (kbd "C--") 'evil-jump-backward)
(global-set-key (kbd "C-_") 'evil-jump-forward)
;; indent select region
(global-set-key (kbd "<S-tab>") 'indent-rigidly)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-xref-file-name ((t (:foreground "coral")))))
