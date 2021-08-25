;; -*- no-byte-compile: t; -*-
;;; .doom.d/packages.el

;;; Examples:
;; (package! some-package)
;; (package! another-package :recipe (:host github :repo "username/repo"))
;; (package! builtin-package :disable t)
(package! rjsx-mode)
(package! company)
(package! flycheck)
(package! prettier-js)
(package! dockerfile-mode)
(package! docker-compose-mode)
(package! sml-mode)
(package! exec-path-from-shell)
(package! flycheck-rust)
(package! peep-dired)
(package! org-fstree)
(package! anaconda-mode
  :recipe (:host github :repo "dakra/anaconda-mode")
  :pin "810163d5a65e62d58f363e2edaa3be70e6d82e25")
(package! vterm)
