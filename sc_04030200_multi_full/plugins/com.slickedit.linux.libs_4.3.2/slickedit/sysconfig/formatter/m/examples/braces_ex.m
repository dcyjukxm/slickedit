class Foo {
public:
    Foo();
};
enum FooState {
    ON, OFF
};
namespace Hr
{
    void statements(bool cond, int x)
    {
        if (cond) {
            bar();
        } else {
            bar();
        }
        for (int i = 0; i < 10; i++) {
            bar();
        }
        while (cond) {
            bar();
        }
        do {
            bar();
        } while (cond);

        switch (x) {
        case 0:
            break;
        }
        try {
            bar();
        } catch (excn& e) {
            bar();
        }
    }
}
