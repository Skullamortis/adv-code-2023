(defpackage #:part2
  (:use #:common-lisp #:alexandria #:cl-ppcre)
  (:export #:read-file-into-variable
           #:concatenate-lists-digit-wise
           #:merge-lists
           #:pad-sublists))

(in-package #:part2)

(defvar lines nil)
(defvar list_numbers nil)
(defvar first_n nil)
(defvar last_n nil)
(defvar size_of_list nil)
(defvar first_and_last nil)
(defvar list_numbers nil)
(defvar numbers_words nil)
(defvar i nil)
(defvar j nil)
(defvar k nil)
(defvar final_words nil)
(defvar merged nil)
(defvar padded_sublist nil)
(defvar concatenated_numbers nil)
(defvar a nil)
(defvar b nil)
(defvar numbers nil)
(defvar file-name "input2.txt")
(defvar start nil)
(defvar last_items nil)

(defun read-file-into-variable (file-name &optional (chunk-size 1024))
  (with-open-file (file (merge-pathnames file-name))
    (let ((lines '())
          (buffer (make-string chunk-size :element-type 'base-char)))
      (loop for chunk = (read-sequence buffer file)
            while (not (zerop chunk))
            do
               (let ((start 0)
                     (end (position #\Newline buffer :start 0 :end chunk)))
                 (loop while end
                       do (progn
                            (push (subseq buffer start end) lines)
                            (setq start (1+ end))
                            (setq end (position #\Newline buffer :start start :end chunk)))))
               (unless (zerop start)
                 (push (subseq buffer start) lines)))
      (nreverse lines))))

(defun concatenate-lists-digit-wise (list1 list2)
  (mapcar #'(lambda (a b)
              (if (and a b)  ; Check for nil values
                  (concatenate 'list (list a b))
                  nil))
          list1 list2))

(defun merge-lists (lists)
  (apply #'mapcar #'(lambda (&rest args)
                      (apply #'+
                             (delete-duplicates args :test #'=)))
         lists))

(defun pad-sublists (lists)
  (if (null lists)
      nil
      (let* ((max-length (apply #'max (mapcar #'length lists))))
        (mapcar (lambda (lst) (append lst (make-list (- max-length (length lst)) :initial-element 0))) lists))))

;; --------------------------------

(setq lines (read-file-into-variable file-name))
(setq final_words nil)
(setq list_numbers '(("one" "1") ("two" "2") ("three" "3") ("four" "4") ("five" "5") ("six" "6") ("seven" "7") ("eight" "8") ("nine" "9")))
(setq numbers nil)
(setq concatenated_numbers nil)
(setq padded_sublist nil)
(setq final_words nil)
(setq first_and_last nil)
(setq a nil)
(setq b nil)
(setq last_items nil)
(setq merged nil)
(setq size_of_list nil)
(setq numbers_words nil)
(setq first_n nil)
(setq last_n nil)


(loop for x in lines
      do
         (setq numbers nil)
         (loop for y in list_numbers
               do
                  (setq i (car y))
                  (setq j (first(cdr y)))
                  (setq k x)
                  (if (ppcre:all-matches i x)
                      (push (ppcre:regex-replace-all "[^0-9]" (ppcre:regex-replace-all i x j) "0") numbers)
                      )
                  ;;                  (format t "~a~% " (first(cdr y )))
               )
         (push numbers final_words))
(loop for q in final_words
      do
         (setq a nil)
         (loop for l in q
               do
                  (setq b nil)
                  (loop for c across l do (push (digit-char-p (coerce c 'character)) b))
                  (setq b (reverse b))
                  (push b a)
               )
         (push a first_and_last)
      )

(loop for x in first_and_last do
  (setq padded_sublist (pad-sublists x))
  (setq merged (merge-lists padded_sublist))
  (push merged last_items))

(dolist (m last_items)  (push (remove 0 m) size_of_list))
(dolist (m size_of_list) (push (first m) first_n))
(dolist (n size_of_list) (push  (first (last n)) last_n))

(setq numbers_words  (concatenate-lists-digit-wise first_n last_n))

(dolist (n numbers_words)
  (let ((formatted-value (format nil "~{~a~}" n)))
    (format t "Original Value: ~a~%" formatted-value)
    (handler-case
        (let ((parsed-value (parse-integer formatted-value :junk-allowed t)))
          (if parsed-value
              (format t "Parsed Value: ~a~%" parsed-value)
              (format t "Unable to parse value ~a~%" formatted-value))
          (push (if parsed-value parsed-value 0) concatenated_numbers))
      (type-error (e)
        (format t "Error parsing value ~a: ~a~%" formatted-value e)
        (push 0 concatenated_numbers))
      (error (e)
        (format t "Unexpected error: ~a~%" e)
        (push 0 concatenated_numbers)))))

(format t "~a~%" (apply #'+ concatenated_numbers))
