=surround_with_try...catch try {
                           %\m sur_text -indent%
                           } catch () {
                           }
=surround_with_try...catch...finally try {
                                     %\m sur_text -indent%
                                     } catch () {
                                     } finally {
                                     }
=surround_with_#if %\m begin_line%#if %\c
                   %\m sur_text%
                   %\m begin_line%#endif
=surround_with_#if...else %\m begin_line%#if %\c
                          %\m sur_text%
                          %\m begin_line%#else
                          %\m sur_text%
                          %\m begin_line%#endif
=surround_with_try...finally try {
                             %\m sur_text -indent%
                             } finally {
                             }
