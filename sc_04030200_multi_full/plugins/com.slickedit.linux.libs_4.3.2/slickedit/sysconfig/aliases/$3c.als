=surround_with_new_c_file #include <stdio.h>
                          %\S
                          int main (int argc, char *argv[])
                          {
                          %\m sur_text -indent%
                          %\ireturn(0);
                          }
=surround_with_new_cpp_file #include <stdio.h>
                          %\S
                          int main (int argc, char *argv[])
                          {
                          %\m sur_text -indent%
                          %\ireturn(0);
                          }

