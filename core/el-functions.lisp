;; August 8/19 
;; ================================================
;;
;; Definitions for any ELF functions used in schema formulas.
;;

(defun ulf-of.f (x)
; ````````````````````
; Retrieves ulf attached to action proposition name.
; TODO: Currently this just returns the first ulf if there
; are multiple attached to an action name. This doesn't make
; much sense, and should be changed in the future. This also
; ties into the issue of a user say-to.v act having a potentially
; indefinite amount of gist clauses attached... might it make sense
; to use iteration in interpreting the user's response until, say,
; an end of turn is recorded in *context*?
;
  (if (and (symbolp x) (get x 'ulf)) (car (get x 'ulf)) nil)
) ; END ulf-of.f



(defun gist-of.f (x)
; `````````````````````
; Retrives gist clauses attached to action proposition name.
; TODO: See issue with ulf-of.f
;
  (if (and (symbolp x) (get x 'gist-clauses)) (car (get x 'gist-clauses)) nil)
) ; END gist-of.f