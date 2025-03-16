---
title: "The Emacs"
date: 2025-03-16T02:35:32-04:00
draft: true
---

# Emacs is the editor of all time

Recently I became curious *again* about the great editor known as GNU Emacs.
I have tried it briefly in the past, but this time I wanted to give
it a real shot and I am finding that it is possibly the best option
going forward.

## The Power of Emacs

I can come to appreciate the freedom, elegance and longevity that Emacs provides.

There is a certain understanding between users and developers of Emacs that
goes deeper than much of the software that exists today. The major modes,
minor modes and the elisp that connects all these things would not be
possible without very dedicated users as well as developers.

The way configuration works with elisp teaches you how to program.
The editor itself has guides and pushes you to understand more by
making errors more navigable.

## The Ecosystem

The packages created for Emacs are usually aimed to be directly
useful to the small(ish) community that creates and shares the same
operating environment. After taking a quick stride through
some of the packages listed, there are more than [several
games](https://www.gnu.org/software/emacs/manual/html_node/emacs/Amusements.html)
folks have eveloped and are included right inside Emacs.
Why? Because it is important to have fun sometimes.

Not only that, but [EVIL](https://github.com/emacs-evil/evil)
mode emulation is spot on (and allows all the configurability
for even the most curmudeonly Vim user).

Here is a look at my `init.el` for Emacs so far.


```elisp
;;; init.el --- James' Emacs config -*- lexical-binding: t -*-
;;;
;;; Author: James Dixon <notjamesdixon@gmail.com>
;;; Maintainer: James Dixon <notjamesdixon@gmail.com>
;;;
;;; Commentary:
;;; Emacs from scratch (somewhat), this is my ~~story~~ config
;;; ((((((((((((((((((((!!!GNU EMACS!!!))))))))))))))))))))
;;;

;;; Code:
(setq inhibit-startup-message t)        ; Don't show the splash screen
(setq inhibit-splash-screen t)          ; Do not show splash screen
(setq visible-bell t)                   ; Flash when the bell rings
(setq frame-resize-pixelwise t)         ; Yes, I would like to be able to **resize** emacs, thanks!
(global-display-line-numbers-mode 1)	; Display line numbers
(column-number-mode -1)			; Toggle column number display in the mode line.
(tool-bar-mode -1)			; Disable tool bar
(scroll-bar-mode -1)			; Disable scroll bar
(transient-mark-mode 1)			; Easier starting of marks/regions
(delete-selection-mode 1)		; Easier deleting of marks/regions

(set-frame-font "Maple Mono 12" nil t)
(load-theme 'modus-vivendi t)

;; More memory for Garbage Collection
(setq gc-cons-threshold-original gc-cons-threshold)
(setq gc-cons-threshold (* 1024 1024 100))

;; Auto-refresh buffers when files on disk change.
(global-auto-revert-mode t)
;; Place backups in a separate folder.
(setq backup-directory-alist `(("." . "~/.config/emacs/saves")))
(setq auto-save-file-name-transforms `((".*" "~/.config/emacs/saves/" t)))
(set-register ?e (find-file (or user-init-file "")))

;; bootstrap straight.el package manager
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; start evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
(setq evil-want-C-u-scroll t)
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)

(use-package evil-collection
  :straight t
  :after evil
  :init
  (evil-collection-init))

(use-package evil-surround
  :straight t
  :config
  (global-evil-surround-mode 1))
;; end evil

;; writing
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(use-package markdown-mode
  :straight t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
	      ("C-c C-e" . markdown-do)))
;; end writing

(use-package dired
  :straight nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump)))

(use-package magit
  :straight t)

;; show more vertcal suggestions on M-x
(use-package vertico
  :straight t
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :straight t
  :init
  (marginalia-mode))

(use-package emmet-mode
  :straight t
  :init)

(use-package multiple-cursors
  :straight t)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

(use-package which-key
  :straight t
  :defer t
  :init (which-key-mode))

(use-package flycheck
  :straight t
  :init (global-flycheck-mode))

(use-package company
  :straight t
  :init
  (global-company-mode))

(use-package lsp-mode
  :straight t
  :hook ((prog-mode) . lsp-deferred))

;; fun
(use-package rainbow-delimiters
  :straight t
  :defer t
  :hook ((prog-mode) . rainbow-delimiters-mode))

(setq mode-line-format(list '(:eval (list (nyan-create)))))
(use-package nyan-mode
  :straight t)

(use-package fireplace
  :straight t)

;;; init.el ends here

```
