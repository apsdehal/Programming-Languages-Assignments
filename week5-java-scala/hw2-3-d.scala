class A {
  val x: Int = 1
  def getX: Int = x
}

class B extends A {
  val z: Int = 2
  def getZ: Int = z
}

object homework {

  def a2Int(g: A => Int) = {
    val a:A = new A
    g(a)
  }

  def b2Int(g: B => Int) = {
    val b:B = new B
    g(b)
  }

  def h(x: A) = x.getX


  def i(b: B) = b.getZ


  def main(args: Array[String]) = {
    println(a2Int(h)) // Works fine
    // println(a2Int(i))
    // This will throw error as in i the object a
    // that is passed will try to access getZ
    // which is not defined for A but is for B
    println(b2Int(i)) // Works fine
    println(b2Int(h)) // Work fine
  }
}
