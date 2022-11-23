(*

OCaml: http://ocaml.org/

Usage:

  $ ocamlopt gcd.ml -o gcd-ml
  $ ./gcd-ml 11 22 44 121
  11

or:

  $ ocaml gcd.ml 11 22 44 121
  11

*)


(* GCD of two numbers *)
let rec gcd a b =
  match b with
  | 0 -> a
  | b -> gcd b (a mod b)
;;

(* GCD of several numbers *)
let gcdn = List.fold_left gcd 0 ;;

let args = List.tl (Array.to_list Sys.argv) ;;

if args <> [] then begin
  let nums = List.map int_of_string args
  in Printf.printf "%d\n" (gcdn nums)
end ;;

