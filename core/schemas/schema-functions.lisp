;; August 8/19 
;; ================================================
;;
;; Definitions for any ELF functions used in schema formulas.
;;

(defun ulf-of.f (x)
; ````````````````````
; Retrieves ulf attached to action proposition name.
;
  (if (and (symbolp x) (get x 'ulf)) (get x 'ulf) nil)
) ; END ulf-of.f



(defun gist-of.f (x)
; `````````````````````
; Retrives gist clauses attached to action proposition name.
;
  (if (and (symbolp x) (get x 'gist)) (get x 'gist-clauses) nil)
) ; END gist-of.f