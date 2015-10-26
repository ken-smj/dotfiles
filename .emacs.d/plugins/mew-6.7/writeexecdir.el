(with-temp-buffer
  (progn
    (insert (format "[Make]\nBINDIR=%s\n" exec-directory))
    (write-file "mew2.ini")))
