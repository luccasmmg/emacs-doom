;;; .doom.d/config.el -*- lexical-binding: t; -*-
;;;

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
(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

;; (setq prettier-js-args '(
;;   "--trailing-comma" "none"
;;   "--bracket-spacing" "true"
;;   "--single-quote" "true"
;;   "--no-semi" "true"
;;   "--jsx-single-quote" "true"
;;   "--jsx-bracket-same-line" "true"
;;   "--print-width" "100"))

;We-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
)
(add-hook 'web-mode-hook  'my-web-mode-hook)

;Twittering mode
(setq twittering-icon-mode t)

;Neotree width
(after! neotree
  (advice-remove #'neo-util--set-window-width 'ignore)
  (setq neo-window-width 25))

(evil-set-initial-state 'term-mode 'emacs)

;Rust mode
(add-hook 'racer-mode-hook #'eldoc-mode)
(add-hook 'flycheck-mode-hook #'flycheck-rust-setup)
(add-hook 'rust-mode-hook (lambda () (setq tab-width 2)))
(setq rust-format-on-save t)

;Peep Dired
(evil-define-key 'normal peep-dired-mode-map (kbd "<SPC>") 'peep-dired-scroll-page-down
                                             (kbd "C-<SPC>") 'peep-dired-scroll-page-up
                                             (kbd "<backspace>") 'peep-dired-scroll-page-up
                                             (kbd "j") 'peep-dired-next-file
                                             (kbd "k") 'peep-dired-prev-file)
(add-hook 'peep-dired-hook 'evil-normalize-keymaps)

;Projectile
(setq projectile-project-search-path '("~/Projetos/"))

;Haskell
(setq lsp-haskell-process-path-hie "ghcide")
(setq lsp-haskell-process-args-hie '())

;SML
(defun my-sml-mode-hook () "Local defaults for SML mode"
       (setq sml-indent-level 2)        ; conserve on horizontal space
       (setq words-include-escape t)    ; \ loses word break status
       (setq indent-tabs-mode nil))     ; never ever indent with tabs
(add-hook 'sml-mode-hook 'my-sml-mode-hook)
