;;(with-open-file (stream "exemplo_01.txt")
;;  (do ((line (read-line stream nil)
;;             (read-line stream nil)))
;;      ((null line))
;;    (print line)))
(ql:quickload "cl-ppcre")
(defvar file-name "input_final.txt")
(defvar lines nil)
(defvar a nil)
(defvar numbers nil)
(defvar first_n nil)
(defvar last_n nil)
(defvar size_of_list nil)
(defvar first_and_last nil)

(defun read-file-into-variable (file-name)
  (with-open-file (file (merge-pathnames file-name))
    (loop for line = (read-line file nil 'eof)
          until (eq line 'eof)
          collect line)))

(defun concatenate-lists-digit-wise (list1 list2)
  (mapcar #'(lambda (a b) (concatenate 'list (list a b)))
          list1 list2))

(setq lines (read-file-into-variable file-name))
(setq numbers nil)
(dolist (n lines) (push (ppcre:all-matches-as-strings "\\d" n ) numbers ))
(setq numbers (reverse numbers))

(setq first_n nil)
(setq last_n nil)
(dolist (m numbers) (push (first m) first_n))
(dolist (n numbers) (push  (first (last n)) last_n))

(setq size_of_list nil)
(setq first_and_last  (reverse (concatenate-lists-digit-wise first_n last_n)))
(dolist (n first_and_last) (push (parse-integer (format nil "~{~a~}" n)) size_of_list))
(setq size_of_list (reverse size_of_list))

(format t "~a~% " size_of_list)
(format t "~a " (apply #'+ size_of_list))
