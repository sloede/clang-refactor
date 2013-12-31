/*namespace ns {
  struct Test {
    int foo() {
      int i = 0;
      return i;
    }
  };
}*/

class Test {
 public:
  int m_var;
  int var() {
    return m_var;
  }
};

int main(int, char**) {
  Test t;
  int i = t.var();
  int k = t.m_var;

  // Test* ptr = &t;
  // int j = ptr->var();
}
