;;; package --- Summary

;;; Commentary:
;;; Manually Added stuff for my Emacs config


;;; Code:
;; GUI Stuff
(setq inhibit-startup-message t)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(column-number-mode t)
(global-visual-line-mode 1)
(setq-default initial-scratch-message
              (concat ";; Happy hacking, " user-login-name " - Emacs ♥ you!\n\n"))

(add-to-list 'default-frame-alist '(fullscreen . maximized))


;; Customize File
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

(setq backup-directory-alist `(("." . "~/.emacs.d/backups")))

;; Font
(add-to-list 'default-frame-alist
             ;; '(font . "Source Code Pro-12"))
             '(font . "Inconsolata\-dz-12"))
             ;; '(font . "Fira Code-12"))
(global-font-lock-mode 1)

(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/"))

(package-initialize)


;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
        (package-refresh-contents)
        (package-install 'use-package))

(setq use-package-verbose t)


;;; Packages -----------------------------------------------------


;; (use-package exec-path-from-shell
;;   :defer 1
;;   :ensure t
;;   :config
;;   (when (memq window-system '(mac ns))
;;     (setq exec-path-from-shell-arguments (quote ("-l")))
;;     (setq exec-path-from-shell-variables (quote ("PATH" "MANPATH" "CMAKE_PREFIX_PATH" "LC_ALL" "LANG" "LC_CTYPE")))
;;        (exec-path-from-shell-initialize))

(use-package dash
  :config (dash-enable-font-lock))

(use-package try
  :ensure t)

(use-package which-key
  :ensure t
  :config (which-key-mode))

(use-package expand-region
  :ensure t
  :bind (("C-=" . er/expand-region))
  )

(use-package undo-tree
  :ensure t
  :init (global-undo-tree-mode)
  :diminish undo-tree-mode
  )

(use-package smartparens
  :ensure t
  :init (progn
	  (use-package smartparens-config)
	  (smartparens-global-mode 1))
  :diminish smartparens-mode
  )

;; Org-Mode
(use-package org
  :ensure t
  :mode (("\\.org\\'" . org-mode))
  :config
  (setq org-startup-indented t)
  :diminish org-indent-mode
  )

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))


(use-package ibuffer
  :commands ibuffer
  :bind (("C-x C-b" . ibuffer))
  )


(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))
    ))

(use-package counsel
  :ensure t
  )

(use-package ivy
  :ensure t
  :diminish (ivy-mode)
  :bind (("C-x b" . ivy-switch-buffer))
  :config
  (ivy-mode 1)
  (setq ivy-use-virtual-buffers t)
  (setq ivy-display-style 'fancy)
  )

(use-package swiper
  :ensure t
  :bind (("C-s" . swiper)
	 ("C-r" . swiper)
	 ("C-c C-r" . ivy-resume)
	 ("M-x" . counsel-M-x)
	 ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)
    ))

(use-package avy
  :ensure t
  :bind ("M-s" . avy-goto-char)
  )

(use-package company               
  :ensure t
  :defer t
  :init (global-company-mode)
  :diminish (company-mode)
  )

(use-package company-quickhelp
  :ensure t
  :defer 1
  :init (company-quickhelp-mode 1)
  )

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode)
  )

;;THEME
;; (use-package gruvbox-theme
;;   :ensure t
;;   :config (load-theme 'gruvbox t)
;;   )
(use-package moe-theme
  :ensure t
  :config (load-theme 'moe-dark t)
  )


;;Maior Modes
(use-package ess
  :ensure t
  )

(use-package markdown-mode
  :ensure t
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
