(eval-when (:compile-toplevel)
  (ql:quickload "cl-ppcre"))

(defvar file-name "input3.txt")
(defvar lines nil)
(defparameter numbers nil)
(defvar size_of_list nil)
(defvar first_and_last nil)
(defvar list_numbers nil)
(defparameter numbers_words nil)
(defparameter k nil)
(defparameter z nil)
(defparameter s nil)
(defparameter final_words nil)
(defparameter b nil)
(defparameter last_items nil)
(defparameter concatenated_numbers nil)
(defparameter get_last nil)
(defparameter subs_word nil)
(defparameter ty nil)

(defun read-file-into-variable (file-name)
  (with-open-file (file (merge-pathnames file-name))
    (loop for line = (read-line file nil 'eof)
          until (eq line 'eof)
          collect line)))

(setq lines (read-file-into-variable file-name))

(setq list_numbers '(("one" "1") ("two" "2") ("three" "3") ("four" "4") ("five" "5") ("six" "6") ("seven" "7") ("eight" "8") ("nine" "9")))

(loop for element in list_numbers do
  (let ((ty (copy-seq (first element))))
    (setf (subseq ty 1 (ceiling (length ty) 2)) (first (cdr element)))
    (push ty subs_word)
    ))
(setq subs_word (reverse subs_word))

(loop for x in lines
      do
         (setq numbers nil)
         (loop for y in list_numbers
               for z in subs_word
               do
                  (if (ppcre:all-matches (car y) x)
                      (push
                       (ppcre:regex-replace-all (car y) x z)
                       numbers)))
         (push x numbers)
         (push numbers final_words))

(loop for q in final_words
      do
         (setq k (first q))
         (loop for s across k do (push s numbers_words))
         (setq numbers_words (reverse numbers_words))
         (loop for l in (reverse (cdr q))
               do
                  (loop for x from 0 to (length l)
                        for y across l
                        do
                           (if  (and (digit-char-p y) (not (digit-char-p (nth x numbers_words))))
                                (setf (nth x numbers_words) y))))
         (push (ppcre:regex-replace-all "[^0-9]" (format nil "~{~A~}" numbers_words) "") b)
         (setq numbers_words nil)
      )

(loop for element in b
      do
         (setq get_last (- (length element) 1))
         (push (parse-integer (format nil "~a~a" (char element 0) (char element get_last))) concatenated_numbers))

(format t "~a~%"  (apply #'+ concatenated_numbers))
