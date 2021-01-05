open Gpa

let scale_43 = [("A+", 4.3);("A", 4.0); ("A-", 3.7); ("B+", 3.3); ("B", 3.0);
                ("B-", 2.7); ("C+", 2.3); ("C", 2.0); ("C-", 1.7); ("D+", 1.3); ("D", 1.0);
                ("D-", 0.7); ("F", 0.0)]
let scale_40 = [("A+", 4.0);("A", 4.0); ("A-", 3.7); ("B+", 3.3); ("B", 3.0);
                ("B-", 2.7); ("C+", 2.3); ("C", 2.0); ("C-", 1.7); ("D+", 1.3); ("D", 1.0);
                ("D-", 0.7); ("F", 0.0)]

type args = {file : string; scale : (string * float) list}

let args (pargs : string list) = 
  match pargs with
  | _::f::("4")::[] -> {file = f; scale = scale_40}
  | _::f::("4.3")::[] -> {file = f; scale = scale_43}
  | _::f::[] -> {file = f; scale = scale_43}
  | _ -> print_endline "no arguments, using defaults"; {file = "grades.txt"; scale = scale_43}

let _ = 
  print_string "GPA: ";
  let config = args (Array.to_list Sys.argv) in 
  Gpa.from_file config.file config.scale |> Gpa.average |> print_float;
  print_newline ()
