;;-----------------------------------------------------------外观-----------------------------------------------------------;;
;; 字体保证中文是英文的两倍宽
;; Setting English Font

;; (package-initialize)

;; 窗口位置 大小
(setq initial-frame-alist
      '((top . 1) (left . 350) (width . 80) (height . 38)))

(set-face-attribute
 ;; 'default nil :font "source code pro" :weight 'light :height 141) ;ultra-light
 'default nil :font "Consolas 11")

;; 新开的窗口保持字体
(add-to-list 'default-frame-alist '(font . "Consolas 11"))

;;Chinese Font
(dolist (charset '(kana han symbol cjk-misc bopomofo))
  (set-fontset-font (frame-parameter nil 'font)
					charset
					(font-spec :family "新宋体" :size 16)));mac中Heiti SC能中英文等高

;; 获取site-lisp路径
(defvar site-lisp-directory nil)
(setq site-lisp-directory (expand-file-name (concat data-directory "../site-lisp")))

(add-to-list 'custom-theme-load-path (concat site-lisp-directory "/spacemacs/spacemacs-theme"))
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
(setenv "HOME" (expand-file-name "~"))
(setenv "MSYS" "C:\\MinGW\\msys\\1.0\\bin")
(setenv "MINGW" "C:\\MinGW\\bin")
(setenv "PUTTY" "C:\\Program Files (x86)\\PuTTY")
(setenv "LLVM" "C:\\Program Files\\LLVM\\bin")
(setenv "CMAKE" "C:\\Program Files\\CMake\\bin")
(setenv "GTAGSBIN" "c:\\gtags\\bin")
(setenv "PYTHON" "C:\\Python27")		;用27的话ycmd可以使用semantic补全
(setenv "CYGWIN" "C:\\cygwin\\bin")
(setenv "CPPCHECK" "C:\\Program Files (x86)\\Cppcheck")
(setenv "PDFLATEX" "F:\\CTEX\\MiKTeX\\miktex\\bin")
(setenv "PYTHONIOENCODING" "utf-8")     ;防止raw_input出错
(setenv "GITCMD" "C:\\Program Files\\Git\\cmd")
(setenv "LLVMTOOL" "G:\\llvm\\llvm-6.0.1\\build\\Debug\\bin")
;; (setenv "GTAGSLABEL" "pygments")

(setq python-shell-prompt-detect-enabled nil) ;用python27时需要加这个不然有warning
(setq python-shell-completion-native-enable nil) ;用python27时需要加这个不然有warning
(define-coding-system-alias 'UTF-8 'utf-8)       ;防止Warning (mule): Invalid coding system ‘UTF-8’ is specified for the current buffer/file by the :coding tag.

(setenv "PATH"
		(concat
         (getenv "LLVMTOOL")
		 path-separator    
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

(add-to-list 'exec-path (getenv "LLVMTOOL") t)
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
(setq default-directory "d:/")

;; 启动mode
(setq initial-major-mode 'text-mode)

;; elpa
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
						 ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
						 ;; ("melpa" . "http://melpa.milkbox.net/packages/")
						 ("melpa-stable" . "http://melpa-stable.milkbox.net/packages/")))
;; mini buffer 的大小保持不变
;; (setq resize-mini-windows nil)
;; 没有提示音,也不闪屏
(setq ring-bell-function 'ignore)

;; Load CEDET 
(require 'srecode)

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
;; 	(horizontal-scroll-bar-mode 1))

;; 自动横移跟随水平滚动条切换
;; (defadvice horizontal-scroll-bar-mode(after horizontal-scroll-bar-mode-after activate)
;;   (if horizontal-scroll-bar-mode
;; 	  (setq auto-hscroll-mode nil)
;; 	(setq auto-hscroll-mode t)))

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

;; hi lock颜色不要hi-black-hb
(setq hi-lock-face-defaults '("hi-yellow" "hi-pink" "hi-green" "hi-blue" "hi-black-b" "hi-blue-b" "hi-red-b" "hi-green-b"))
;; 自动添加的设置
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ad-redefinition-action (quote accept))
 '(ag-highlight-search t)
 '(auto-hscroll-mode (quote current-line))
 '(auto-save-default nil)
 '(autopair-blink nil)
 '(aw-scope (quote frame))
 '(backward-delete-char-untabify-method nil)
 '(bookmark-save-flag 1)
 '(bookmark-sort-flag nil)
 '(c-electric-pound-behavior (quote (alignleft)))
 '(cc-search-directories (quote ("." "/usr/include" "/usr/local/include/*" "../*")))
 '(column-number-mode t)
 '(company-dabbrev-downcase nil)
 '(company-dabbrev-ignore-case t)
 '(company-dabbrev-other-buffers t)
 '(compilation-scroll-output t)
 '(compilation-skip-threshold 2)
 '(confirm-kill-emacs (quote y-or-n-p))
 '(cquery-tree-initial-levels 1)
 '(cua-mode t nil (cua-base))
 '(cursor-type t)
 '(custom-enabled-themes (quote (spacemacs-light)))
 '(custom-safe-themes
   (quote
    ("66f32da4e185defe7127e0dc8b779af99c00b60c751b0662276acaea985e2721" default)))
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
 '(fci-eol-char 32)
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
 '(global-display-line-numbers-mode t)
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
    (helm-source-buffers-list helm-source-recentf helm-source-bookmarks)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-cache-select-result t)
 '(helm-gtags-display-style (quote detail))
 '(helm-gtags-fuzzy-match t)
 '(helm-gtags-ignore-case t)
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
 '(icomplete-show-matches-on-no-input t)
 '(ido-mode (quote both) nil (ido))
 '(imenu-list-focus-after-activation t)
 '(imenu-list-idle-update-delay 1.2)
 '(imenu-max-item-length 120)
 '(imenu-max-items 1000)
 '(inhibit-startup-screen t)
 '(isearch-allow-scroll t)
 '(ivy-count-format "(%d/%d) ")
 '(ivy-format-function (quote ivy-format-function-arrow))
 '(ivy-height 25)
 '(large-file-warning-threshold 40000000)
 '(ls-lisp-verbosity nil)
 '(lsp-highlight-symbol-at-point nil)
 '(lsp-response-timeout 30)
 '(mac-right-option-modifier (quote control))
 '(magit-diff-use-overlays nil)
 '(magit-git-global-arguments
   (quote
    ("--no-pager" "--literal-pathspecs" "-c" "core.preloadindex=true" "-c" "log.showSignature=false" "-c" "i18n.logOutputEncoding=gbk")))
 '(magit-git-output-coding-system (quote gbk))
 '(magit-log-arguments (quote ("-n32" "--stat")))
 '(magit-log-margin (quote (t "%Y-%m-%d %H:%M " magit-log-margin-width t 18)))
 '(magit-log-section-commit-count 0)
 '(magit-refresh-status-buffer nil)
 '(make-backup-files nil)
 '(menu-bar-mode nil)
 '(mode-require-final-newline nil)
 '(moo-select-method (quote helm))
 '(mouse-drag-and-drop-region t)
 '(mouse-wheel-progressive-speed nil)
 '(mouse-wheel-scroll-amount (quote (3 ((shift) . 1) ((control)))))
 '(org-download-screenshot-file "f:/org/screenshot.png")
 '(org-download-screenshot-method "convert clipboard: %s")
 '(org-log-done (quote time))
 '(org-src-fontify-natively t)
 '(org-support-shift-select t)
 '(password-cache-expiry nil)
 '(pcmpl-gnu-tarfile-regexp "")
 '(powerline-default-separator (quote box))
 '(powerline-gui-use-vcs-glyph t)
 '(recentf-auto-cleanup 600)
 '(rg-custom-type-aliases nil)
 '(rg-show-header nil)
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
 '(tabbar-show-key-bindings nil)
 '(tool-bar-mode nil)
 '(undo-outer-limit 20000000)
 '(uniquify-buffer-name-style (quote post-forward-angle-brackets) nil (uniquify))
 '(user-full-name "gezijian")
 '(vc-svn-program "C:\\Program Files\\TortoiseSVN\\bin\\svn")
 '(vlf-batch-size 10000000)
 '(which-function-mode t)
 '(whitespace-line-column 120)
 '(winner-mode t)
 '(xref-prompt-for-identifier
   (quote
    (not xref-find-definitions xref-find-definitions-other-window xref-find-definitions-other-frame xref-find-references)))
 '(yas-also-auto-indent-first-line t))

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
(autoload 'nlinum-mode "nlinum" nil t)
;; (require 'nlinum )
;; (global-nlinum-mode 1)
;; ;; Preset `nlinum-format' for minimum width.
;; (defun my-nlinum-mode-hook ()
;;   (when nlinum-mode
;;     (setq-local nlinum-format
;;                 (concat "%" (number-to-string
;;                              ;; Guesstimate number of buffer lines.
;;                              (ceiling (log (max 1 (/ (buffer-size) 80)) 10)))
;;                         "d"))))
;; (add-hook 'nlinum-mode-hook #'my-nlinum-mode-hook)
;; ;; 避免 “ERROR: Invalid face: linum” error
;; (defun initialize-nlinum (&optional frame)
;;   (require 'nlinum)
;;   (add-hook 'prog-mode-hook 'nlinum-mode))
;; (when (daemonp)
;;   (add-hook 'window-setup-hook 'initialize-nlinum)
;;   (defadvice make-frame (around toggle-nlinum-mode compile activate)
;; 	(nlinum-mode -1) ad-do-it (nlinum-mode 1)))

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
  ;; (nlinum-mode 1)
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
(add-hook 'git-commit-mode-hook 'my-git-commit-hook)
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

(require 'aquamacs-tabbar)
(tabbar-mode)
;; 防止undo后标签颜色不恢复
(defadvice undo(after undo-after activate)
  ;;   (on-modifying-buffer) ;; tabbar
  (tabbar-update-if-changes-undone)       ; aquamacs-tabbar
  )
(defadvice redo(after redo-after activate)
  ;;   (on-modifying-buffer)  ;; tabbar
  (tabbar-window-update-tabsets-when-idle)
  )
;; (add-hook 'after-revert-hook 'on-modifying-buffer)
(add-hook 'after-revert-hook 'tabbar-window-update-tabsets-when-idle)
(define-key special-event-map [iconify-frame] 'ignore)
(defadvice iconify-frame (after leave-hidden-frame
				                (&rest args) disable compile)
  (aquamacs-handle-frame-iconified (car args)))

;; 重新定义以下函数，关闭按钮不显示图片（windows上显示效果差）
(when (memq system-type '(windows-nt ms-dos))
  (setq tabbar-use-images nil)
  (defsubst tabbar-line-tab (tab)
    "Return the display representation of tab TAB.
That is, a propertized string used as an `header-line-format' template
element.
Call `tabbar-tab-label-function' to obtain a label for TAB."
    (let* ((selected-p (tabbar-selected-p tab (tabbar-current-tabset)))
           (close-button-image (tabbar-find-image tabbar-close-tab-button))
           (mouse-face (if selected-p
                           'tabbar-selected-highlight
                         'tabbar-unselected-highlight))

           (text-face (if selected-p
                          'tabbar-selected
                        'tabbar-unselected))
           (close-button
            (propertize "[x]"
                        'tabbar-tab tab
                        'local-map (tabbar-make-tab-keymap tab)
                        'tabbar-action 'close-tab
                        ;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
                        'mouse-face mouse-face
                        'face text-face
                        'pointer 'arrow
                        ;; 'display (tabbar-normalize-image close-button-image 0 'nomask)
                        ))

           (display-label
            (propertize (if tabbar-tab-label-function
                            (funcall tabbar-tab-label-function tab)
                          tab)
                        'tabbar-tab tab
                        'local-map (tabbar-make-tab-keymap tab)
                        ;;	  'help-echo 'tabbar-help-on-tab ;; no help echo: it's redundant
                        'mouse-face mouse-face
                        'face (cond ((and selected-p
                                          (buffer-modified-p (tabbar-tab-value tab)))
                                     'tabbar-selected-modified)
                                    ((and (not selected-p)
                                          (buffer-modified-p (tabbar-tab-value tab)))
                                     'tabbar-unselected-modified)
                                    ((and selected-p
                                          (not (buffer-modified-p (tabbar-tab-value tab))))
                                     'tabbar-selected)
                                    (t 'tabbar-unselected))
                        'pointer 'arrow))
           (key-label
            (if (and tabbar-show-key-bindings (boundp 'tabbar-line-tabs) tabbar-line-tabs)
                (let* ((mm (member tab tabbar-line-tabs) )
                       ;; calc position (i.e., like position from cl-seq)
                       (index (if mm (- (length tabbar-line-tabs) (length mm)))))
                  (if (and index (fboundp (tabbar-key-command (+ 1 index))))
                      (propertize
                       (get (tabbar-key-command (+ 1 index)) 'label)
                                        ;(format "%s" (+ 1 index))
                       'mouse-face mouse-face
                       ;; same mouse-face leads to joint mouse activation for all elements
                       'face (list 'tabbar-key-binding text-face) ;; does not work
                       )
                    "")
                  ) "")))
      (concat close-button display-label key-label tabbar-separator-value))))

;; imenu list
(autoload 'imenu-list-smart-toggle "imenu-list" nil t)
(global-set-key (kbd "M-q") 'imenu-list-smart-toggle) ;不要直接用imenu-list命令，因为不起timer，无法自动刷新

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
(setq org-agenda-files (list "f:\\org\\task.org"))
(global-set-key (kbd "C-c l") 'org-agenda)

;; taglist
(autoload 'taglist-list-tags "taglist" nil t)
(global-set-key (kbd "M-Q") 'taglist-list-tags)

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
(with-eval-after-load 'lsp-mode
  ;; (global-flycheck-mode t)
  
  (yas-global-mode t)
  (require 'company-lsp)
  (push 'company-lsp company-backends)
  ;; (global-company-mode t)
  ;; (setq company-lsp-async t)
  ;; (setq company-lsp-cache-candidates t)
  ;; (setq company-lsp-enable-recompletion t) ;比如第一次补全出std::，会继续补
  (require 'lsp-ui)
  (add-hook 'lsp-mode-hook 'lsp-ui-mode)
  (setq lsp-ui-doc-enable nil)
  ;; (setq lsp-ui-flycheck-enable nil)
  (setq lsp-ui-imenu-enable nil)        ;打开大文件太卡
  ;; (setq lsp-ui-peek-enable nil)
  (setq lsp-ui-sideline-enable nil)
  (global-set-key (kbd "C-M-.") 'lsp-ui-find-workspace-symbol)

  (require 'helm-xref)
  (setq xref-show-xrefs-function 'helm-xref-show-xrefs)
  (require 'ivy-xref)
  ;; (setq xref-show-xrefs-function #'ivy-xref-show-xrefs)
  (global-set-key (kbd "C-c C-r") 'ivy-resume)
  (define-key ivy-minibuffer-map (kbd "C-M-m") 'ivy-partial-or-done)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-call)

  (global-set-key (kbd "M-.") 'xref-find-definitions)

  ;; imenu只显示返回值和函数名，参数不显示(太卡)
  (defun lsp--symbol-to-imenu-elem-fset (sym)
    (let ((pt (lsp--position-to-point
               (gethash "start" (gethash "range" (gethash "location" sym)))))
          (name (gethash "name" sym))
          (container (gethash "containerName" sym)))
      (cons (if (and lsp-imenu-show-container-name container)
                (substring container 0 (string-match "(" container))
              name)
            (if imenu-use-markers (lsp--point-to-marker pt) pt))))
  
  ;; (fset 'lsp--symbol-to-imenu-elem 'lsp--symbol-to-imenu-elem-fset)

  ;; (global-set-key (kbd "M-,") 'xref-pop-marker-stack)
  )
(autoload 'lsp-cquery-enable "cquery" nil t)
(with-eval-after-load 'cquery
  (setq cquery-executable (expand-file-name "~/cquery/build/release/bin/cquery"))
  ;; Use t for true, :json-false for false, :json-null for null
  ;; (setq cquery-extra-init-params '(:index (:comments 2) :cacheFormat "msgpack")) ;; msgpack占用空间小，但是查看困难，并且结构体变更，要手动更新索引
  ;; container现在在xref里还没有显示，无法使用，配置是:xref (:container t), comments有乱码先不用 , :completion (:detailedLabel t)跟不设置区别不大
  (setq cquery-extra-init-params '(:diagnostics (:ontype json-false :frequencyms -1) :index (:comments 0 :blacklist (".*") :whitelist ("COMMON/include" "dir1/dir2"))))

  ;; (setq cquery-extra-args '("--log-stdin-stdout-to-stderr" "--log-file=/tmp/cq.log"))
;;;; enable semantic highlighting:
  ;; (setq cquery-sem-highlight-method 'overlay)
  ;; (setq cquery-sem-highlight-method 'font-lock)
  (add-hook 'c-mode-common-hook 'lsp-cquery-enable)
  ;; (remove-hook 'c-mode-common-hook 'lsp-cquery-enable)

  (define-key cquery-tree-mode-map (kbd "SPC") 'cquery-tree-press)
  (define-key cquery-tree-mode-map [mouse-1] 'ignore )
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
  
  ;; 不折行
  (dolist (command '(cquery-call-hierarchy cquery-inheritance-hierarchy cquery-member-hierarchy))
    (eval
     `(defadvice ,command (after cquery-after activate)
        (setq truncate-lines t)
        )))

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

;; lsp python
(autoload 'lsp-python-enable "lsp-python" nil t)
(with-eval-after-load 'lsp-python
  (add-hook 'python-mode-hook #'lsp-python-enable)
  )

;; lsp java
(autoload 'lsp-java-enable "lsp-java" nil t)
(with-eval-after-load 'lsp-java
  (add-hook 'java-mode-hook #'lsp-java-enable)
  )
(setq lsp-java-server-install-dir "D:\\jdt-language-server-latest")


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


;;hide ^M
(defun remove-dos-eol ()
  "Do not show ^M in files containing mixed UNIX and DOS line endings."
  (interactive)
  (setq buffer-display-table (make-display-table))
  (aset buffer-display-table ?\^M []))

;; 利用evil-jump实现回跳机制, 每个窗口有独立的pop历史
(dolist (command '(semantic-ia-fast-jump semantic-complete-jump helm-gtags-dwim helm-gtags-find-rtag helm-gtags-find-tag helm-gtags-select helm-gtags-select-path
                                         semantic-decoration-include-visit my-ag ag-this-file occur rgrep gtags-find-tag-by-event semantic-analyze-proto-impl-toggle semantic-decoration-include-visit ff-find-other-file semantic-symref-just-symbol
                                         semantic-symref-anything semantic-symref-fset xref-find-definitions xref-find-apropos xref-find-references cquery-tree-press-and-switch lsp-ui-find-workspace-symbol))
  (eval
   `(defadvice ,command (before jump-mru activate)
      (unless (featurep 'evil-jumps)
        (require 'evil))
      (when (featurep 'evil-jumps)
        (evil-set-jump))
      ;; (window-configuration-to-register :prev-win-layout)
      )))


(defadvice helm-gtags-find-tag-other-window (after helm-gtags-tag-other-back activate)
  ""
  (select-window (previous-window)))

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
  (when (< (* 150 1024) (buffer-size))
	;; (nlinum-mode -1)
	;; (setq-local jit-lock-context-time 1.5)
	;; (setq-local jit-lock-defer-time 0.5)
	(setq-local font-lock-maximum-decoration 2)
	(font-lock-refresh-defaults)
	(setq-local semantic-idle-scheduler-idle-time 60)
	(setq-local company-idle-delay 3)
    ;; (eldoc-mode -1)
    ;; (ad-deactivate 'yank)
    ;; (ad-deactivate 'yank-pop)
    ;; (ad-deactivate 'undo)

	;; (font-lock-mode -1 )
	;; (jit-lock-mode nil)
	;; (diff-hl-mode -1)
    (message "Large file." )
	))
;; 大文件不开semantic
(eval-after-load "semantic"
  '(progn 
     (add-to-list 'semantic-inhibit-functions
                  (lambda () (< (* 150 1024) (buffer-size))))))

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
			;; (hs-minor-mode 1)
			;; (hide-ifdef-mode 1)
			(setq-local indent-tabs-mode nil)
			;; (company-mode 1)
			(abbrev-mode -1)
			;; (flycheck-mode 1)
            ;; (yas-minor-mode 1)          
			;; (my-c-mode-common-hook-if0)
			;; (jpk/c-mode-hook)
			;; (setq-local company-idle-delay 0.5)
            ;; (setq-local jit-lock-context-time 1.5)
	        ;; (setq-local jit-lock-defer-time 0.5)
			(check-large-file-hook)
			;; (srecode-minor-mode 1)
			(font-lock-add-keywords nil
									'(("\\(\\_<\\(\\w\\|\\s_\\)+\\_>\\)[ 	]*("
									   1  font-lock-function-name-face keep))
									1)
			;; (superword-mode)                ;连字符不分割单词,影响move和edit，但是鼠标双击选择不管用 ，相对subword-mode
			(define-key c-mode-base-map (kbd "C-{") 'my-hif-toggle-block)
			(set-default 'semantic-imenu-summary-function 'semantic-format-tag-uml-abbreviate)
			))

(add-hook 'emacs-lisp-mode-hook
		  (lambda ()
			(modify-syntax-entry ?- "w")
			;; (flycheck-mode 1)
            ;; (yas-minor-mode 1)
			;; (hs-minor-mode 1)
			(company-mode 1)
            (eldoc-mode 1)
			(setq-local indent-tabs-mode nil)
			(setq-local company-backends (push '(company-capf :with company-yasnippet :with company-dabbrev-code) company-backends))
            (define-key emacs-lisp-mode-map (kbd "M-.") 'xref-find-definitions)
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
			;; (diff-hl-dired-mode 1)
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

(add-hook 'comint-output-filter-functions 'comint-strip-ctrl-m)
(remove-hook 'comint-output-filter-functions 'comint-postoutput-scroll-to-bottom)

;; telnet登录主机后，export LANG=zh_CN.GBK 或 export LC_ALL=en_US.ISO-8859-1 这个管用 ,export LC_CTYPE=zh_CN.GB2312

;; gtags symref 的结果都设置为C语法，主要为了highlight-symbol能正确
(eval-after-load "cc-mode"
  '(progn
	 (dolist (hook '(gtags-select-mode-hook semantic-symref-results-mode-hook ag-mode-hook imenu-list-major-mode-hook))
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
;; 生成函数注释
(global-set-key (kbd "C-c / C") 'srecode-document-insert-comment)
(add-hook 'after-make-frame-functions (lambda (_) (custom-set-faces
                                                   ;; custom-set-faces was added by Custom.
                                                   ;; If you edit it by hand, you could mess it up, so be careful.
                                                   ;; Your init file should contain only one such instance.
                                                   ;; If there is more than one, they won't work right.
                                                   '(tabbar-default ((t (:inherit nil :stipple nil :background "SystemMenuBar" :foreground "black" :box nil :strike-through nil :underline nil :slant normal :weight normal :height 0.9 :width normal :family "Consolas"))))
                                                   '(tabbar-selected-modified ((t (:inherit tabbar-selected :foreground "firebrick" :weight bold))))
                                                   '(tabbar-unselected-modified ((t (:inherit tabbar-unselected :foreground "firebrick" :weight bold)))))) t)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(tabbar-default ((t (:inherit nil :stipple nil :background "SystemMenuBar" :foreground "black" :box nil :strike-through nil :underline nil :slant normal :weight normal :height 0.9 :width normal :family "Consolas"))))
 '(tabbar-selected-modified ((t (:inherit tabbar-selected :foreground "firebrick" :weight bold))))
 '(tabbar-unselected-modified ((t (:inherit tabbar-unselected :foreground "firebrick" :weight bold))))
 '(taglist-tag-type ((t (:foreground "dark salmon" :height 1.0)))))
