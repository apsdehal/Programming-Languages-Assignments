import java.util.*;
class C<T> extends ArrayList<T>{}

class A {}

class B extends A {
  public int x;
}

class Homework {
  // So if subtyping was to work C<B> should be C<A>
  public static void subtypeTester(C<? extends A> ca) {
    // So it was perfectly fine to do
    // because a C is an A
    ca.add(new A());

  }

  public static void main(String[] args) {
    C<B> cb = new C<B>();

    subtypeTester(cb);
    // Since list was originally B's so we should
    // get a B back
    B b = cb.get(0); // But actually returns a D

    System.out.println(b.x); // Oops, not found

    // Point is every list of B is list of A but every list of A
    // is not list of B
  }
}
