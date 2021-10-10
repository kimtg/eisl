(import "test")

(defun disp (x)
	(mapcar #'get-method-body (get-method x)))

(defglobal *call-tree* nil)

(defun add-call-tree (x)
   (setq *call-tree* (cons x *call-tree*)))
;;
($eval (defclass c1 () ()))
($eval (defclass c2 (c1) ()))
($eval (defclass c3 (c2) ()))
($eval (defclass c4 () ()))
($eval (defglobal c1 (create (class c1))))
($eval (defglobal c2 (create (class c2))))
($eval (defglobal c3 (create (class c3))))
($eval (defglobal c4 (create (class c4))))
($eval 
 (defgeneric foo-g-30 (x y)
   (:method (x y)
	    '(<object> <object>))
   (:method (x (y c1))
	    '(<object> c1))
   (:method (x (y c2))
	    '(<object> c2))
   (:method (x (y c3))
	    '(<object> c3))
   (:method ((x c1) y)
	    '(c1 <object>))
   (:method ((x c1) (y c1))
	    '(c1 c1))
   (:method ((x c1) (y c2))
	    '(c1 c2))
   (:method ((x c1) (y c3))
	    '(c1 c3))
   (:method ((x c2) y)
	    '(c2 <object>))
   (:method ((x c2) (y c1))
	    '(c2 c1))
   (:method ((x c2) (y c2))
	    '(c2 c2))
   (:method ((x c2) (y c3))
	    '(c2 c3))
   (:method ((x c3) y)
	    '(c3 <object>))
   (:method ((x c3) (y c1))
	    '(c3 c1))
   (:method ((x c3) (y c2))
	    '(c3 c2))
   (:method ((x c3) (y c3))
	    '(c3 c3))
   ))


(test (foo-g-30 1 c1) (<object> c1) equal)

