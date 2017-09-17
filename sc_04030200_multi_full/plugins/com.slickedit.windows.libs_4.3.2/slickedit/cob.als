functioncomment(fname "Enter procedure name:"
                )
 %\x7*
 %\x7*PROCEDURE NAME: %(fname)
 %\x7*
 %\x7*PARAMETERS: %\c
 %\x7*
 %\x7*DESCRIPTION:
 %\x7*
 %\x7*RETURNS:
 %\x7*
 %\x7*
l01(fname "Enter GROUP LEVEL 01 Name" FILLER
    pic "and PIC value" X(16)
    val "and VALUE (without quotes)" BEGIN
    )
 %\x8,01  %(fname) %\x40PIC %(pic)
 %\x16VALUE '%(val)'.
 %\S
para(paraname "Enter Paragraph Name"
     )
 %\x12.
 %\x8%(paraname).
 %\X12MOVE '%(PARANAME)' TO WS-DEBUG-FIELD.
 %\c
inline(cond "Enter inline PERFORM UNTIL condition"
       )
 PERFORM UNTIL %(cond)
 %\i%\c
 END-PERFORM
dummysubrtn(pgm "Enter Subroutine Name"
            CPYMBR "Enter common area copybook name"
            p1 "Enter first data element to be passed"
            p2 "Enter second data element to be passed"
            p3 "Enter third data element to be passed"
            p4 "Enter fourth data element to be passed"
            )
 %\X7*
 %\x8IDENTIFICATION DIVISION.
 %\x8PROGRAM-ID. %(pgm).
 %\x7* This is a dummy subroutine designed to provide
 %\X7*a module to be used to build a subroutine tag file
 %\X7*for Visual SlickEdit.  This module should not be %\S
 %\X7*compiled.  Include the COBOL copybook that is the %\S
 %\X7*common area between the calling program and this %\S
 %\X7*subroutine.  On the PROCEDURE DIVISION include the %\S
 %\X7*field names that should be used on the %\S
 %\X7*CALL ... USING %\S
 %\x7*
 %\X8DATA DIVISION.
 %\x8WORKING-STORAGE SECTION.
 %\X8,01  COMMON-AREA.
 %\X12COPY %(cpymbr).
 %\X8PROCEDURE DIVISION USING %(P1) %(P2) %(P3) %(P4).
 %\X8,0100-MAINLINE.
 %\X8GOBACK
L88(condname "Enter Condition Name"
    value "and Condition Value (excluding quotes)" YES
    )
 %\i88  %(condname)%\x40VALUE '%(value)'.
 %\S
per(Target "Enter Paragraph to PERFORM THRU"
    )
 PERFORM %(target) THRU %(target)-EXIT
filecomment %\x7*****************************************************
            %\x7*
            %\x7*    DESCRIPTION: %\c
            %\x7*
            %\x7*    AUTHOR:
            %\x7*
            %\x7*    HISTORY:
            %\x7*
            %\x7*    DATE: %\d
            %\x7*
            %\x7*****************************************************
l05(fname "Enter Level 05 Field Name" FILLER
    pic "and PIC value"
    val "and VALUE (with quotes)"
    )
 %\x12,05  %(fname)  PIC %(pic)
 %\x16VALUE %(val).
 %\S
 %\S
sel(fname "Enter file-name"
    assgn "and DDNAME"
    fs "and File Status field name."
    )
 %\x12SELECT %(fname) %\S
 %\x16ASSIGN TO %(assgn) %\S
 %\x16FILE STATUS IS %(fs)
 %\S
id(PGM "Enter Program Name"
   )
 %\x8IDENTIFICATION DIVISION.
 %\x8PROGRAM-ID. %(pgm).
 %\x7*AUTHOR.
 %\X7*INSTALLATION.
 %\X7*DATE-WRITTEN.
 %\X7*DATE-COMPILED.
 %\x7*
 %\x8ENVIRONMENT DIVISION.
 %\x8INPUT-OUTPUT SECTION.
 %\x8FILE-CONTROL.
 %\S
call CALL %\c USING %\S
