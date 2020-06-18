;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;;
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Johnson Denen"
      user-mail-address "johnson.denen@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font "Source Code Pro-14")

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'ample)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; Configure `lsp-mode' backend for work with Elixir.
;;
;; The only notable change here is toggling dialyzer off.
(after! lsp-clients
  (lsp-register-client
   (make-lsp-client :new-connection
                    (lsp-stdio-connection
                     (expand-file-name "~/.elixirls/release/language_server.sh"))
                    :major-modes '(elixir-mode)
                    :priority -1
                    :server-id 'elixir-ls
                    :initialized-fn (lambda (workspace)
                                      (with-lsp-workspace workspace
                                                          (let ((config `(:elixirLS
                                                                          (:mixEnv "dev"
                                                                                   :dialyzerEnabled
                                                                                   :json-false))))
                                                            (lsp--set-configuration config)))))))

;; Configure the `lsp-mode' frontend.
;;
;; I keep UI docs on but position them pretty far out of the way.
(after! lsp-ui
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-delay 1.5
        lsp-ui-doc-max-height 20
        lsp-ui-doc-max-width 80
        lsp-ui-sideline-ignore-duplicate t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-use-webkit nil
        lsp-ui-imenu-kind-position 'left
        lsp-ui-sideline-code-actions-prefix "!!"
        company-lsp-match-candidate-predicate #'company-lsp-match-candidate-prefix))

;; Some functions to make working with projects and umbrellas easier.
(defun mix/do (task directory)
  (let ((default-directory directory))
    (exunit-do-compile (s-join " " `("mix" ,task)))))

(defun mix/credo (&optional all-p)
  (interactive)
  (mix/do (format "credo %s" (if all-p "-A" "-a")) (exunit-project-root)))

(defun mix/credo-umbrella (&optional all-p)
  (interactive)
  (mix/do (format "credo %s" (if all-p "-A" "-a")) (exunit-umbrella-project-root)))

(defun mix/deps.get ()
  (interactive)
  (mix/do "deps.get" (exunit-project-root)))

(defun mix/dialyzer ()
  (interactive)
  (mix/do "dialyzer" (exunit-project-root)))

(defun mix/dialyzer-umbrella ()
  (interactive)
  (mix/do "dialyzer" (exunit-umbrella-project-root)))

(defun mix/format-buffer ()
  (interactive)
  (let ((file-to-format (file-relative-name (buffer-file-name) (exunit-project-root)))
        (default-directory (exunit-project-root)))
    (save-buffer)
    (shell-command (s-join " " `("mix" "format" ,file-to-format)))))

(defun mix/test.unit ()
  (interactive)
  (mix/do "test.unit" (exunit-umbrella-project-root)))

(defun mix/test.int ()
  (interactive)
  (mix/do "test.int" (exunit-umbrella-project-root)))

(defun mix/test.e2e ()
  (interactive)
  (mix/do "test.e2e" (exunit-umbrella-project-root)))

(use-package! exunit
  :hook elixir-mode)

(use-package! lsp-elixir
  :hook (elixir-mode . lsp))

;; Elixir specific commands can be run from an `elixir-mode' buffer
;; with the leading keys of `SPC m'.
(map! :mode elixir-mode
      :localleader
      ;; SPC m ...
      :desc "Format buffer" :ne "=" #'mix/format-buffer
      :desc "Get dependencies" :ne "!" #'mix/deps.get
      ;; SPC m a ...
      :prefix ("a" . "Aliases")
      :desc "Unit tests" :ne "u" #'mix/test.unit
      :desc "Integration tests" :ne "i" #'mix/test.int
      :desc "E2E tests" :ne "e" #'mix/test.e2e
      ;; SPC m d ...
      :prefix ("d" . "Dialyzer")
      :desc "App" :ne "a" #'mix/dialyzer
      :desc "Umbrella" :ne "u" #'mix/dialyzer-umbrella
      ;; SPC m l ...
      :prefix ("l" . "Linting")
      :desc "App" :ne "a" #'mix/credo
      :desc "Umbrella" :ne "u" #'mix/credo-umbrella
      :desc "Next error" :ne "n" #'flycheck-next-error
      :desc "Previous error" :ne "N" #'flycheck-previous-error
      :desc "List errors" :ne "l" #'flycheck-list-errors
      ;; SPC m t ...
      :prefix ("t" . "Testing")
      :desc "App" :ne "a" #'exunit-verify-all
      :desc "Buffer" :ne "b" #'exunit-verify
      :desc "Retry" :ne "r" #'exunit-rerun
      :desc "At point" :ne "t" #'exunit-verify-single
      :desc "Umbrella" :ne "u" #'exunit-verify-all-in-umbrella
      :desc "Toggle file" :ne "<tab>" #'exunit-toggle-file-and-test
      :desc "Toggle file other window" :ne "<backtab>" #'exunit-toggle-file-and-test-other-window)

;; Map general shell execution to `SPC !'
(map! :leader :desc "Run shell command" :ne "!" #'shell-command)

;; magit
(use-package! magit-status-advice
  :config (magit-status-advice-mode))
