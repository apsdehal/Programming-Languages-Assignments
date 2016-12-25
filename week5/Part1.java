import java.util.*;

class ComparableList<T extends Comparable<T> >
extends ArrayList<T>
implements Comparable<ComparableList<T>> {
  @Override
  public int compareTo(ComparableList<T> L2) {
    Iterator<T> itOne = iterator();
    Iterator<T> itTwo = L2.iterator();

    while(itOne.hasNext() || itTwo.hasNext()) {
      if (!itOne.hasNext()) {
        return -1;
      } else if (!itTwo.hasNext()) {
        return 1;
      } else {
        T first = itOne.next();
        T second = itTwo.next();

        int comp = first.compareTo(second);

        if (comp != 0) {
          return comp;
        }
      }
    }

    return 0;
  }

}

class A implements Comparable<A> {
  public int x;
  public A(int y) {
    x = y;
  }

  public int compareTo(A b) {
    if (x < b.x) {
      return -1;
    } else if (x > b.x) {
      return 1;
    } else {
      return 0;
    }
  }

  public String toString() {
    return "A <" + Integer.toString(x) + ">";
  }
}

class B extends A {
  private int first, second;
  public B(int x, int y) {
    super(x + y);
    first = x;
    second = y;
  }

  @Override
  public int compareTo(A b) {
    if (x < b.x) {
      return -1;
    } else if (x > b.x) {
      return 1;
    } else {
      return 0;
    }
  }

  public String toString() {
    return "B <" + Integer.toString(first) + "," + Integer.toString(second) + ">";
  }
}


public class Part1 {
  public static <T extends Comparable<T>> void addToCList(T z, ComparableList<T> L) {
    L.add(z);
  }

  public static void main(String[] args) {
    ComparableList<Integer> L1 = new ComparableList<Integer>();
    ComparableList<Integer> L2 = new ComparableList<Integer>();
    L1.add(1);
    L2.add(2);

    System.out.println(L1.compareTo(L2));

    L1.clear();
    L1.add(3);
    System.out.println(L1.compareTo(L2));
    System.out.println(L1);

    L1.clear();
    L1.add(2);
    System.out.println(L1.compareTo(L2));

    A a1 = new A(6);
    A a2 = new A(7);
    System.out.println(a1);

    System.out.println(a1.compareTo(a2));

    B b1 = new B(2,4);
    B b2 = new B(3,5);
    System.out.println(b1);
    System.out.println(a1.compareTo(b1));  //returns 0, since 6 = (2+4)
    System.out.println(a1.compareTo(b2));  //returns -1, since 6 < (3+5)
    System.out.println(b1.compareTo(a1));  //returns 0, since (2+4) = 6
    System.out.println(b2.compareTo(a1));  //returns 1, since (3+5) > 6
    System.out.println(b1.compareTo(b2));  //returns -1, since (2+4) < (3+5)

    System.out.println("Testing now:");
    test();
  }

  static void test() {
    ComparableList<A> c1 = new ComparableList<A>();
    ComparableList<A> c2 = new ComparableList<A>();
    for(int i = 0; i < 10; i++) {
      addToCList(new A(i), c1);
      addToCList(new A(i), c2);
    }

    addToCList(new A(12), c1);
    addToCList(new B(6,6), c2);

    addToCList(new B(7,11), c1);
    addToCList(new A(13), c2);

    System.out.print("c1: ");
    System.out.println(c1);

    System.out.print("c2: ");
    System.out.println(c2);

    switch (c1.compareTo(c2)) {
    case -1:
      System.out.println("c1 < c2");
      break;
    case 0:
      System.out.println("c1 = c2");
      break;
    case 1:
      System.out.println("c1 > c2");
      break;
    default:
      System.out.println("Uh Oh");
      break;
    }

  }
}
