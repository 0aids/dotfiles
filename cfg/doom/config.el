;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka Nerd Font Propo" :size 13 :weight 'semi-light)
      doom-variable-pitch-font (font-spec :family "Libertinus Serif" :size 13))
(setq doom-big-font (font-spec :family "Libertinus Serif"))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

;; Snippet here to ensure that pdf-view-mode turns off line numbers (incompatible)
(require 'display-line-numbers)
(defun display-line-numbers--turn-on ()
  "Turn on `display-line-numbers-mode'."
  (unless (or (minibufferp) (eq major-mode 'pdf-view-mode))
    (display-line-numbers-mode)))
(setq display-line-numbers-type 'visual)
(global-display-line-numbers-mode 1)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(defun my/org-expand-relative-path (path)
  "Expand a file/path relative to the org-directory"
  (expand-file-name path org-directory)
  )
(setq org-roam-directory (my/org-expand-relative-path "roam"))
(setq org-roam-db-location (my/org-expand-relative-path "org-roam.db"))

(map! :leader
      :prefix "n"
      :desc "Toggle roam buffer"
      "r" #'org-roam-buffer-toggle
      :desc "Find node"
      "f" #'org-roam-node-find
      :desc "Insert link"
      "i" #'org-roam-node-insert
      :desc "Capture to node"
      "c" #'org-roam-capture
      :desc "Show graph"
      "g" #'org-roam-graph
      :desc "Random node"
      "R" #'org-roam-node-random

      ;; Dailies
      :desc "Today"
      "d" #'org-roam-dailies-goto-today
      :desc "Yesterday"
      "y" #'org-roam-dailies-goto-yesterday
      :desc "Tomorrow"
      "m" #'org-roam-dailies-goto-tomorrow
      :desc "Date"
      "D" #'org-roam-dailies-goto-date)
(setq org-roam-dailies-directory "dailies/")
(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         "* %<%H:%M> %?"
         :target (file+head "%<%Y-%m-%d>.org"
                            "#+title: %<%Y-%m-%d %A>\n\n* Today\n\n* Tmrw\n\n* Later\n")
         :empty-lines 1)))
(after! org
  (setq org-todo-keywords '((sequence "TODO" "DOIN" "PAUS" "|" "DONE" "NOPE")))
  (setq org-todo-keyword-faces
        '(("DOIN" . (:inherit (bold org-todo) :foreground "orange"))
          ("NOPE" . (:inherit (bold org-todo) :foreground "black" :weight "bold"))
          ("DONE" . (:inherit (bold org-done)))
          ("PAUS" . (:inherit (bold org-done) :foreground "white" :weight "bold"))
          )))

;; Configure org-roam capture - new nodes go to roam/${slug}.org
(setq org-roam-capture-templates
      '(("n" "note" plain
         ""
         :if-new (file+head "${slug}.org"
                            "#+title: ${title}\n#+date: %U\n")
         :unnarrowed t)))

(setq writeroom-width 80)
(use-package visual-fill-column
  :hook (org-mode . visual-line-mode)
  :hook (org-mode . visual-fill-column-mode)
  :config
  (setq-default visual-fill-column-width 100)
  (setq-default visual-fill-column-center-text nil))

;; code for centering LaTeX previews -- a terrible idea
(use-package org-latex-preview
  :config
  (defun my/org-latex-preview-uncenter (ov)
    (overlay-put ov 'before-string nil))
  (defun my/org-latex-preview-recenter (ov)
    (overlay-put ov 'before-string (overlay-get ov 'justify)))
  (defun my/org-latex-preview-center (ov)
    (save-excursion
      (goto-char (overlay-start ov))
      (when-let* ((elem (org-element-context))
                  ((or (eq (org-element-type elem) 'latex-environment)
                       (string-match-p "^\\\\\\[" (org-element-property :value elem))))
                  (img (overlay-get ov 'display))
                  (prop `(space :align-to (- center (0.55 . ,img))))
                  (justify (propertize " " 'display prop 'face 'default)))
        (overlay-put ov 'justify justify)
        (overlay-put ov 'before-string (overlay-get ov 'justify)))))
  (define-minor-mode org-latex-preview-center-mode
    "Center equations previewed with `org-latex-preview'."
    :global nil
    (if org-latex-preview-center-mode
        (progn
          (add-hook 'org-latex-preview-overlay-open-functions
                    #'my/org-latex-preview-uncenter nil :local)
          (add-hook 'org-latex-preview-overlay-close-functions
                    #'my/org-latex-preview-recenter nil :local)
          (add-hook 'org-latex-preview-overlay-update-functions
                    #'my/org-latex-preview-center nil :local))
      (remove-hook 'org-latex-preview-overlay-close-functions
                   #'my/org-latex-preview-recenter)
      (remove-hook 'org-latex-preview-overlay-update-functions
                   #'my/org-latex-preview-center)
      (remove-hook 'org-latex-preview-overlay-open-functions
                   #'my/org-latex-preview-uncenter)))
  (add-hook 'org-mode-hook 'org-latex-preview-mode)
  (add-hook 'org-mode-hook 'org-latex-preview-center-mode))

;; Turn off pretty entities for latex, it becomes annoying when typing
(setq org-pretty-entities nil)

(use-package org-download
  :config
  (add-hook 'org-mode-hook 'org-download-enable))

;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `with-eval-after-load' block, otherwise Doom's defaults may override your
;; settings. E.g.
;;
;;   (with-eval-after-load 'PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look them up).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
