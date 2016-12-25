abstract class myList[+T]

case object nil extends myList[Nothing]

case class cons[T](a: T, l: myList[T]) extends myList[T]

object Homework {
  def map[T](f: T => T, l: myList[T]): myList[T] = {

    l match {
      case cons(value, valueList) => {
        cons(f(value), map(f, valueList))
      }

      case nil => {
        nil
      }
    }
  }

  def main(args: Array[String]) = {
    val l = cons(1, cons(2, cons(4, nil)))
    println(l)
    // outputs: cons(1,cons(2,cons(4,nil)))

    def myF[T] = (x: T) => x.toString() + "-modified"
    val c = map(myF, l)
    println(c)
    // outpus: cons(1-modified,cons(2-modified,cons(4-modified,nil)))

    val d = map((x: Int) => x + 1, l)
    println(d)
    // outpus: cons(2,cons(3,cons(5,nil)))
  }
}
