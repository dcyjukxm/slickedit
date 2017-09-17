=surround_with_if_condition if (%\m sur_text -stripend ;%) {
                            %\i%\c
                            }
=surround_with_new_cpp_file #include <iostream>
                            %\l
                            using namespace std;
                            %\l
                            int main (int argc, char *argv[])
                            {
                            %\m sur_text -indent%
                            %\ireturn(0);
                            }

