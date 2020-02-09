      *=========================== HEXDUMP ============================*
      * Authors: Brian D Pead
      *
      * Description: Subroutine to convert characters to hex.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  0.1      First release
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.                 HEXDUMP.

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

       01  W-SUB                   PIC S9(04)      COMP.
       01  FILLER REDEFINES W-SUB.
           05  FILLER              PIC X(01)       VALUE X'00'.
           05  W-SUB-2             PIC X(01).

       COPY HEXDUMPW.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY HEXDUMPL.

       01  L-INPUT-BUFFER.
           05  L-INPUT-CHAR        PIC X(01)       OCCURS 32768
                                                   INDEXED L-I-DX.

       01  L-OUTPUT-BUFFER.
           05  L-OUTPUT-HEX        PIC X(02)       OCCURS 32768
                                                   INDEXED L-O-DX.
      /
       PROCEDURE DIVISION USING L-PARAMETER.
      *==================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT
               VARYING L-I-DX FROM 1 BY 1
                 UNTIL L-I-DX > HD-INPUT-LEN
           .
       MAIN-EXIT.
           GOBACK.
      /
       SUB-1000-START-UP.
      *------------------

           SET  ADDRESS OF L-INPUT-BUFFER
                                   TO HD-INPUT-PTR
           SET  ADDRESS OF L-OUTPUT-BUFFER
                                   TO HD-OUTPUT-PTR

           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET W-NOT-FIRST-CALL    TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'HEXDUMP  compiled on '
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

           MOVE L-INPUT-CHAR(L-I-DX)
                                   TO W-SUB-2
           SET  L-O-DX             TO L-I-DX
           MOVE W-HEX-CHARS(W-SUB + 1)
                                   TO L-OUTPUT-HEX(L-O-DX)
           .
       SUB-2000-EXIT.
           EXIT.
