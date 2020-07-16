type t = (int * float) list


let from_file (path : string) (assoc : (string * float) list) = 
  let get_line file = try Some (input_line file) with End_of_file -> None in
  let file = open_in path in
  let rec loop acc =
    match get_line file with
    | Some line when not (0 = String.length line) -> 
      let linelist = String.split_on_char ' ' line in 
      loop (((List.nth linelist 1), (List.nth linelist 2))::acc)
    | _ -> acc
  in
  let grades = loop [] in
  close_in file;
  List.map (fun (cr, l) -> ((int_of_string cr), (List.assoc l assoc))) grades

let average gpa = (List.fold_left 
                     (fun cur (cr, g) -> cur +. (cr |> float_of_int) *. g)
                     0.0 gpa)
                  /. 
                  (List.fold_left 
                     (fun cur (cr, _) -> (cr |> float_of_int) +. cur)
                     0.0 gpa)
