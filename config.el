;;; Startup


(load-theme 'doom-molokai t)
;;;(add-hook 'doom-post-init-hook #'treemacs)

;;; Fixes

(set-popup-rule! "^\\*sly-mrepl" :vslot 2 :quit nil :ttl nil)
(set-popup-rule! "^\\*sly-compilation" :vslot 3 :ttl nil)
(set-popup-rule! "^\\*sly-inspector" :vslot 4 :ttl nil)
(set-popup-rule! "^\\*sly-db" :vslot 5 :ttl nil)
(set-popup-rule! "^\\*sly-traces" :vslot 6 :ttl nil)

;;; Bindings

;; sly

(map! (:after sly-mrepl
        :map sly-mrepl-mode-map
        :nvi [C-up]   #'sly-mrepl-previous-input-or-button
        :nvi [C-down] #'sly-mrepl-next-input-or-button
        :nvi "C-r" #'isearch-backward))

;;; Change from Emacs folder to somewher else

(cd "C:/code")

;;; General settings

(setq 
      user-full-name "Tatsuo"
      user-mail-address "deus.no.eternity@gmail.com"
      create-lockfiles nil
      mouse-wheel-scroll-amount '(3)
      mouse-wheel-progressive-speed nil
      mouse-wheel-follow-mouse t
      scroll-step 1
      vc-follow-symlinks t
      confirm-kill-emacs nil)
(setq-default fill-column 100)

;;; Personal variables

(setq philm/lisp-implementations
      '((sbcl ("sbcl"))))

;;; Packages

(def-package! evil-cleverparens
  :init
  (setq evil-move-beyond-eol t
        evil-cleverparens-use-additional-movement-keys nil
        evil-cleverparens-use-additional-bindings nil))

(add-hook! (lisp-mode emacs-lisp-mode)
  (evil-cleverparens-mode t))

(def-package! org
  :config
  (setq org-directory (expand-file-name "~/Projects/Org")
        +org-dir org-directory
        org-default-notes-file (expand-file-name "notes.org" org-directory)
        org-refile-targets '((nil :maxlevel . 5)
                             (org-agenda-files :maxlevel . 5))
        org-refile-use-outline-path 'file
        org-outline-path-complete-in-steps nil
        org-capture-templates
        '(("c" "Code Task" entry (file+headline org-default-notes-file "Coding Tasks")
           "* TODO %?\n  Entered on: %U - %a\n")
          ("t" "Task" entry (file+headline org-default-notes-file "Tasks")
           "* TODO %?\n  Entered on: %U")
          ("n" "Note" entry (file+datetree org-default-notes-file)
           "* %?\n\n"))))

(def-package! sly-repl-ansi-color
  :config
  (push 'sly-repl-ansi-color sly-contribs))

(add-hook! text-mode #'flyspell-mode)

(after! gist
  (setq gist-view-gist t))

(after! imenu-anywhere
  (setq imenu-anywhere-buffer-filter-functions '(imenu-anywhere-same-project-p)))

(after! ivy
  (setq ivy-re-builders-alist '((t . ivy--regex-plus))))

(after! which-key
  (setq which-key-idle-delay 0.25
        which-key-idle-secondary-delay 0.25))

(after! sly
  (evil-set-initial-state 'sly-mrepl-mode 'insert)
  (evil-set-initial-state 'sly-inspector-mode 'emacs)
  (evil-set-initial-state 'sly-db-mode 'emacs)
  (evil-set-initial-state 'sly-xref-mode 'emacs)
  (evil-set-initial-state 'sly-stickers--replay-mode 'emacs)
  (sp-local-pair '(sly-mrepl-mode) "'" "'" :actions nil)
  (sp-local-pair '(sly-mrepl-mode) "`" "`" :actions nil)
  (setq sly-lisp-implementations philm/lisp-implementations
        sly-autodoc-use-multiline t
        sly-complete-symbol*-fancy t
        sly-kill-without-query-p t
        sly-repl-history-remove-duplicates t
        sly-repl-history-trim-whitespaces t
        sly-net-coding-system 'utf-8-unix
        common-lisp-hyperspec-root (expand-file-name "~/.data/common-lisp/clhs/"))
  (add-to-list 'company-backends '(company-capf company-files)))

(after! smartparens
  (setq sp-show-pair-from-inside t
        sp-cancel-autoskip-on-backward-movement nil
        sp-highlight-pair-overlay nil
        sp-highlight-wrap-overlay nil
        sp-highlight-wrap-tag-overlay nil)
  (sp-pair "'" nil :actions :rem)
  (sp-pair "`" nil :actions :rem)
  (smartparens-global-strict-mode 1))


(after! company
  (add-to-list 'company-frontends 'company-tng-frontend)
  (setq company-idle-delay nil))

(add-hook! prog-mode
  (global-company-mode 1))

(def-package! evil-lisp-state
  :init (setq evil-lisp-state-global t)
  :config (evil-lisp-state-leader "SPC l"))

;;; Functions

(defun philm/smarter-move-beginning-of-line (arg)
  (interactive "^p")
  (setq arg (or arg 1))
  (when (/= arg 1)
    (let ((line-move-visual nil))
      (forward-line (1- arg))))
  (let ((orig-point (point)))
    (back-to-indentation)
    (when (= orig-point (point))
      (move-beginning-of-line 1))))

(defun +popup/buffer ()
  "Open current buffer in a popup window."
  (interactive)
  (let ((+popup-default-display-buffer-actions '(+popup-display-buffer-stacked-side-window))
        (display-buffer-alist +popup--display-buffer-alist))
    (push (+popup--make "." +popup-defaults) display-buffer-alist)
    (pop-to-buffer (current-buffer))))

;;; Fixes

;; I really dislike Emacs asking me if I'm sure I want to quit with sub-processes running.
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
  "Prevent annoying \"Active processes exist\" query when you quit Emacs."
  (cl-letf (((symbol-function #'process-list) (lambda ())))
    ad-do-it))

;; I don't want comment characters to be automatically included with a new line from a commented
;; line, only when I type them explicitly.
(advice-remove #'newline-and-indent #'doom*newline-and-indent)
(advice-remove #'evil-insert-newline-below #'+evil*insert-newline-below-and-respect-comments)

