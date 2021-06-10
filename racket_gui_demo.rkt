;#lang racket
;(require racket/gui/base)
;
;; Make a frame by instantiating the frame% class
;(define frame (new frame% [label "Example"]))
;
; Make a static text message in the frame
;(define msg (new message% [parent frame]
;                          [label "No events so far..."]))
; 
; Make a button in the frame
;(new button% [parent frame]
;             [label "Click Me"]
;             ; Callback procedure for a button click:
;             [callback (lambda (button event)
;                         (send msg set-label "Button click"))])
; 
; Show the frame by calling its show method
;(send frame show #t)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Derive a new canvas (a drawing window) class to handle events
;(define my-canvas%
;  (class canvas% ; The base class is canvas%
;    ; Define overriding method to handle mouse events
;    (define/override (on-event event)
;      (send msg set-label "Canvas mouse"))
;    ; Define overriding method to handle keyboard events
;    (define/override (on-char event)
;      (send msg set-label "Canvas keyboard"))
;    ; Call the superclass init, passing on all init args
;    (super-new)))
; 
; Make a canvas that handles events in the frame
;(new my-canvas% [parent frame])



;(define frame (new frame%
;                   [label "Example"]
;                   [width 300]
;                   [height 300]))
;(new canvas% [parent frame]
;             [paint-callback
;              (lambda (canvas dc)
;                (send dc set-scale 3 3)
;                (send dc set-text-foreground "blue")
;                (send dc draw-text "Don't Panic!" 0 0))])
;(send frame show #t)


; Create a dialog
;(define dialog (instantiate dialog% ("Example")))
; 
; Add a text field to the dialog
;(new text-field% [parent dialog] [label "Your name"])
; 
; Add a horizontal panel to the dialog, with centering for buttons
;(define panel (new horizontal-panel% [parent dialog]
;                                     [alignment '(center center)]))
; 
; Add Cancel and Ok buttons to the horizontal panel
;(new button% [parent panel] [label "Cancel"])
;(new button% [parent panel] [label "Ok"])
;(when (system-position-ok-before-cancel?)
;  (send panel change-children reverse))
; 
; Show the dialog
;(send dialog show #t)


; https://github.com/ZelphirKaltstahl/racket-gui-example/blob/master/tutorial.rkt
#lang racket/gui

(require racket/gui/base)

(define nil '())

(define application-frame
  (new frame%
    [label "Example"]
    [width 400]
    [height 300]))

(define menu-bar
  (new menu-bar%
    [parent application-frame]))

(define file-menu
  (new menu%
    [label "&File"]
    [parent menu-bar]))

(new menu%
  [label "&Edit"]
  [parent menu-bar])

(new menu%
  [label "&Help"]
  [parent menu-bar])

(new menu-item%
  [label "E&xit"]
  [parent file-menu]
  [callback
    (λ (m event)
      (exit nil))])

(define tab-panel
  (new tab-panel%
    [parent application-frame]
    [choices '("&Lookup" "&Training")]
    [callback
      (λ (tp event)
        (case (send tp get-item-label (send tp get-selection))
          [("&Lookup")
            (send tp change-children (get-lookup-panel5 tp))]
          [("&Training")
            (send tp change-children
              (λ (children)
                (list training-panel)))]))]))

(define (get-lookup-panel children)
  (lambda (children)
    (let
      [(lookup-panel (new panel% [parent tab-panel]))]
      [(new message%
        [parent lookup-panel]
        [label "The content of the lookup panel for the lookup tab."])
      (list lookup-panel)])))

(define get-lookup-panel2
  (lambda (children)
    (list (new panel% [parent tab-panel]))))

(define (get-lookup-panel3 children)
  (list (new panel% [parent tab-panel])))

(define (get-lookup-panel4 children)
  (define lookup-panel (new panel% [parent tab-panel]))
  (define lookup-panel-message (new message% [parent lookup-panel] [label "LOOKUP"]))
  (list lookup-panel))

(define (get-lookup-panel5 parent-elem)
  (define lookup-panel (new panel% [parent parent-elem]))
  (define lookup-panel-message (new message% [parent lookup-panel] [label "LOOKUP"]))
  (lambda (children)
    (list lookup-panel)))

(define lookup-panel (new panel% [parent tab-panel]))
(define lookup-panel-content
  (new message%
    [parent lookup-panel]
    [label "The content of the lookup panel for the lookup tab."]))

(define training-panel (new panel% [parent tab-panel]))
(define training-panel-content
  (new message%
    [parent training-panel]
    [label "The content of the training panel for the training tab."]))

(define status-message
  (new message%
    [parent application-frame]
    [label "No events so far..."]
   	[auto-resize #t]))

;; Derive a new canvas (a drawing window) class to handle events
;(define my-canvas%
;  (class canvas% ; The base class is canvas%
;    ; Define overriding method to handle mouse events
;    (define/override (on-event event)
;      (send msg set-label "Canvas mouse"))
;    ; Define overriding method to handle keyboard events
;    (define/override (on-char event)
;      (send msg set-label "Canvas keyboard"))
;    ; Call the superclass init, passing on all init args
;    (super-new)))

;(new my-canvas%
;  [parent frame])

;(define panel (new horizontal-panel% [parent frame]))
;(new button% [parent panel]
;             [label "Left"]
;             [callback (lambda (button event)
;                         (send msg set-label "Left click"))])
;(new button% [parent panel]
;             [label "Right"]
;             [callback (lambda (button event)
;                         (send msg set-label "Right click"))])


(send application-frame show #t)


;racket standard-module-name-resolver collection not found
;raco pkg install gui
;raco exe --gui racket_gui_demo.rkt
