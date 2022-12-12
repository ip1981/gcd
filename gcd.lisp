; SYNOPSIS:
; # clisp gcd.lisp 11 22 33 121
; # ecl --shell gcd.lisp  121 22 33
; # gcl -f gcd.lisp 121 22 33
; # sbcl --script gcd.lisp 121 22 33

(defun gcd2 (a b)
  (loop while (/= b 0) do
    (psetq a b b (mod a b))
    finally (return a)))

(defun gcdn (n &rest ns)
  (reduce #'gcd2 ns :initial-value n))

(defun program-args ()
  (or
   #+CLISP *args*
   #+ECL   (cdr ext:*unprocessed-ecl-command-args*)
   #+GCL   (cdr si::*command-args*)
   #+SBCL  (cdr *posix-argv*)
   nil))

(defun numbers ()
  (mapcar #'parse-integer (program-args)))

(let ((ns (numbers)))
  (when ns
    (write (apply #'gcdn ns))
    (fresh-line)))

