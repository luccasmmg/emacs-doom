;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(after! org
  (map! :map org-mode-map
       :n "M-j" #'org-metadown
       :n "M-k" #'org-metaup))
(setq display-line-numbers-type 'relative)

;;Load theme
(load-theme 'doom-gruvbox t)

;; React Development Environment

(defun setup-tide-mode ()
  "Setup Function for tide. "
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
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
