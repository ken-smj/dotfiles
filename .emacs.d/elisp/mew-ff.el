;; http://www.mew.org/ml-archives/mew-dist/1999-February/007461.html
;; 小幡です。

;; >> In message <19990218204509B.GOTOH at example.com>,
;; >> Shun-ichi GOTO <gotoh at example.com> writes:

;; > 現在、dateの挿入は固定で行なわれていますが、formをtemplateとして考え、
;; > キーワードを置きかえる処理を定義できるようにしてみてはいかがでしょうか。

;; > (("To" ("mew-dist"      "~/form/mew-dist" ("DATE" . date-format1)
;; >                                           ("FROM" . from-format1))
;; >        ("foo at example.com" "~/form/foo"      ("DATE" . date-format2))
;; >   ))

;; > なんてアイディア、いかがでしょうか。

;; mew-refile-guess-by-alist1 を使うことに捕われていました。これは
;; 柔軟ですね。このアイディアをありがたく拝借します m(_r_)m

;; # 結果として、mew-refile-guess-by-alist1 をコピーしてこねくり回
;; # した別の guess 関数ができました。

;; また、キーワード置換は後藤さんのコードを借りて実装した後、

;; >> In message <19990219164903L.nom at example.com>,
;; >> Yoshinari NOMURA <nom at example.com> writes:

;; > 実は、mew-fib.el という、メールに穴埋めして回答するための仕組み
;; > が mew にはあったりします。この忘れられた機能とリンクすると面白
;; > いかもしれません。設定ファイルを用意しておいて、

;; こちらに浮気しました。mew にあるならそちらを使ってみようと。
;; mew-fib.el の置換機能だけを使ってます。こんなことしていいんでしょ
;; うか。

;; ということで、キーワード置換を実装した mew-ff.el を添付します。
;; これを利用するためには一緒に添付する mew-fib.el へのパッチが必要
;; です。パッチをあてても mew-fib.el の今までの機能は変わらず使えま
;; す。(キーワードを小文字に変換しなくなりましたが)

;; ■ 使い方

;; テンプレートファイル名を推測する mew-ff-guess-alist の指定、また
;; キーワード置換を用いる場合は mew-ff-replace-keywords-alist の指
;; 定を行います。

;; 1. mew-ff-guess-alist

;; テンプレートファイル名を推測するための連想リストで、書式は次のと
;; おりです。ヘッダ HEADER が文字列 KEY を含むとき、TEMPLATE をテン
;; プレートファイル名として用います。(最初に見付かった TEMPLATE が
;; 用いられます)

;;     (HEADER (KEY TEMPLATE)... )...

;; また、次のように置換キーワードの連想リストも指定できます。これら
;; はデフォルトの連想リスト mew-ff-replace-keywords-alist に優先し
;; ます。

;;     (HEADER (KEY TEMPLATE (REPLACE-FROM . REPLACE-TO)... )... )...

;; 例えば、次のように書きます。

;;     (setq mew-ff-guess-alist
;;           '(("To:"
;;              ("foo at example.com" "~/.ff-job"
;;               ("company" . "○○株式会社\n○○部 ○○課")
;;               ("to" . "○○ ○○ 様")
;;               )
;;              ("bar at example.com" "~/.ff-job"
;;               ("company" . "△△株式会社\n△△部 △△課")
;;               ("to" . "△△ △△ 様")
;;               ("hello" . "誠に申し訳ございません。")
;;               ))

;;             (t "~/.ff-default")
;;             ))

;; ただし上の例の最後にもあるように、例外として HEADER を t とし 
;; KEY を持たない次の書式を許します。これはリストの最後に置いて、デ
;; フォルトのテンプレートを指定するために用います。

;;     (t TEMPLATE)

;; あるいは

;;     (t TEMPLATE (REPLACE-FROM . REPLACE-TO)... )

;; ※ まだ mew-refile-guess-by-alist1 の使い方を追い切れてないため、
;;    このような仕様になっています。何か勘違いしてるかな？


;; 2. mew-ff-replace-keywords-alist

;; 置換キーワードのデフォルトを指定するための連想リストで、書式は次
;; のとおりです。

;;     (REPLACE-FROM . REPLACE-TO)...

;; テンプレート中の |>REPLACE-FROM<| が、REPLACE-TO に置換されます。
;; REPLACE-TO には文字列の他、関数、変数、および lambda 式を書くこ
;; とができ、これらは置換時に評価されます。

;; テンプレートと連想値を工夫することで、文字列を右詰めに置換できま
;; す。例えば、次のように書きます。

;;     (setq mew-ff-replace-keywords-alist
;;       '(("date" .
;;          (lambda () (format (format "%%%ds" fill-column)
;;                             (current-time-string))))
;;         ("from" .
;;          (lambda () (format (format "%%%ds\n%%%ds"
;;                                     fill-column fill-column)
;;                             "日本コントロールシステム(株)" "小幡 昇")))
;;         ("hello" . "いつもお世話になっております。")
;;         ))

;; インチキに見えますが、十分実用になります。


;; 3. テンプレートファイル

;; 例に合わせて、次のようなテンプレートを書きました。

;; ---- ここから
;; |>date<|
;; |>company<|
;; |>to<|
;; |>from<|
;; |>hello<|

;; ---- ここまで

;; キーワードのうち company, to, hello は 1. mew-ff-guess-alist の
;; 中で指定しています。このとき mew-ff-guess-alist の指定は、2. の
;; mew-ff-replace-keywords-alist の指定に優先します。


;; 4. インストール

;; mew に添付の mew-fib.el.patch を当てて作り直し、mew-ff.el を 
;; load-path の通ったディレクトリに置きます。1., 2. を参考に .emacs
;; の中に、mew-ff-guess-alist, mew-ff-replace-keywords-alist などの
;; 指定をします。また、次の指定を加えると良いでしょう (この辺り、最
;; 善の方法かどうか自信がありません)。

;; (require 'mew-ff)
;; (add-hook 'mew-before-cite-hook 'mew-ff)

;; 以上です。

;; -- 
;; 小幡 昇 (obata at example.com)
;; -------------- next part --------------
;;; mew-ff.el --- Fixed form insertion for Mew

;; Author:  OBATA Noboru <obata at example.com>
;; Created: Feb 18, 1999
;; Revised: Feb 19, 1999

(defvar mew-ff-guess-alist nil
  "*定型文テンプレートファイル名を推測するための連想リスト。
書式は次の通りで、ヘッダ HEADER が文字列 KEY を含むとき、TEMPLATE をテン
プレートファイル名として用いる。(最初に見付かった TEMPLATE が用いられる)

    (HEADER (KEY TEMPLATE)... )...

また、次のように置換キーワードの連想リストも指定できる。これらはデフォル
トの連想リスト \"mew-ff-replace-keywords-alist\" に優先する。

    (HEADER (KEY TEMPLATE (REPLACE-FROM . REPLACE-TO)... )... )...

例えば、次のように書く。

    (setq mew-ff-guess-alist
          '((\"To:\"
             (\"mew-dist at example.com\" \"~/.ff-mew-dist\"
              (\"hello\" . \"いつもお世話になっております。\")
              (\"date\" . (lambda ()
                            (format (format \"%%%ds\" fill-column)
                                    (current-time-string))))))
	    (t \"~/.ff-default\")
            ))

ただし上の例にもあるように、例外として HEADER を t とし KEY を持たない次
の書式を許す。これはリストの最後に置いて、デフォルトのテンプレートを指定
するために用いる。

    (t TEMPLATE) あるいは (t TEMPLATE (REPLACE-FROM . REPLACE-TO)... )")

(defvar mew-ff-replace-keywords-alist
  '(("date" . current-time-string)
    ("email" . user-mail-address)
    )
  "*置換キーワードのデフォルトの連想リスト。
キーワードを \"|>keyword<|\" のようにテンプレートに埋め込んでおくと、連想
値に置換される。連想値としては、文字列の他に、関数、変数、および lambda
式を書くことができる。これらは置換時に評価される。

テンプレートと連想値を工夫することで、文字列を右詰めに置換できる。例えば、
次のように書く。

    (setq mew-ff-replace-keywords-alist
          '((\"date\" .
             (lambda () (format (format \"%%%ds\" fill-column)
                                (current-time-string))))
            ))")

(defun mew-ff-guess-by-alist (alist)
  "メッセージからテンプレートファイル名を推測する。
連想リストのテンプレートファイル名以降を返す。ALIST の書式は
\"mew-ff-guess-alist\" を参照のこと。

例えば ALIST から

    (\"mew-dist at example.com\" \"~/.ff-mew-dist\"
     (\"hello\" . \"いつもお世話になっております。\"))

というサブリストが推測された場合、次のリストを返す。

    (\"~/.ff-mew-dist\" (\"hello\" . \"いつもお世話になっております。\"))

置換キーワードの連想リストがないような

    (\"mew-dist at example.com\" \"~/.ff-mew-dist\")

というサブリストが推測された場合は、テンプレートファイル名のみから成るリ
ストを返す。

    (\"~/.ff-mew-dist\")"
  (let (name header sublist key val ent ret)
    (while (and alist (not ret))
      (setq name (car (car alist)))
      (setq sublist (cdr (car alist)))
      (cond
       ((eq name t)
	(setq ret sublist))
       ;;((eq name nil)
       ;;(or ret (setq ret (cons sublist ret))))
       (t
	(setq header (mew-header-get-value name))
	(if header
	    (while (and sublist (not ret))
	      (setq key (car (car sublist)))
	      (setq val (cdr (car sublist)))
	      (if (and (stringp key) (string-match key header))
		  (cond
		   ((stringp (car val))
		    (setq ent
                          (mew-refile-guess-by-alist2 key header (car val))))
		   ((listp (car val))
		    (setq ent (mew-ff-guess-by-alist val)))))
              (if ent (setq ret val))
              (setq sublist (cdr sublist))))))
      (setq alist (cdr alist)))
    ret))

(defun mew-ff ()
  "メッセージの先頭に定型文を挿入する。"
  (interactive)
  (let* ((glist (mew-ff-guess-by-alist mew-ff-guess-alist))
         (file (car glist))
         (kwlist (cdr glist))
         deleted)
    (if file
        (let ((efile (expand-file-name file)))
          (if (not (file-exists-p efile))
              (message "No fixed form template file %s" efile)
            (progn
              (goto-char (mew-header-end))
              (forward-line)
              (save-restriction
                (narrow-to-region
                 (point) (+ (point) (car (cdr (insert-file-contents efile)))))
                (mew-fib-fill-by-alist kwlist)
                (mew-fib-fill-by-alist mew-ff-replace-keywords-alist)
                (mew-fib-delete-frame)
                (goto-char (point-max)))))))))

(provide 'mew-ff)

;;; mew-ff.el ends here
