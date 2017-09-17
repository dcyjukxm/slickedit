=surround_with_try...catch try {
                           %\m sur_text -indent%
                           } catch (%\c) { %\S
                           }
=surround_with_try...catch...finally try {
                                     %\m sur_text -indent%
                                     } catch (%\c) { %\S
                                     } finally {
                                     }
=surround_with_try...finally try {
                             %\m sur_text -indent%
                             } finally {
                             %\i%\c
                             }
=surround_with_switch switch (%\c) {
                      %\m sur_text%
                      }
