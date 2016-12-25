class OInt(x: Int) extends Ordered[OInt] {
  val n = x
  def compare(that: OInt): Int = {
    if (this.n < that.n) {
      -1
    } else if (this.n == that.n) {
      0
    } else {
      1;
    }
  }

  override def toString(): String = "OInt(" + n + ")"
}

abstract class OTree[T <: Ordered[T]] extends Ordered[OTree[T]]

case class ONode[T <: Ordered[T]](x: List[OTree[T]]) extends OTree[T] {
  val n = x
  def compare(that: OTree[T]) = that match {
    case ONode(ox) => {
      def compareNodes(n: List[OTree[T]], ox: List[OTree[T]]): Int = {
        if (ox == Nil && n == Nil) {
          0
        } else if (ox == Nil && n != Nil) {
          1
        } else if (n == Nil && ox != Nil) {
          -1
        } else {
          val firstX::restN = n
          val firstOx::restOx = ox

          if (firstX < firstOx) {
            -1
          } else if (firstX > firstOx) {
            1
          } else {
            compareNodes(restN, restOx)
          }
        }
      }

      compareNodes(n, ox)
    }

    case OLeaf(ox) => {
      1
    }
  }

  override def toString(): String = "ONode(" + n + ")"
}

case class OLeaf[T <: Ordered[T]](x: T) extends OTree[T] {
  val n = x
  def compare(that: OTree[T]) = that match {
    case ONode(ox) => {
      -1
    }

    case OLeaf(ox) => {
      this.n.compare(ox)
    }
  }

  override def toString(): String = "Oleaf(" + n + ")"
}

object Part2 {
  def compareTrees[T <: Ordered[T]](first: OTree[T], second: OTree[T]): Unit = {
    val eq = first.compare(second)

    if (eq == -1)
      println("Less")
    else if (eq == 1)
      println("Greater")
    else
      println("Equal")
  }

  def main(args: Array[String]): Unit = {
    println((new OInt(6)).compare(new OInt(6)))
    test()
  }

  def test() = {

    val tree1 = ONode(List(OLeaf(new OInt(6))))

    val tree2 = ONode(List(OLeaf(new OInt(3)),
         OLeaf(new OInt(4)),
         ONode(List(OLeaf(new OInt(5)))),
         ONode(List(OLeaf(new OInt(6)),
              OLeaf(new OInt(7))))));

    val treeTree1: OTree[OTree[OInt]] =
      ONode(List(OLeaf(OLeaf(new OInt(1)))))

    val treeTree2: OTree[OTree[OInt]] =
      ONode(List(OLeaf(OLeaf(new OInt(1))),
     OLeaf(ONode(List(OLeaf(new OInt(2)),
          OLeaf(new OInt(2)))))))


    print("tree1: ")
    println(tree1)
    print("tree2: ")
    println(tree2)
    print("treeTree1: ")
    println(treeTree1)
    print("treeTree2: ")
    println(treeTree2)
    print("Comparing tree1 and tree2: ")
    compareTrees(tree1, tree2)
    print("Comparing tree2 and tree2: ")
    compareTrees(tree2, tree2)
    print("Comparing tree2 and tree1: ")
    compareTrees(tree2, tree1)
    print("Comparing treeTree1 and treeTree2: ")
    compareTrees(treeTree1, treeTree2)
    print("Comparing treeTree2 and treeTree2: ")
    compareTrees(treeTree2, treeTree2)
    print("Comparing treeTree2 and treeTree1: ")
    compareTrees(treeTree2, treeTree1)

  }
}
