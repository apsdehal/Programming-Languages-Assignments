(* Amanpreet Singh *)
(* as10656 *)

Control.Print.printDepth := 100;
Control.Print.printLength := 100;

(* Problem 1 *)

fun merge L1 nil = L1
| merge nil L2 = L2
| merge (x :: xs) (y :: ys) =
if x < y then x :: (merge xs (y :: ys)) else y :: (merge (x :: xs) ys)


(* Problem 2 *)

fun split [] = ([], [])
| split [x] = ([x], [])
| split (x1::x2::xs) =
  let val (L1, L2) = split xs
  in (x1::L1, x2::L2)
  end

(* Problem 3 *)

fun mergeSort [] = []
| mergeSort [x] = [x]
| mergeSort L =
  let val (L1, L2) = split L
      val L1 = mergeSort L1
      val L2 = mergeSort L2
      in merge L1 L2
  end

(* Problem 4 *)

fun sort (op <) [] = []
| sort (op <) [x] = [x]
| sort (op <) L =
  let fun split [] = ([], [])
        | split [x] = ([x], [])
        | split (x1::x2::xs) =
          let val (L1, L2) = split xs
          in (x1::L1, x2::L2)
          end
      fun merge L1 nil = L1
        | merge nil L2 = L2
        | merge (x :: xs) (y :: ys) =
        if x < y
          then x :: (merge xs (y :: ys))
          else y :: (merge (x :: xs) ys)
      val (L1, L2) = split L
      val L1 = sort (op <) L1
      val L2 = sort (op <) L2
    in merge L1 L2
    end;

(* Problem 5 *)

datatype 'a tree = empty | leaf of 'a | node of 'a * 'a tree * 'a tree;

(* Problem 6 *)

fun labels empty = []
| labels (leaf x) = [x]
| labels (node (n, left, right)) =
(labels left) @ [n] @ (labels right)

(* Problem 7 *)
infix ==

fun replace (op ==) x y empty = empty
| replace (op ==) x y (leaf l) = if l == x then leaf y else leaf l
| replace (op ==) x y (node (n, left, right)) =
  let val n = if x == n then y else n
  val left = replace (op ==) x y left
  val right = replace (op ==) x y right
  in
    node (n, left, right)
  end

(* Problem 8 *)

fun replaceEmpty y empty = y
| replaceEmpty y (leaf l) = leaf l
| replaceEmpty y (node (n, left, right)) =
node (n, (replaceEmpty y left), (replaceEmpty y right))

(* Problem 9 *)

fun mapTree f empty = f empty
| mapTree f (leaf l) = f (leaf l)
| mapTree f (node (n, left, right)) =
f (node (n, (mapTree f left), (mapTree f right)))

(* Problem 10 *)
fun sortTree (op <) T =
mapTree
  (fn empty => empty
   | (leaf l) => leaf (sort (op <) l)
   | (node (n, left, right)) => node (sort (op <) n, left, right)) T;
