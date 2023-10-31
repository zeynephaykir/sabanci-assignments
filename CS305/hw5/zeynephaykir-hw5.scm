; define error handler
(define (error-handler . args) "ERROR")

;define function to get operators
(define get-operator (lambda (op-symbol)
  (cond
    ((eq? op-symbol '+) +)
    ((eq? op-symbol '*) *)
    ((eq? op-symbol '-) -)
    ((eq? op-symbol '/) /)
    (else (error-handler)))))

; define function to get values
(define get-value (lambda (var env)
    (cond 
       ( (null? env) (error-handler))
       ( (eq? var (caar env)) (cdar env))
       ( else (get-value var (cdr env))))))

(define s7-let (lambda (e env)
  (let* (
         (bindings (cadr e))
         (expr (caddr e))
         (new-env (extend-env-with-bindings bindings env))
        )
    (s7 expr new-env))))

(define s7-let* (lambda (e env)
  (let* (
         (bindings (cadr e))
         (expr (caddr e))
         (new-env (extend-env-with-bindings* bindings env))
        )
    (s7 expr new-env))))

(define extend-env (lambda (var val old-env)
        (cons (cons var val) old-env)))

(define define-expr? (lambda (e)
         (and (list? e) (= (length e) 3) (eq? (car e) 'define) (symbol?(cadr e)))))

(define let-expr? (lambda (e)
  (and (list? e) (> (length e) 2) (eq? (car e) 'let))))

(define let*-expr? (lambda (e)
  (and (list? e) (> (length e) 2) (eq? (car e) 'let*))))


; def s7 func.
(define s7 (lambda (e env)
   (cond
      ( (number? e) e)
      ( (symbol? e) (get-value e env))
      ( (not (list? e)) (error-handler))
      ( (not (> (length e) 1)) (error-handler))
      ( (eq? (car e) 'if) (if (not (= (length e) 4))
                               (error-handler)
                               (if (not (eq? (s7 (cadr e) env) 0))
                                   (s7 (caddr e) env)
                                   (s7 (cadddr e) env))))
      ( (eq? (car e) 'cond) (s7-cond (cdr e) env))
      ( (let-expr? e) (s7-let e env))
      ( (let*-expr? e) (s7-let* e env))
      ( else 
         (let (
                (operator (get-operator (car e)))
                (operands (map s7 (cdr e) (make-list (length (cdr e) ) env )))
              )
              (if (eq? operator (error-handler))
                  (error-handler)
                  (apply operator operands)))))))

; check if every element? satisfies a cond or not
(define (every? pred lst)
  (if (null? lst)
      #t
      (if (pred (car lst))
          (every? pred (cdr lst))
          #f)))

(define extend-env-with-bindings (lambda (bindings env)
  (if (null? bindings)
      env
      (extend-env-with-bindings (cdr bindings) (extend-env (caar bindings) (s7 (cadar bindings) env) env)))))

(define extend-env-with-bindings* (lambda (bindings env)
  (if (null? bindings)
      env
      (extend-env-with-bindings* (cdr bindings) (extend-env (caar bindings) (s7 (cadar bindings) env) env)))))


; def s7-cond func. 
(define s7-cond (lambda (clauses env)
  (let ((else-count (count-else clauses)))
    (cond
      ((null? clauses) (error-handler))
      ((> else-count 1) (error-handler))
      ((not (every? list? clauses)) (error-handler)) 
      ((eq? (caar clauses) 'else) (s7 (cadar clauses) env))
      ((not (eq? (s7 (caar clauses) env) 0)) (s7 (cadar clauses) env))
      (else (if (null? (cdr clauses))
                (if (= else-count 0) (error-handler))
                (s7-cond (cdr clauses) env)))))))

; count else clauses func. 
(define (count-else clauses)
  (define (count-else-helper clauses count)
    (if (null? clauses)
        count
        (count-else-helper (cdr clauses) (if (eq? (caar clauses) 'else) (+ count 1) count))))
  (count-else-helper clauses 0))

; define REPL func. 
(define repl (lambda (env)
   (let* (
           (dummy1 (display "cs305> "))
           (expr (read))
           (new-env (if (define-expr? expr) 
                        (extend-env (cadr expr) (s7 (caddr expr) env) env)
                        env
                    ))
           (val (if (define-expr? expr)
                    (cadr expr)
                    (s7 expr env)
                ))
           (dummy2 (display "cs305: "))
           (dummy3 (display val))
           (dummy5 (newline))
          )
          (repl new-env))))

; define CS305 func. 
(define (cs305)
    (repl '()))