      *=========================== BITWISE ============================*
      * Authors: Brian D Pead
      *
      * Description: Subroutine to do bitwise operations on the  
      *              specified fields.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.                 BITWISE.

       ENVIRONMENT DIVISION.
      *=====================

       CONFIGURATION SECTION.
      *----------------------

       SOURCE-COMPUTER.
           IBM-Z15.
      *    IBM-Z15 DEBUGGING MODE.

       INPUT-OUTPUT SECTION.
      *---------------------

       FILE-CONTROL.
      /
       DATA DIVISION.
      *==============

       FILE SECTION.
      *-------------

       WORKING-STORAGE SECTION.
      *------------------------

       01  W-SUB                   PIC S9(04) COMP.

       01  FILLER                  PIC X(01)       VALUE 'Y'.
           88  W-FIRST-CALL                        VALUE 'Y'.
           88  W-NOT-FIRST-CALL                    VALUE 'N'.

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-SUB-1                 PIC S9(04) COMP.
       01  FILLER REDEFINES W-SUB-1.
           05  FILLER              PIC X(01)       VALUE X'00'.
           05  W-SUB-1-2           PIC X(01).

       01  W-SUB-2                 PIC S9(04) COMP.
       01  FILLER REDEFINES W-SUB-2.
           05  FILLER              PIC X(01)       VALUE X'00'.
           05  W-SUB-2-2           PIC X(01).

       COPY BITWISEW.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY BITWISEL.

       01  L-INPUT-1               PIC 9(09)  COMP.
       01  FILLER REDEFINES L-INPUT-1.
           05  L-IN1-BYTE          PIC X(01)       OCCURS 4.

       01  L-INPUT-2               PIC 9(09)  COMP.
       01  FILLER REDEFINES L-INPUT-2.
           05  L-IN2-BYTE          PIC X(01)       OCCURS 4.

       01  L-OUTPUT                PIC 9(09)  COMP.
       01  FILLER REDEFINES L-OUTPUT.
           05  L-OUTPUT-BYTE       PIC X(01)       OCCURS 4.
      /
       PROCEDURE DIVISION USING L-PARAMETER.
      *==================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT
               VARYING W-SUB FROM 1 BY 1
                 UNTIL W-SUB > BW-INPUT-LEN
           .
       MAIN-EXIT.
           GOBACK.
      /
       SUB-1000-START-UP.
      *------------------

           SET  ADDRESS OF L-INPUT-1
                                   TO BW-INPUT-1-PTR
           SET  ADDRESS OF L-INPUT-2
                                   TO BW-INPUT-2-PTR
           SET  ADDRESS OF L-OUTPUT
                                   TO BW-OUTPUT-PTR

           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET W-NOT-FIRST-CALL    TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'BITWISE  compiled on '
               W-COMPILED-DATE-YYYY '/'
               W-COMPILED-DATE-MM   '/'
               W-COMPILED-DATE-DD   ' at '
               W-COMPILED-TIME-HH   ':'
               W-COMPILED-TIME-MM   ':'
               W-COMPILED-TIME-SS
           .
       SUB-1000-EXIT.
           EXIT.
      /
       SUB-2000-PROCESS.
      *-----------------

           MOVE L-IN1-BYTE(W-SUB)  TO W-SUB-1-2

           MOVE L-IN2-BYTE(W-SUB)  TO W-SUB-2-2
           MOVE W-BW-OP-VALUE(W-SUB-1 + 1, W-SUB-2 + 1)
                             (BW-OPERATION : 1)
                                   TO L-OUTPUT-BYTE(W-SUB)
           .
       SUB-2000-EXIT.
           EXIT.
