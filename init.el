(require 'package)
(add-to-list 'package-archives '("gnu"   . "https://elpa.gnu.org/packages/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-and-compile
  (setq use-package-always-ensure t
        use-package-expand-minimally t))

(use-package sly)
(use-package better-defaults)


;; load evil
(use-package evil
  :ensure t ;; install the evil package if not installed
  :init ;; tweak evil's configuration before loading it
  (setq evil-search-module 'evil-search)
  (setq evil-ex-complete-emacs-commands nil)
  (setq evil-vsplit-window-right t)
  (setq evil-split-window-below t)
  (setq evil-shift-round nil)
  (setq evil-want-C-u-scroll t)
  :config ;; tweak evil after loading it
  (evil-mode)
  
  ;; example how to map a command in normal mode (called 'normal state' in evil)
  (define-key evil-normal-state-map (kbd ", w") 'evil-window-vsplit)
  (define-key evil-window-map (kbd "<right>") 'evil-window-right)
  (define-key evil-window-map (kbd "<left>") 'evil-window-left)
  (define-key evil-window-map (kbd "<dowm>") 'evil-window-down)
  (define-key evil-window-map (kbd "<up>") 'evil-window-up)
  )

(use-package which-key
  :ensure t
  :init (which-key-mode))

(use-package company
  :ensure t
  :config
  (progn
    (add-hook 'sly-mode-hook 'company-mode)
    (add-hook 'lisp-mode-hook 'company-mode)
    (add-hook 'scheme-mode-hook 'company-mode)
    (add-hook 'lsp-mode-hook 'company-mode)
    (add-hook 'after-init-hook 'global-company-mode)))

(use-package rust-mode
  :ensure t)

(use-package go-mode
  :ensure t)

(use-package js2-mode
  :mode ("\\.js?$" . js2-mode)
  :ensure t)

(use-package rjsx-mode
  :mode
  ("\\.jsx?$" . rjsx-mode)
 :ensure t)

(use-package web-mode
 :mode
  ("\\.ts?$" . web-mode)
  ("\\.tsx?$" . typescript-mode)
)

(use-package eslintd-fix
  :ensure t
  :config
  (progn
    (add-hook 'js2-mode-hook 'eslintd-fix-mod)))

(use-package geiser-chicken
  :ensure t)

(use-package magit
  :ensure 
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))


(use-package lsp-mode
  :init
  (setq lsp-keymap-prefix "C-c l")
  :hook (
         (rust-mode . lsp)
         (go-mode . lsp)
         (web-mode . lsp)
         (js2-mode . lsp)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

(use-package lsp-ui :commands lsp-ui-mode)
(use-package dap-mode)

(use-package dracula-theme
  :config (load-theme 'dracula t))

(use-package neotree
  :ensure t
  :bind (("C-c n" . neotree-toggle))
  :defer
  :config
    (evil-set-initial-state 'neotree-mode 'normal)
    (evil-define-key 'normal neotree-mode-map
      (kbd "RET") 'neotree-enter
      (kbd "c")   'neotree-create-node
      (kbd "r")   'neotree-rename-node
      (kbd "d")   'neotree-delete-node
      (kbd "j")   'neotree-next-node
      (kbd "k")   'neotree-previous-node
      (kbd "g")   'neotree-refresh
      (kbd "C")   'neotree-change-root
      (kbd "I")   'neotree-hidden-file-toggle
      (kbd "H")   'neotree-hidden-file-toggle
      (kbd "q")   'neotree-hide
      (kbd "l")   'neotree-enter
      ))

(use-package all-the-icons
  :defer)

(defvar --backup-directory (concat user-emacs-directory "backups"))
(if (not (file-exists-p --backup-directory))
        (make-directory --backup-directory t))
(setq backup-directory-alist `(("." . ,--backup-directory)))
(setq make-backup-files t               ; backup of a file the first time it is saved.
      backup-by-copying t               ; don't clobber symlinks
      version-control t                 ; version numbers for backup files
      delete-old-versions t             ; delete excess backup files silently
      delete-by-moving-to-trash t
      kept-old-versions 6               ; oldest versions to keep when a new numbered backup is made (default: 2)
      kept-new-versions 9               ; newest versions to keep when a new numbered backup is made (default: 2)
      auto-save-default t               ; auto-save every buffer that visits a file
      auto-save-timeout 20              ; number of seconds idle time before auto-save (default: 30)
      auto-save-interval 200            ; number of keystrokes between auto-saves (default: 300)
      )

;; Setenv

(setq exec-path (append exec-path '("/home/nataneb/go/bin")))
(setq exec-path (append '("/home/nataneb/.nvm/versions/node/v17.4.0/bin") exec-path))
(setenv "PATH" (concat "/home/nataneb/.nvm/versions/node/v17.4.0/bin:" (getenv "PATH")))

(use-package yasnippet
  :ensure t
  :config
  (yas-reload-all)
  (add-hook 'prog-mode-hook #'yas-minor-mode)

  (lsp-register-custom-settings
 '(("gopls.completeUnimported" t t)
   ("gopls.staticcheck" t t))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(better-defaults evil dracula-theme sly use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
