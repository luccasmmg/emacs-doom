;;; .doom.d/config.el -*- lexical-binding: t; -*-
;;;

;;Emacs pdf tools
(pdf-loader-install)

;; Place your private configuration here
(after! org
  (map! :map org-mode-map
       :n "M-j" #'org-metadown
       :n "M-k" #'org-metaup))
(setq display-line-numbers-type 'relative)
(setq org-agenda-files (directory-files-recursively "~/org/" "\\.org$"))

;;Theme
(setq doom-theme 'doom-challenger-deep)

;;Racket-mode
(add-to-list 'auto-mode-alist '("\\.rkt\\'" . racket-mode))

;; React Development Environment

(defun setup-tide-mode ()
  "Setup Function for tide. "
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(mode-enabled save))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(setq company-tooltip-align-annotations t)

(add-hook 'js-mode-hook 'setup-tide-mode)
(require 'prettier-js)
(add-hook 'js-mode-hook 'prettier-js-mode)

(setq prettier-js-args '(
  "--trailing-comma" "none"
  "--bracket-spacing" "true"
  "--single-quote" "true"
  "--no-semi" "true"
  "--jsx-single-quote" "true"
  "--jsx-bracket-same-line" "true"
  "--print-width" "100"))

;We-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)
;Evil-multiedit and evil-mc

(def-package! evil-multiedit
  :commands (evil-multiedit-match-all
             evil-multiedit-match-and-next
             evil-multiedit-match-and-prev
             evil-multiedit-match-symbol-and-next
             evil-multiedit-match-symbol-and-prev
             evil-multiedit-toggle-or-restrict-region
             evil-multiedit-next
             evil-multiedit-prev
             evil-multiedit-abort
             evil-multiedit-ex-match))


(def-package! evil-mc
  :commands (evil-mc-make-cursor-here evil-mc-make-all-cursors
             evil-mc-undo-all-cursors evil-mc-pause-cursors
             evil-mc-resume-cursors evil-mc-make-and-goto-first-cursor
             evil-mc-make-and-goto-last-cursor
             evil-mc-make-cursor-move-next-line
             evil-mc-make-cursor-move-prev-line evil-mc-make-cursor-at-pos
             evil-mc-has-cursors-p evil-mc-make-and-goto-next-cursor
             evil-mc-skip-and-goto-next-cursor evil-mc-make-and-goto-prev-cursor
             evil-mc-skip-and-goto-prev-cursor evil-mc-make-and-goto-next-match
             evil-mc-skip-and-goto-next-match evil-mc-skip-and-goto-next-match
             evil-mc-make-and-goto-prev-match evil-mc-skip-and-goto-prev-match)
  :init
  (defvar evil-mc-key-map (make-sparse-keymap))
  :config
  (global-evil-mc-mode +1)

  ;; Add custom commands to whitelisted commands
  (dolist (fn '(doom/deflate-space-maybe doom/inflate-space-maybe
                doom/backward-to-bol-or-indent doom/forward-to-last-non-comment-or-eol
                doom/backward-kill-to-bol-and-indent doom/newline-and-indent))
    (push (cons fn '((:default . evil-mc-execute-default-call)))
          evil-mc-custom-known-commands))

  ;; disable evil-escape in evil-mc; causes unwanted text on invocation
  (push 'evil-escape-mode evil-mc-incompatible-minor-modes)

  (defun +evil|escape-multiple-cursors ()
    "Clear evil-mc cursors and restore state."
    (when (evil-mc-has-cursors-p)
      (evil-mc-undo-all-cursors)
      (evil-mc-resume-cursors)
      t))
  (add-hook '+evil-esc-hook #'+evil|escape-multiple-cursors))

;Twittering mode
(setq twittering-icon-mode t)

;Emacs exec-path-from-shell
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;Neotree width
(after! neotree
  (advice-remove #'neo-util--set-window-width 'ignore)
  (setq neo-window-width 25))

(evil-set-initial-state 'term-mode 'emacs)

;Rust mode
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(setq rust-format-on-save t)

;Peep Dired
(evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down
                                             (kbd "C-<SPC>") 'peep-dired-scroll-page-up
                                             (kbd "<backspace>") 'peep-dired-scroll-page-up
                                             (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)
