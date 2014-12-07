; -*- Mode: Emacs-Lisp ; Coding: utf-8 -*-

;; ------------------------------------------------------------------------
;; @ css-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist       
     (cons '("\\.css\\'" . css-mode) auto-mode-alist))
(setq cssm-indent-level 8)
(setq cssm-indent-function #'cssm-c-style-indenter)
;; CATALOGとECATの位置設定
(setq sgml-catalog-files '("CATALOG" "~/src/DTD/CATALOG"))
(setq sgml-ecat-files '("ECAT" "~/src/DTD/ECAT"))
;; C-c C-u C-dで挿入可能なDTDの設定
(setq sgml-custom-dtd
 '(
   ("XHTML 1.0 Strict"
    "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\"><!-- -*- coding: utf-8 -*- -->\n")
   ("XHTML 1.0 Transitonal"
   "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\"><!-- -*- coding: utf-8 -*- -->\n")
   ("Ant 1.4.1 DTD"
   "<!DOCTYPE project PUBLIC \"-//ANT//DTD project//EN\" \"ant.dtd\"><!-- -*- coding: utf-8 -*- -->\n")
   ))
;; 色付け
(add-hook 'xml-mode-hook
          (function (lambda()
                      (make-face 'sgml-comment-face)
                      (make-face 'sgml-start-tag-face)
                      (make-face 'sgml-end-tag-face)
                      (make-face 'sgml-doctype-face)
                      (set-face-foreground 'sgml-comment-face "gray")
                      (set-face-foreground 'sgml-start-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-end-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-doctype-face "Green")
                      (setq sgml-set-face t)
                      (setq sgml-markup-faces
                            '(
                              (comment   . sgml-comment-face)
                              (start-tag . sgml-start-tag-face)
                              (end-tag   . sgml-end-tag-face)
                              (doctype   . sgml-doctype-face)
                              )))))
;; sgml-mode hookで変数をsetq
(add-hook 'sgml-mode-hook
          (lambda ()
            (setq tab-width                             4
                  sgml-indent-step                      4
		  sgml-indent-data                      t
                  indent-tabs-mode                      t
                  sgml-xml-p                            t
                  sgml-always-quote-attributes          t
                  sgml-system-identifiers-are-preferred t
                  sgml-auto-activate-dtd                t
                  sgml-recompile-out-of-date-cdtd       t
                  sgml-auto-insert-required-elements    t
                  sgml-insert-missing-element-comment   t
                  sgml-balanced-tag-edit                t
                  sgml-default-doctype-name             "XHTML 1.0 Strict"
                  sgml-ecat-files                       nil
                  sgml-general-insert-case              'lower
                  sgml-entity-insert-case               'lower
                  sgml-normalize-trims                  t
                  sgml-insert-defaulted-attributes      nil
                  sgml-live-element-indicator           t
                  sgml-active-dtd-indicator             t
                  sgml-minimize-attributes              nil
                  sgml-omittag                          nil
                  sgml-omittag-transparent              nil
                  sgml-shorttag                         nil
                  sgml-tag-region-if-active             t
                  sgml-xml-validate-command             "xmllint --noout --valid %s %s"

                  )
            ))
(setq sgml-custom-markup  ; C-c C-u RET
      '(("html-att"
	 "xmlns=\"http://www.w3c.org/1999/xhtml\" xml:lang=\"ja\" lang=\"ja\"")
	("link-att"
	 "rel=\"stylesheet\" type=\"text/css\" href=\"./css/GMWorks_sty.css\" media=\"all\"")
	("meta"
	 "<meta http-equiv=\"content-type\" content=\"application/xhtml+xml; charset=utf-8\" />")
))
;; ------------------------------------------------------------------------
