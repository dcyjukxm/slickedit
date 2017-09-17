=surround_with_try...catch try {
                           %\m sur_text -indent%
                           } catch (%\c) {
                           }
=surround_with_try...catch...finally try {
                                     %\m sur_text -indent%
                                     } catch (%\c) {
                                     } finally {
                                     }
=surround_with_try...finally try {
                             %\m sur_text -indent%
                             } finally {
                             %\i%\c
                             }
=surround_with_for for (%\c) {
                   %\m sur_text -indent%
                   }
