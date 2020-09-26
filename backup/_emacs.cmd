(progn
  (defun turn-on-line-number ()
    "Turn on line number on margin."
    (linum-mode 1))
  (add-hook 'python-mode-hook 'turn-on-line-number)
  )

(setq linum-format "%3d \u2502")

(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
   'package-archives
   ;; '("melpa" . "http://stable.melpa.org/packages/") ; many packages won't show if using stable
   '("melpa" . "http://melpa.milkbox.net/packages/")
   t))

(setq package-enable-at-startup nil)
(package-initialize)
;(load-theme 'zenburn t)
;(require 'color-theme-sanityinc-tomorrow) ; see auto-generated part below
(require 'afternoon-theme)

(add-to-list 'load-path (expand-file-name "~/.elisp/"))

(auto-revert-mode t)

;; Put autosave files (ie #foo#) and backup files (ie foo~) in ~/.emacs.d/.
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(compilation-message-face (quote default))
 '(custom-enabled-themes (quote (sanityinc-tomorrow-bright)))
 '(custom-safe-themes
   (quote
    ("82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "04232a0bfc50eac64c12471607090ecac9d7fd2d79e388f8543d1c5439ed81f5" "0eccc893d77f889322d6299bec0f2263bffb6d3ecc79ccef76f1a2988859419e" default)))
 '(fill-column 125)
 '(highlight-changes-colors (quote ("#EF5350" "#7E57C2")))
 '(highlight-tail-colors
   (quote
    (("#010F1D" . 0)
     ("#B44322" . 20)
     ("#34A18C" . 30)
     ("#3172FC" . 50)
     ("#B49C34" . 60)
     ("#B44322" . 70)
     ("#8C46BC" . 85)
     ("#010F1D" . 100))))
 '(magit-diff-use-overlays nil)
 '(pos-tip-background-color "#FFF9DC")
 '(pos-tip-foreground-color "#011627")
 '(show-paren-style (quote mixed))
 '(weechat-color-list
   (quote
    (unspecified "#011627" "#010F1D" "#DC2E29" "#EF5350" "#D76443" "#F78C6C" "#D8C15E" "#FFEB95" "#5B8FFF" "#82AAFF" "#AB69D7" "#C792EA" "#AFEFE2" "#7FDBCA" "#D6DEEB" "#FFFFFF"))))


;; create the autosave dir if necessary, since emacs won't.
(make-directory "~/.emacs.d/autosaves/" t)

(show-paren-mode)
(flyspell-mode)

;;personal niceties
(setq tramp-default-method "ssh")
(winner-mode t)
(global-font-lock-mode t)
(menu-bar-enable-clipboard)
(require 'ido)
(ido-mode t)
;;autocomplete

;;for mac, to get the usual behavior for M-w which doesn't show on mac
(global-set-key "\M-w" 'copy-region-as-kill)

;;Steve Yegge's suggestions

(global-set-key "\C-w" 'delete-backward-char)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
					;lose the UI
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))

(global-set-key "\C-x\C-m" 'execute-extended-command)
(global-set-key "\C-c\C-m" 'execute-extended-command)

;;RDman's scroll other window
;;procedures for scrolling 1 line at a time for the other window
(defun scroll-other-window-n-lines-ahead (&optional n)
  "Scroll ahead N lines (1 by default) in the other window"
  (interactive "P")
  (scroll-other-window (prefix-numeric-value n)))

(defun scroll-other-window-n-lines-behind (&optional n)
  "Scroll behind N lines (1 by default) in the other window"
  (interactive "P")
  (scroll-other-window (- (prefix-numeric-value n))))

(global-set-key "\C-\M-a" 'scroll-other-window-n-lines-behind)
(global-set-key "\C-\M-q" 'scroll-other-window-n-lines-ahead)

					;scrolling functions for scrolling one line at a time (WGE Chapter 2)
(defalias 'scroll-ahead 'scroll-up)
(defalias 'scroll-behind 'scroll-down)

(defun scroll-n-lines-ahead (&optional n)
  "scroll ahead n lines"
  (interactive "P")
  (scroll-ahead (prefix-numeric-value n)))

(defun scroll-n-lines-behind (&optional n)
  "scroll ahead n lines"
  (interactive "P")
  (scroll-behind (prefix-numeric-value n)))

(defun scroll-n-lines-left (&optional n)
  "scroll left n lines"
  (interactive "P")
  (scroll-left (prefix-numeric-value n)))

(defun scroll-n-lines-right (&optional n)
  "scroll left n lines"
  (interactive "P")
  (scroll-right (prefix-numeric-value n)))

(global-set-key "\C-z" 'scroll-n-lines-behind)
(global-set-key "\C-q" 'scroll-n-lines-ahead)
(global-set-key "\C-\M-a" 'scroll-n-lines-left)
(global-set-key "\C-\M-s" 'scroll-n-lines-right)
(global-set-key "\C-c\C-q" 'quoted-insert)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


