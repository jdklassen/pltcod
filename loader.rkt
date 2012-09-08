#lang racket

(require ffi/unsafe)
(provide libtcod deftcod)

(define libtcod
  (ffi-lib (case (system-type 'os)
             ['windows "libtcod-mingw"]
             [else "libtcod"])))

(define-syntax deftcod
  (syntax-rules (:)
    [(_ name : type ...)
     (define name (get-ffi-obj
                   (string-append "TCOD_"
                                  (regexp-replaces (symbol->string 'name) 
                                                   '((#rx"-" "_")
                                                     (#rx"[+*?!]" ""))))
                   libtcod (_fun type ...)))]))

