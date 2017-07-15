; SYNOPSIS:
;
; $ clojure gcd.clj 11 22 33 121
; 11
;
; or:
;
; $ java -cp clojure-1.8.0.jar clojure.main gcd.clj 11 22 33 121
; 11
;

(defn gcd2 [a b]
  (if (zero? b)
    a
    (gcd2 b (mod a b))))

(defn gcdn [aa] (reduce gcd2 aa))

(println
  (gcdn
    (map #(Integer/parseInt %) *command-line-args*)))

