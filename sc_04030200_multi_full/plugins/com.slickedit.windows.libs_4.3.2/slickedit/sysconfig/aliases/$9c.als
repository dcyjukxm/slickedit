=surround_with_try...catch try {
                           %\m sur_text -indent%
                           } catch (%\c) { %\S
                           }
=surround_with_try...catch...finally try {
                                     %\m sur_text -indent%
                                     } catch (%\c) { %\S
                                     } finally {
                                     }
=surround_with_#if...else %\m begin_line%#if %\c
                          %\m sur_text%
                          %\m begin_line%#else
                          %\m sur_text%
                          %\m begin_line%#endif
=surround_with_static_cast static_cast<%\c>(%\m sur_text%)
=surround_with_#ifdef %\m begin_line%#ifdef %\c
                      %\m sur_text%
                      %\m begin_line%#endif
=surround_with_#ifndef %\m begin_line%#ifndef %\c
                       %\m sur_text%
                       %\m begin_line%#endif
=surround_with_const_cast const_cast<%\c>(%\m sur_text%)
=surround_with_try...finally try {
                             %\m sur_text -indent%
                             } finally {
                             %\i%\c
                             }
=surround_with_#if %\m begin_line%#if %\c
                   %\m sur_text%
                   %\m begin_line%#endif
=surround_with_dynamic_cast dynamic_cast<%\c>(%\m sur_text%)
=surround_with_for for (%\c) {
                   %\m sur_text -indent%
                   }
=surround_with_reinterpret_cast reinterpret_cast<%\c>(%\m sur_text%)
