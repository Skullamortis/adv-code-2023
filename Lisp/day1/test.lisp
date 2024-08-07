(defvar +day-1-a+ (uiop:read-file-lines "~/Scripts/Lisp/adv2023/day1/input2.txt"))

;;(defun extract-digit (string)
;;  (loop for c across string
;;        for x = (read-from-string (string c))
;;        if (typep x 'integer)
;;          return x))
(defun extract-digit (char)
  (if (digit-char-p char)
      (parse-integer (string char))
      0))
(defun make-number (string)
  (+ (* 10 (extract-digit string))
     (extract-digit (reverse string))))

(defvar numbers)
(setf numbers (map 'list #'make-number +day-1-a+))

(defvar answer-1a)
(setf answer-1a (reduce #'+ numbers))

;; part-2


(defvar abc-digits)
(setf abc-digits '("zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))
(defvar digits)
(setf digits '("z0o" "o1e" "t2o" "t3e" "f4r" "f5e" "s6x" "s7n" "e8t" "n9e")) ;; digits from 0 to 9 can share at most one letter

(defun abc-to-digit (string)
  (loop for abc in abc-digits
        for dig in digits
        with x = string
        do (setf x (ppcre:regex-replace-all abc x dig))
        finally (return x)))

(defvar improved-inputs)
(setf improved-inputs (map 'list #'abc-to-digit +day-1-a+))

(defvar numbers-1b)
(setf numbers-1b (map 'list #'make-number improved-inputs))

(defvar answer-1b)
(setf answer-1b (reduce #'+ numbers-1b))
