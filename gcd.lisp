(defun gcd2 (a b)
  (if (= b 0)
    a 
    (gcd2 b (mod a b))))

(defun gcdn (&rest numbers)
  (reduce #'gcd2 (rest numbers)
          :initial-value (first numbers)))

; Command line access is different on different Lisps
(defun program-args ()
  (or
   #+SBCL (rest *posix-argv*)
   #+CLISP *args*
   ;#+ECL (ext:command-args)
   ;#+CMU extensions:*command-line-words*
   ;#+LISPWORKS system:*line-arguments-list*
   nil))

(write (apply #'gcdn 
              (map 'list #'parse-integer (program-args))
              ))
(fresh-line)

