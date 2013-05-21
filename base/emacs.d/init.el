;; Determine the OS Environment
(setq windows (or (eq system-type 'windows-nt)
                  (eq system-type 'cygwin)
                  (eq system-type 'ms-dos)))

;; Set Default Encoding
(set-language-environment "utf-8")

;; Setup List of Packages
(require 'package)
(package-initialize)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
                         ("melpa" . "http://melpa.milkbox.net/packages/")))

;; Download Required Packages
(require 'cl)
(defvar packages
  '(ace-jump-mode yasnippet-bundle el-autoyas helm-c-yasnippet yas-jit workgroups zenburn-theme))

(defun packages-installed-p ()
  (loop for p in packages
        when (not (package-installed-p p)) do (return nil)
        finally (return t)))

(unless (packages-installed-p)
  (package-refresh-contents)
  (dolist (p packages)
    (when (not (package-installed-p p))
      (package-install p))))

;; Use Zenburn Theme
(load-theme 'zenburn t)

;; Customize Window Decorators
(setq inhibit-startup-screen t)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(blink-cursor-mode -1)
(line-number-mode t)
(column-number-mode t)
(size-indication-mode t)
(when (not windows) (set-default-font "Monospace-9"))

;; Workgroups
(require 'workgroups)
(workgroups-mode 1)
(setq wg-morph-on 'nil)

;; Tabs and Editing
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;(global-whitespace-mode 1)

;; Parens Highlighting
(require 'paren)
(setq show-paren-style 'parenthesis)
(show-paren-mode +1)
(electric-pair-mode +1)

;; Prevent pause from breaking emacs
(define-key global-map (kbd "<pause>") 1)

;; Editing Configs
(setq gac-automatically-push-p t)

;; IDO
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Yasnippet
(require 'yasnippet-bundle)
;;(yas-global-mode 1)

;; Ace-Jump Mode
(define-key global-map (kbd "C-c SPC") 'ace-jump-mode)

;; Setup Lisp and Slime
(if windows
    (setq inferior-lisp-program "wx86cl64")
  (setq inferior-lisp-program "sbcl"))
(when (file-exists-p "~/quicklisp/slime-helper.el")
  (load "~/quicklisp/slime-helper.el")
)

;; SSH with Tramp
(require 'tramp)
(setq tramp-default-user "william")
(if windows (setq tramp-default-method "plink"))

;; IRC
(require 'tls)

;;AUCTEX
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(setq TeX-PDF-mode t)

(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'tex-mode-hook 'flyspell-mode)
(add-hook 'bibtex-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)

(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTex t)

;; Easy spell check
(add-hook 'flyspell-mode-hook 'flyspell-buffer)
(global-set-key (kbd "<f8>") 'ispell-word)

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; ORG
(require 'org-install)
(add-hook 'org-mode-hook 'flyspell-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-to-list 'auto-mode-alist '("README$" . org-mode))
(add-to-list 'auto-mode-alist '("TODO$" . org-mode))
;;(add-hook 'org-mode-hook 'org-indent-mode)

;; Disable symlink confirmation
(setq vc-follow-symlinks nil)

;; Load the local el file
(when (file-exists-p "~/.emacs.d/local.el")
  (load "~/.emacs.d/local.el"))
