; SYNOPSIS:
; # clisp gcd.lisp 11 22 33 121
; # ecl --shell gcd.lisp  121 22 33
; # gcl -f gcd.lisp 121 22 33
; # sbcl --script gcd.lisp 121 22 33

(defun gcd2 (a b)
  (if (= b 0)
    a 
    (gcd2 b (mod a b))))

(defun gcdn (n &rest ns)
  (reduce #'gcd2 ns :initial-value n))

(defun program-args ()
  (or
   #+CLISP *args*
   #+ECL (ext:command-args)
   #+GCL si::*command-args*
   #+SBCL *posix-argv*
   nil))

(defun numbers ()
  (remove nil
          (map 'list (lambda (x) (parse-integer x :junk-allowed t))
               (program-args))))

(let ((ns (numbers)))
  (when ns
    (write (apply #'gcdn ns))
    (fresh-line)))

