(defparameter file-name "input.txt")
(defparameter *data* nil)
(defparameter *size* nil)
(defparameter *parts* nil)
(defparameter *concatenated-numbers* nil)

(defun read-file-into-variable (file-name)
  (with-open-file (file (merge-pathnames file-name))
    (loop for line = (read-line file nil 'eof)
          until (eq line 'eof)
          collect line)))

(setq *data* (read-file-into-variable file-name))

(defun list-to-matrix (list)
  (let* ((size (length list))
         (dimensions (list size size)))
    (setq *data* (make-array dimensions :initial-contents list))
    (setq *size* (- size 1))
    ))

(defun transform-into-list-chars (data)
  (let* ((array-of-chars nil))
    (loop for element in data do
      (push (coerce element 'list) array-of-chars)
          )
    (setq *data* (reverse array-of-chars))
    )
  )

(list-to-matrix (transform-into-list-chars *data*))
(format t "~a~%" *data*)

(defun char-symbolp (c)
  (declare (type character c))
  (not (or (digit-char-p c)
           (char= c #\.))))

(defun do-parts (data)
  (loop for x from 0 to *size* do
    (let ((current-part nil) (ispart nil))
      (loop for y from 0 to *size* do
        (if (digit-char-p (aref data x y))
            (progn
              (push (aref data x y) current-part)
              ;; Corners
              (when (and (= x 0) (= y 0))
                (when (or (char-symbolp (aref data (+ x 1) y)) (char-symbolp (aref data (+ x 1) (+ y 1))) (char-symbolp (aref data x (+ y 1)))) (setq ispart t)))
              (when (and(= x 0) (= y 9))
                (when (or (char-symbolp (aref data (+ x 1) y)) (char-symbolp (aref data (+ x 1) (- y 1))) (char-symbolp (aref data (+ x 1) (- y 1)))) (setq ispart t)))
              (when (and (= x 9) (= y 0))
                (when (or (char-symbolp (aref data (- x 1) y)) (char-symbolp (aref data (- x 1) (+ y 1))) (char-symbolp (aref data x (+ y 1)))) (setq ispart t)))
              (when (and(= x 9) (= y 9))
                (when (or (char-symbolp (aref data x (- y 1))) (char-symbolp (aref data (- x 1) (- y 1))) (char-symbolp (aref data (- x 1) y))) (setq ispart t)))
              ;; Laterals
              (when (and(> x 0) (= y 0) (< x 9))
                (when (or (char-symbolp (aref data (- x 1) y))(char-symbolp (aref data (- x 1) (+ y 1)))(char-symbolp (aref data x (+ y 1))) (char-symbolp (aref data (+ x 1) (+ y 1))) (char-symbolp (aref data (+ x 1) y))) (setq ispart t)))
              (when (and(> x 0) (= y 9) (< x 9))
                (when (or (char-symbolp (aref data (- x 1) y))(char-symbolp (aref data (- x 1) (- y 1)))(char-symbolp (aref data x (- y 1))) (char-symbolp (aref data (+ x 1) (- y 1))) (char-symbolp (aref data (+ x 1) y))) (setq ispart t)))
              ;; Top and Bottom
              (when (and(= x 0) (> y 0) (< y 9))
                (when (or (char-symbolp (aref data (+ x 1) y)) (char-symbolp (aref data (+ x 1) (+ y 1))) (char-symbolp (aref data x (+ y 1))) (char-symbolp (aref data (+ x 1) (- y 1))) (char-symbolp (aref data x (- y 1)))) (setq ispart t)))
              (when (and(= x 9) (> y 0) (< y 9))
                (when (or (char-symbolp (aref data (- x 1) y))(char-symbolp (aref data (- x 1) (- y 1)))(char-symbolp (aref data x (- y 1))) (char-symbolp (aref data x (+ y 1))) (char-symbolp (aref data (- x 1) (+ y 1)))) (setq ispart t)))
              ;; Center
              (when (and(> x 0) (< x 9) (> y 0) (< y 9))
                (when (or (char-symbolp (aref data (- x 1) (- y 1))) (char-symbolp (aref data x (+ y 1))) (char-symbolp (aref data x (- y 1))) (char-symbolp (aref data (+ x 1) (+ y 1))) (char-symbolp (aref data (- x 1) y)) (char-symbolp (aref data (+ x 1) y)) (char-symbolp (aref data (+ x 1) (- y 1))) (char-symbolp (aref data (- x 1) (+ y 1)))) (setq ispart t)))
              ))
        (if (and (not(digit-char-p (aref data x y))) current-part ispart)
            (progn
              (format t "Added part: ~a at: x:~a , y:~a~%" (reverse current-part) x y)
              (push (reverse current-part) *parts*)
              (setq current-part nil)
              (setq ispart nil)
              ))
            )
      (if ispart
          (progn
            (format t "Added part at end of line: ~a~%" (reverse current-part))
            (push (reverse current-part) *parts*)
            (setq current-part nil)
            (setq ispart nil)
            ))
      (setq ispart nil)
      )
        )
  )

(do-parts *data*)

(format t "~a~%" (reverse *parts*))
(loop for element in *parts* do
  (push (parse-integer(concatenate 'string element)) *concatenated-numbers*)
      )

(format t "~a~%" (apply #'+ *concatenated-numbers*))
