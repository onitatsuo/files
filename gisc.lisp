;4.8

(defun emphasize3 (x)
  (cond ((equal (first x) 'good) (cons 'great (rest x)))
        ((equal (first x) 'bad) (cons 'aweful (rest x)))
        (t (cons 'very x))))


;4.9

(defun make-odd (x)
  (cond ((not (oddp x)) (+ x 1))
        (t x)))

;4.10
(defun constrain (x min max)
  (cond ((< x min) min)
        ((> x max) max)
        (t x)))

(defun constrain-if (x min max)
  (if (< x min) min
      (if (> x max) max
          x)))

;4.11

(defun firstzero (x)
  (cond ((equal (cdr x) 0) 'first)
        ((equal (cadr x) 0) 'second)
        ((equal (caddr x) 0) 'third)
        (t 'none)))

;4.12
(defun cycle (x)
  (cond ((< x 99)) (+ x 1)
        (t 1)))


; 4.13
(defun compute (op x y)
  (cond ((equal op 'sum-of) (+ x y))
        ((equal op 'product-of) (* x y))
        (t '(that does not compute))))

(defun howcompute (op x y)
  (cond ((equal y (+ op x)) 'sum-of)
        ((equal y (* op x)) 'product-of)
        (t '(beats me))))

;4.15

(defun geq (x y)
  (or (and (> x y))
      (and (equal x y))))

;4.16
(defun test-fun (x)
  (or   (and (oddp x) (> x 0) (* x x))
        (and (oddp x) (< x 0) (+ x x))
        (/ x 2)))

;4.17
(defun boy-girl (x y)
  (or (or (and (equal x 'boy) (equal x 'girl) (equal y 'child)))
      (or (and (equal x 'man) (equal x 'woman) (equal y 'adult)))))

;4.18

(defun play (p1 p2)
  (or (and (equal p1 p2) 'tie)
      (and (equal p1 'rock) (equal p2 'scissors) 'first-wins)
      (and (equal p1 'scissors) (equal p2 'paper) 'first-wins)
      (and (equal p1 'paper) (equal p2 'rock) 'first-wins)
       'second-wins))

;4.19
;I don't know what it means

;4.20
;4.21
;4.22

(defun boilingp (temp scale)
  (cond ((equal scale 'celcius) (> temp 100))
        ((equal scale 'fahrenheit) (> temp 212))
        (t nil)))

(defun boilingp1 (temp scale)
  (if (equal scale 'celcius) (> temp 100)
      (if (equal scale 'fahrenheit) (> temp 212)
          nil)))

(defun boilingp2 (temp scale)
  (or (and (equal scale 'celcius) (> temp 100))
      (and (equal scale 'fahrenheit) (> temp 212))
      nil))


(defun logical-and (x y)
  (and x y t))


(defun logical-if (x y)
  (if x (if y t) nil))
;can remove nil here

(defun logical-cond (x y)
  (cond (x (cond (y t)))))

;4.30
(defun logical-or (x y)
  (cond (x t)
        (y t)
        (t nil)))


(defun nand (x y) (not (and x y)))
(defun not2 (x) (nand x x))

(not (or (not x) (not y))) ;and
(not (and (not x) (not y))) ;or

(defun l-a (x y)
  (nand (x (nand x y))))

(defun nand-and (x y)
  (nand (nand x y) (nand x y)))

(defun nand-or (x y)
  (nand (nand x x) (nand y y)))








;
(defun good-style (g)
  (let ((g (+ g 5)))
    (list 'result 'is g)))

;;; 5.6 dice

(defun throw-die ()
  (+ 1 (random 6)))

(defun throw-dice ()
  (list (throw-die) (throw-die)))

(defun snake-eyes-p (throws)
  (equal '(1 1) throws))

(defun boxcarsp (throws)
  (equal '(6 6) throws))

(defun throw-value (throws)
  (+ (first throws) (second throws)))

(defun instant-win-p (throws)
  (member (throw-value throws) '(7 11)))

(defun instant-loss-p (throws)
  (member (throw-value throws) '(2 3 12)))

(defun say-throw (throws)
  (cond ((snake-eyes-p throws) 'snake-eyes)
        ((boxcarsp throws) 'boxcars)
        (t (throw-value throws))))


(defun craps ()
  (let ((throws (throw-dice)))
    (append
       (list 'throw (first throws)
             'and (second throws)
             '--
             (say-throw throws)
             '--)
       (cond ((instant-win-p throws) '(you win))
             ((instant-loss-p throws) '(you lose))
             (t (list 'your 'point 'is
                      (throw-value throws)))))))

(defun try-for-point (point)
  (let* ((throws (throw-dice))
        (val (throw-value throws)))
    (append
       (list 'throw (first throws)
             'and (second throws)
             '--
             val
             '--)
       (cond ((equal val point) '(you win))
             ((equal val 7) '(you lose))
             (t '(throw again))))))

;; (defun craps ()
;;   (cond ((snake-eyes-p (throw-dice)) (list 'throw '1 'and '1 '-- 'snake-eyes '-- 'you 'lose))
;;         ((boxcarsp (throw-dice)) (list 'throw '6 'and '6 '-- 'boxcars '-- 'you 'lose))
;;         ((instant-win-p (throw-dice)) (list 'throw (first (throw-dice)) 'and (second (throw-dice)) '-- (throw-value (throw-dice)) '-- 'you 'win))
;;         ((instant-loss-p (throw-dice)) (list 'throw (first (throw-dice)) 'and (second (throw-dice)) '-- (throw-value (throw-dice)) '-- 'you 'lose))
;;         ((throw-value (throw-dice)) (list 'throw (first (throw-dice)) 'and (second (throw-dice)) '-- 'your 'point 'is (throw-value (throw-dice))))))


 ;; (defun say-throws (throws)
;;   (or (snake-eyes-p 'snake-eyes)
;;       (boxcarsp 'boxcars)
;;       (throw-value throws)))










;; (defun throw-die ()
;;   (let ((throw1 (random 7))
;;         (throw2 (random 7)))
;;     (list throw1 throw2)))


;; (defun pred ()
;;   (let* ((throw1 (random 7))
;;          (throw2 (random 7)))
;;     (or (equal throw1 throw2))))

;; (defun snake-eyes-p ()
;;   (let ((throw1 (random 7)))
;;     (equal throw1 1)))

;; (defun boxcars-p ()
;;   (let ((throw2 (random 7)))
;;     (equal throw2 6)))

;; (defun instant-win-p (x)
;;   (or (equal x 7) (equal x 11)))

;; (defun instant-loss-p (x)
;;   (or (equal x 2) (equal x 3) (equal x 12)))

;; (defun throw-add ()
;;   (let* ((throw1 (random 7))
;;          (throw2 (random 7))
;;          (sum (+ throw1 throw2)))
;;     (car (list sum))))

;; (defun say-throw ()
;;   ())


 ;; (defun throw-add ()
 ;;  (let* ((throw1 (random 7))
 ;;         (throw2 (random 7))
 ;;         (sum (+ throw1 throw2)))
 ;;    (car (list sum))))

;; (defun say-throw (x)
;;   (let ((sum (apply '+ x)))
;;     (cond ((and (equal (car x) 1) (equal (cadr x) 1)) 'snake-eyes)
;;           ((and (equal (car x) 6) (equal (cadr x) 6)) 'boxcars)
;;           (sum))))


;; (defun craps ()
;;   (cond ((equal (say-throw (throw-die)) 'snake-eyes) (list 'throw (car (throw-die)) 'and (cadr (throw-die)) '-- 'snake-eyes '-- 'you 'lose))
;;         ((equal (say-throw (throw-die)) 'boxcars) (list 'throw (car (throw-die)) 'and (cadr (throw-die)) '-- 'boxcars '-- 'you 'win))
;;         ((instant-win-p (throw-die)) (list 'throw (car (throw-die)) 'and (cadr (throw-die)) '-- (say-throw (throw-die)) '-- 'you 'win))
;;         ((instant-loss-p (throw-die)) (list 'throw (car (throw-die)) 'and (cadr (throw-die)) '-- (say-throw (throw-die)) '-- 'you 'lose))
;;         ((list 'throw (car (throw-die)) 'and (cadr (throw-die)) '-- 'points '= (say-throw (throw-die))))))



;test



;;;;;;;;; 6.6

(defun last-element (list)
  (first (last list)))

(defun last-element-r (list)
  (first (reverse list)))

(defun last-element-n (list)
  (nth (- (length list) 1) list))

;;;;6.7

(defun next-to-last (list)
  (first (rest (reverse list))))

(defun next-to-last-n (list)
  (nth 1 (reverse list)))

;;;; 6.8

(defun my-butlast (list)
  (remove (first (last list)) list))

(defun my-butlast-r (list)
  (reverse (rest (reverse list))))

;;; 6.10

(defun palindromep (list)
  (if (equal (reverse list) list)
      T
      nil))

;;; 6.11

(defun make-palindrome (list)
  (append list (reverse (remove (first (last list)) list))))

(defun make-palindrome-t (list)
  (append list (reverse list)))

;; 6.12 it has to copy it because it returns either the beginning
;; of the member in that list or nil / empty list

;;; intersection interesting

;;; 6.15

(defun contains-the-p (sent)
  (member 'the sent))

(defun contains-article-p (sent)
  (or   (member 'the sent)
        (member 'a sent)
        (member 'an sent)))

(defun constains-article-i (sent)
  (intersection '(a an the) sent))

(defun add-vowels (letters)
  (union '(a e i o u) letters))

(defun my-subsetp (x y)
  (subsetp y x))

;(setf a '(soap water))

(defun set-equal (setx sety)
  (if (equal (length setx) (length sety))
      (subsetp setx sety)))

(defun proper-subsetp (setx sety)
  (and  (not (set-equal setx sety)) (subsetp setx sety)))


 (defun right-side (list)
   (rest (member '-vs- list)))

;(defun left-side (list)
;  (reverse (rest (member '-vs- (reverse list)))))

(defun left-side (list)
  (right-side (reverse list)))

(defun count-common (list)
  (intersection (right-side list) (left-side list)))

(defun compare (list)
  (list (length (count-common list)) 'common 'features))

(setf produce '((apple   . fruit)
                (celery  . veggie)
                (banana  . fruit)
                (lettuce . veggie)))
(setf books '((booka . authora)
              (bookb . authorb)
              (bookc . authorc)
              (bookd . authord)
              (booke . authore)))

(defun who-wrote (bookname)
  (cdr (assoc bookname books)))

(setf atlas '((new-jersey newark princeton trenton)
              (pennslyvania johnstown pittsburgh)
              (ohio columbus)))

(setf nerd-states '((sleeping    . eating)
                    (eating      . computer)
                    (computer    . programming)
                    (programming . debugging)
                    (debugging   . sleeping)))

(defun nerdus (state)
  (cdr (assoc state nerd-states)))

(defun sleepless-nerd ()
  (subst 'eating 'sleeping
         nerd-states))

;; (defun nerd-on-caffeine ()
;;   (sublis '((sleeping    . computer)
;;             (computer    . debugging)
;;             (debugging   . eating)
;;             (eating      . programming)
;;             (programming . sleeping))
;;           nerd-states))
(defun sleepless-nerd (x)
  (let ((y (nerdus x))
        (if (equal y 'sleeping)
            (nerdus y)
            y))))



(defun nerd-on-caffeine (x)
  (nerdus (nerdus x)))

;6.36

;; (defun swap-first-last (list)
;;   ((first (reverse list) ) (second (reverse list))))


;; (defun swap-first-last (list)
;;   (append (reverse (cddr (reverse list)))
;;            (list (second (reverse list)) (first (reverse list)))))

(defun swap-first-last (rist)
  (append (last rist) (cdr (reverse rist))))

;6.37
(defun rotate-left (rist)
  (append (cdr rist) (list (first rist))))

(defun rotate-right (rist)
  (append (last rist) (reverse (cdr (reverse rist)))))

(setf alpha '(a b c d))

;keyboard exercise 2


(setf rooms-map
      '((living-room
                           (north front-stairs)
                           (south dining-room)
                           (east kitchen))
        (upstairs-bedroom
                           (west library)
                           (south front-stairs))
        (dining-room
                           (north living-room)
                           (east pantry)
                           (west downstairs-bedroom))
        (kitchen
                           (west living-room)
                           (south pantry))
        (pantry
                           (north kitchen)
                           (west dining-room))
        (downstairs-bedroom
                           (north back-stairs)
                           (east dining-room))
        (back-stairs
                           (south downstairs-bedroom)
                           (north library))
        (front-stairs
                           (north upstairs-bedroom)
                           (south living-room))
        (library
                           (east upstairs-bedroom)
                           (south back-stairs))))

(defun choices (room-name)
  (rest (assoc room-name rooms-map)))

(defun look (room-name direction)
  (first (rest (assoc direction (choices room-name)))))

(defun set-robbie-location (place)
  "Moves Robbie to PLACE by setting the variable LOC."
  (setf loc place))

(defun how-many-choices (place)
  (length (choices place)))

(defun upstairsp (place)
  (or (equal 'upstairs-bedroom place)
      (equal 'library          place)))

(defun onstairsp (place)
  (or (equal 'front-stairs place)
      (equal 'back-stairs  place)))

;to write where I need to use how many choices
; upstairs, front/back are already defined
; if the predicates return T return that location

(defun where ()
  (cond ((upstairsp loc)  (list 'Robbie 'is 'upstairs 'in 'the loc))
        ((onstairsp loc) (list 'Robbie 'is 'on 'the loc))
        (t (list 'Robbie 'is 'downstairs 'in 'the loc))))

(defun move (dir)
  (let ((new-loc (look loc dir)))
    (cond ((null new-loc)
           '(ouch! robbie hit a wall))
          (t (set-robbie-location new-loc)
             (where)))))

;trees
;subst replaces 2 with 1
; returns original list if sym not found

;sublis makes many subs
;can use lists with dotted pairs

(setf royal '(if I learn lisp I will be pleased))
;6.42
(defun royal-we (list)
  (subst 'we 'i list))

;eq should only be used for pointers/symbols and not numbers or lists
;eql numbers of diff types are not equal
;= is the best for numbers gives errors for non-numbers
;member and assoc use eql as the predicate
;equalp ignores cases
;so it is different from equal

;;;;;
;equal does what you want, USE IT
;member and assoc use eql
;^^^remember these two
;;;;;;;

; remove :count x
; remove :count x :from-end t
;; ^^^ : < is a keyword arguement

; keywordp

;member is also a keyword function
; :test #'equal
; member uses eql ususally so this can't compare lists

;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; :test keywords ;;;;;;;;;
; all functions that include equality tests accept :test keywords
; union, intersection, set-difference, assoc rassoc, subst, sublis
;;;;;


;;; cannot use #' with macros or special function

;; mapcar applies a function each elemnt of a list

(defun add1 (x)
  (+ 1 x))

; 7.2

(setf daily-planet '((olsen jimmy 123-76-4535 cub-reporter)
                     (kent  clark 089-52-6787 reporter)
                     (lane  lois  951-26-1438 reporter)
                     (white perry 355-16-7439 editor)))


(lambda (n) (if (equal n (or T nil)) T))
(lambda (n) (or (null n) (equal T n)))

(defun flip (list)
  (sublis '((up . down) (down . up))
          list))

; 7.7 think about this one more

; find-if is an applicative operator
; uses a predicate and a list returns the first T
(setf words '((un one)
              (deux two)
              (trois three)
              (quatre four)
              (cinq five)))

(defun my-assoc (key table)
  (find-if #'(lambda (entry)
               (equal key (first entry)))
           table))

(defun roughly-equal (e k)
  (and (not (< e (- k 10)))
       (not (> e (+ k 10)))))

(defun find-first (x k)
  (find-if #'(lambda (e) (roughly-equal e k))
           x))

(defun find-nested (x)
  (find-if #'consp x))

(setf note-table '((c       1)
                   (c-sharp 2)
                   (d       3)
                   (d-sharp 4)
                   (e       5)
                   (f       6)
                   (f-sharp 7)
                   (g       8)
                   (g-sharp 9)
                   (a      10)
                   (a-sharp 11)
                   (b      12)))

(defun numbers (dave)
  (mapcar (lambda (note) (second (assoc note note-table))) dave))

(defun notes (dave)
  (reverse (numbers dave)))

(reverse (second note-table))

(setf number-table
  (mapcar #'reverse note-table))
; I need to make a function that creates a whole new list by
; swithicng around every entry in a table
; then call that function with the function that searches by number

 (defun notes (dave)
   (mapcar (lambda (number) (second (assoc number number-table))) dave))

(defun raise (number x)
  (mapcar (lambda (i) (+ number i))x))
; the letter i is an element in the list

; something strange with this.
(defun normalize (x)
  (mapcar (lambda (number) (cond ((> number 12) (- number 12))
                                 ((< number 1 ) (+ number 12))
                                 (t number)))x))

(defun transpose (n song)
  (normalize (raise n (numbers song))))

(defun transpose (n song)
  (notes (normalize (raise n (numbers song)))))

;remove-if is an applicative operator


;remove-if-not is used more frequently than remove-if


(defun great-one (x)
  (remove-if-not #'(lambda (number) (cond ((> number 1))
                                          ((< number 5))))x))







