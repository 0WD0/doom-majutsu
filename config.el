;;; tools/majutsu/config.el -*- lexical-binding: t; -*-

;; Declare autoloaded commands via use-package! for lazy loading
(use-package! majutsu
  :defer-incrementally (dash f s with-editor package eieio transient)
  :init
  ;; Match Doom's Magit module: set these before Majutsu can load transient.
  (setq transient-levels-file  (file-name-concat doom-profile-data-dir "transient" "levels")
        transient-values-file  (file-name-concat doom-profile-data-dir "transient" "values")
        transient-history-file (file-name-concat doom-profile-data-dir "transient" "history"))
  :config
  (set-popup-rule! "^\\(?:\\*majutsu\\|majutsu:\\)" :ignore t)
  ;; Match Doom's Magit module: keep Magit's core "TAB" behavior in the
  ;; package, and add an explicit Evil normal-state [tab] binding here so
  ;; Doom's smart-tab dispatcher doesn't intercept collapsed sections first.
  (when (modulep! :editor evil +everywhere)
    (define-key! 'normal majutsu-mode-map
      [tab] #'majutsu-section-toggle)))

;; Keybindings: `SPC j` prefix (evil leader)
(when (modulep! :editor evil)
  (map! :leader
        (:prefix ("j" . "Majutsu")
         :desc "Majutsu log"       "j" #'majutsu
         ;; :desc "Rebase menu"       "r" #'majutsu-rebase-transient
         ;; :desc "Bookmark menu"     "b" #'majutsu-bookmark-transient
         ;; :desc "Git menu"          "g" #'majutsu-git-transient
         :desc "Commit"            "C" #'majutsu-commit
         :desc "Describe"          "c" #'majutsu-describe
         :desc "Diff"              "d" #'majutsu-diff-dwim)))

(add-hook! 'doom-real-buffer-functions
  (defun +majutsu-buffer-p (buf)
    (with-current-buffer buf
      (derived-mode-p 'majutsu-mode))))
