#lang racket

(require ffi/unsafe)
(require racket/runtime-path)
(provide libtcod deftcod)

(define libtcod-so
  (case (system-type 'os)
    ['windows "libtcod-mingw"]
    [else "libtcod"]))

(define libtcod (ffi-lib libtcod-so))

(define-syntax deftcod
  (syntax-rules (:)
    [(_ name : type ...)
     (define name (get-ffi-obj
                   (string-append "TCOD_"
                                  (regexp-replaces (symbol->string 'name) 
                                                   '((#rx"-" "_")
                                                     (#rx"[+*?!]" ""))))
                   libtcod (_fun type ...)))]))

