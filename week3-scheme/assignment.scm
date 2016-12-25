;; Scheme assignment
;; Amanpreet Singh
;; as10656

;; Problem 1

;; Base Case: L is empty, return 0
;; Assumption: (count-numbers M) returns count of numbers in M, for any list smaller
;; than L (including car L and cdr L)
;; Step: If (car L) is a list then return the sum of number count in (car L)
;; and number count in (cdr L), else if (car L) is a number return 1 + number count of (cdr L)
;; Otherwise, return number count of (cdr L)

(define (count-numbers L)
  (cond ((null? L) 0)
        ((list? (car L)) (+ (count-numbers (car L)) (count-numbers (cdr L))))
        ((number? (car L)) (+ 1 (count-numbers (cdr L))))
        (else (count-numbers (cdr L)))))

;; Problem 2

;; Base Case: L is empty, return a list containing only number x
;; Assumption: (insert x M) returns a sorted list with x in its right place for any list M,
;; smaller than L (including (cdr L))
;; Step: If (car L) is greater than x return (cons x L) otherwise return (cons (car L) (insert x (cdr L)))

(define (insert x L)
  (cond ((null? L) (list x))
        ((> (car L) x) (cons x L))
        (else (cons (car L) (insert x (cdr L))))))


;; Problem 3

;; Base Case: L is empty, return M
;; Assumption: (insert N M) returns a sorted list containing all the elements of N and sorted list M,
;; for all lists N smaller than L (including (cdr L))
;; Step: Call insert-all on (cdr L) and the list returned by (insert (car L) M)

(define (insert-all L M)
  (cond ((null? L) M)
        (else (insert-all (cdr L) (insert (car L) M)))))


;; Problem 4

;; (insert x L)

;; Base Case: L is empty, return a list containing only number x
;; Assumption: (insert x M) returns a sorted list with x in its right place for any list M,
;; smaller than L (including (cdr L))
;; Step: If (car L) is greater than x return (cons x L) otherwise return (cons (car L) (insert x (cdr L)))

;; (insert-all L M)

;; Base Case: L is empty, return M
;; Assumption: (insert N M) returns a sorted list containing all the elements of N and sorted list M,
;; for all lists N smaller than L (including (cdr L))
;; Step: Call insert-all on (cdr L) and the list returned by (insert (car L) M)

(define (sort L)
  (letrec ((insert (lambda (x L)
                      (cond ((null? L) (list x))
                            ((> (car L) x) (cons x L))
                            (else (cons (car L) (insert x (cdr L)))))))
           (insert-all (lambda (L M)
                          (cond ((null? L) M)
                                (else (insert-all (cdr L) (insert (car L) M)))))))
         (insert-all L '())))


;; Problem 5

(define (translate op)
  (cond ((eq? op '*) *)
        ((eq? op '/) /)
        ((eq? op '+) +)
        (else -)))

;; Problem 6

;; (postfix-eval exp)
;; Base Case: if exp is a number return exp. For sake of completeness if exp is empty return 0
;; Assumption: (postfix-eval N) works on list smaller than exp or nested in exp
;; and returns the postfix evaluated value
;; Step: If exp's first element is a list evaluate first element and return cons of evaluated first element and (cdr exp),
;; else if exp's first element is number return evaluation of expression (third-element first-element (postifx-eval 2nd-element))
;; So
;; If list return (postfix-eval (cons (postfix-eval (car exp) cdr exp)))
;; If number return (translate of (caddr exp) (car exp) (postfix-eval (cadr exp)))

(define (postfix-eval exp)
  (cond ((null? exp) 0)
        ((number? exp) exp)
        ((list? (car exp)) (postfix-eval (cons (postfix-eval (car exp)) (cdr exp))))
        ((number? (car exp)) ((translate (caddr exp)) (car exp) (postfix-eval (cadr exp))))))

;; Problem 7

;; (powerset L)
;; Base Case: if list is empty return list with empty list i.e. '(())
;; Assumption: powerset works on lists smaller than L including (cdr L)
;; Step: get a new list by doing cons of (car L) with each element powerset of cdr L
;; and append it with powerset of cdr L
(define (powerset L)
  (cond ((null? L) '(()))
        (else (let ((cdr-power-set (powerset (cdr L))))
                   (append (map (lambda (x) (cons (car L) x)) cdr-power-set) cdr-power-set)))))
