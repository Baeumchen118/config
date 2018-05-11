(require 'package)
(setq package-enable-at-startup nil)
(setq package-archives '(("melpa"     . "https://melpa.org/packages/")
                         ("org"       . "http://orgmode.org/elpa/")))
(package-initialize)

;; Bootstrap `use-package'
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(load-theme 'wombat)
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-12"))
;; Keinen Splash-Screen
(setq inhibit-splash-screen t)

(use-package which-key
  :ensure t 
  :config
  (which-key-mode))

(setq make-backup-files nil) ;; stop creating those backup~ files
(setq auto-save-default nil) ;; stop creating those #autosave# files

;; ausgewählten Text bei Eingabe löschen
(delete-selection-mode 1) 

;; keine "yes-or-no"-Fragen - "y-or-n" reicht aus
(defalias 'yes-or-no-p 'y-or-n-p)

;; Zusammengehörende Klammern hervorheben
(show-paren-mode 1)
;; Text zwischen den Klammern nicht hervorheben
(setq show-paren-style 'parenthesis)

;; Aktuelle Spaltennummer in der Mode Line anzeigen
(column-number-mode nil)

(use-package ace-window
  :ensure t
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0)))))))

;; Buffer Menu
(global-set-key (kbd "C-x C-b") 'buffer-menu)

(use-package neotree
  :ensure t
  :config (setq neo-window-width 40))

(define-key global-map (kbd "<f1>") 'neotree)

(use-package powerline
  :ensure t)
(require 'powerline)
(powerline-default-theme)

(ido-mode t)
(setq ido-enable-flex-matching t) ;; fuzzy matching is a must have
(setq ido-enable-last-directory-history nil) ;; forget latest selected directory names

(use-package smex
  :ensure t
  :bind (("M-x" . smex))
  :config (smex-initialize))

;; SMEX
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; This is your old M-x:

(use-package boxquote
  :ensure t)

(if window-system
    (progn
      ;; Frame Size and Position at Startup
      (add-to-list 'default-frame-alist '(height . 34))
      (add-to-list 'default-frame-alist '(width . 135))
      (setq initial-frame-alist '((left . 0) (top . 0)))
      ;; Klick-Kram entfernen:
      (tool-bar-mode -1)
      (scroll-bar-mode -1)))

;; Das Menü soll immer ausgeblendet sein
(menu-bar-mode -1)

;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; tasks.org beim Emacs-Start laden
(find-file "~/org/tasks.org")

(setq org-todo-keywords '((sequence "TODO(t)" "WAITING(w)" "|" "DONE(d)" "CANCELLED(c)")))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(setq org-agenda-files '("~/org/"))
