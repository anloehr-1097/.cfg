;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
(setq user-full-name "Andreas Loehr"
      user-mail-address "andreas.loehr97@gmail.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;

;; accept. For example:
;;
(setq doom-font (font-spec :family "Iosevka Nerd Font" :size 13 :weight 'normal))

;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-acario-dark)
(setq doom-theme 'gruber-darker)
(set-background-color "black")
;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
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

; Org superstart mode to prettify org mode

(require 'org-superstar)
(add-hook 'org-mode-hook (lambda() org-superstar-mode 1))


(require 'all-the-icons)

; Dashboard Configuration
; (require 'dashboard)
; (dashboard-setup-startup-hook)
; ;; Or if you use use-package
(use-package dashboard
 :ensure t
 :config
 (dashboard-setup-startup-hook))
; Set the title
(setq dashboard-banner-logo-title "Dashboard")
;; Set the banner
(setq dashboard-startup-banner 'logo)
; ;; Value can be
; ;; - nil to display no banner
; ;; - 'official which displays the official emacs logo
; ;; - 'logo which displays an alternative emacs logo
; ;; - 1, 2 or 3 which displays one of the text banners
; ;; - "path/to/your/image.gif", "path/to/your/image.png" or "path/to/your/text.txt" which displays whatever gif/image/text you would prefer
; ;; - a cons of '("path/to/your/image.png" . "path/to/your/text.txt")
;
; ;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
;
; ;; To disable shortcut "jump" indicators for each section, set
(setq dashboard-show-shortcuts t)
(setq dashboard-items '((recents  . 5)
                       (bookmarks . 5)
                       (projects . 5)
                       (agenda . 5)
                       (registers . 5)))
;; use all-the-icons package
(setq dashboard-icon-type 'all-the-icons)
(setq dashboard-filter-agenda-entry 'dashboard-no-filter-agenda)
(setq dashboard-heading-icons '((recents . "history")
                              (bookmarks . "bookmark")
                              (agenda    . "calendar")
                              (projects  . "rocket")
                              (registers . "database")))
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)
(setq dashboard-set-navigator t)
(setq dashboard-init-info "Welcome to Emacs!")
;
(page-break-lines-mode)
; ;
; beacon
(use-package beacon
  :hook (prog-mode . beacon-mode)
  :config
        (setq beacon-blink-when-buffer-changes t)
        (setq beacon-blink-when-window-changes t)
        (setq beacon-blink-when-point-moves-vertically t)
        (setq beacon-blink-when-point-moves-horizontally t))

        ; ; (setq beacon-size 79)
        ; ; (setq beacon-color 0.5))))

(use-package linum-relative
  :hook (prog-mode . linum-relative-mode)
       (org-mode . linum-relative-mode)
       (text-mode . linum-relative-mode))
;
(require 'emacs-surround)
(global-set-key (kbd "C-q") 'emacs-surround)

; clippy
(require 'clippy)
(map! :leader
      (:prefix ("c h" . "Help info from Clippy")
       :desc "Clippy describes function under point" "f" #'clippy-describe-function
       :desc "Clippy describes variable under point" "v" #'clippy-describe-variable))

; ivy
(setq ivy-posframe-display-functions-alist
        '((swiper                     . ivy-posframe-display-at-point)
        (complete-symbol            . ivy-posframe-display-at-point)
        (counsel-M-x                . ivy-display-function-fallback)
        (counsel-esh-history        . ivy-posframe-display-at-window-center)
        (counsel-describe-function  . ivy-display-function-fallback)
        (counsel-describe-variable  . ivy-display-function-fallback)
        (counsel-find-file          . ivy-display-function-fallback)
        (counsel-recentf            . ivy-display-function-fallback)
        (counsel-register           . ivy-posframe-display-at-frame-bottom-window-center)
        (dmenu                      . ivy-posframe-display-at-frame-top-center)
        (nil                        . ivy-posframe-display))
        ivy-posframe-height-alist
       '((swiper . 20)
        (dmenu . 20)
        (t . 10)))
(ivy-posframe-mode 1) ; 1 enables posframe-mode, 0 disables it.
;
(map! :leader
       (:prefix ("v" . "Ivy")
       :desc "Ivy push view" "v p" #'ivy-push-view
       :desc "Ivy switch view" "v s" #'ivy-switch-view))
;
; neotree file browser
(after! neotree
 (setq neo-smart-open t
        neo-window-fixed-size nil))
;
(after! doom-themes
  (setq doom-neotree-enable-variable-pitch t))
; ;
(map! :leader
      :desc "Toggle neotree file viewer" "t n" #'neotree-toggle
      :desc "Open directory in neotree"  "d n" #'neotree-dir)
;
; org superstar
(require 'org-superstar)
(add-hook 'org-mode-hook (lambda () (org-superstar-mode 1)))

(use-package pdf-tools
   :ensure t
   :config
   (setenv "PKG_CONFIG_PATH" "/usr/local/Cellar/zlib/1.2.12/lib/pkgconfig:/usr/local/lib/pkgconfig:/usr/X11/lib/pkgconfig:/usr/local/Cellar/poppler/22.06.0_1/lib/pkgconfig:/opt/x11/share/pkgconfig")
   (pdf-tools-install)
   (custom-set-variables
    '(pdf-tools-handle-upgrades t)))

; org noter keybinings
(global-set-key (kbd "C-c i") (lambda () (interactive) (funcall 'org-noter-insert-note)))


 ;; Enabling only some features
; (setq dap-auto-configure-features '(sessions locals controls tooltip))


(after! dap-mode
  ; (require 'dap-cpptools)
  (setq dap-python-debugger 'debugpy))

(require 'dap-python)
  (setq dap-python-debugger 'debugpy)

(require 'dap-gdb-lldb)

; configure org roam
(after! org
(setq org-roam-directory (file-truename "~/org-roam"))
(org-roam-db-autosync-mode))

; (lsp-register-custom-settings ())

(require 'flycheck)
   (setq flycheck-python-pylint-executable "python3")
; Activate flycheck mode globally
; (global-flycheck-mode)
(setq flycheck-python-mypy-executable "mypy")

; (use-package lsp-mode
  ; :ensure t
  ; :config
;
  ; ;; make sure we have lsp-imenu everywhere we have LSP
  ; (require 'lsp-imenu)
  ; (add-hook 'lsp-after-open-hook 'lsp-enable-imenu)
  ; ;; get lsp-python-enable defined
  ; ;; NB: use either projectile-project-root or ffip-get-project-root-directory
  ; ;;     or any other function that can be used to find the root directory of a project
  ; (lsp-define-stdio-client lsp-python "python"
                           ; #'projectile-project-root
                           ; '("pylsp"))
;
  ; ;; make sure this is activated when python-mode is activated
  ; ;; lsp-python-enable is created by macro above
  ; (add-hook 'python-mode-hook
            ; (lambda ()
              ; (lsp-python-enable))))
(add-hook 'doc-view-mode
          (lambda ()
            (linum-mode -1)
            ))
