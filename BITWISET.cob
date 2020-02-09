      *=========================== BITWISET ===========================*
      * Authors: Brian D Pead
      *
      * Description: Program to test subroutine BITWISE.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       PROCESS TRUNC(BIN)

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.                 BITWISET.

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

      /
       WORKING-STORAGE SECTION.
      *------------------------

       01  W-INPUT-1-CHARS.  
           05  W-INPUT-1           PIC 9(09)  COMP.

       01  W-INPUT-2-CHARS.  
           05  W-INPUT-2           PIC 9(09)  COMP.

       01  W-OUTPUT                PIC 9(09)  COMP.
       01  W-BITWISE-PROG          PIC X(08)       VALUE 'BITWISE'.
       01  W-HEXDUMP-PROG          PIC X(08)       VALUE 'HEXDUMP'.
       01  W-HEX-1                 PIC X(08).
       01  W-HEX-2                 PIC X(08).
       01  W-HEX-3                 PIC X(08).

       01  W-OPERATIONS.
           05  FILLER              PIC X(05)       VALUE ' AND '.
           05  FILLER              PIC X(05)       VALUE ' OR  '.
           05  FILLER              PIC X(05)       VALUE ' XOR '.
       01  FILLER REDEFINES W-OPERATIONS.
           05  W-OPERATION         PIC X(05)       OCCURS 3.

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-BITWISE-PARAMETER.    COPY BITWISEL.

       01  W-HEXDUMP-PARAMETER.    COPY HEXDUMPL.
      /
       PROCEDURE DIVISION.
      *===================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT

           PERFORM SUB-3000-SHUT-DOWN THRU SUB-3000-EXIT
           .
       MAIN-EXIT.
           STOP RUN.
      /
       SUB-1000-START-UP.
      *------------------

           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'BITWISET compiled on '
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
           
           MOVE 1                  TO W-INPUT-1
           MOVE 2                  TO W-INPUT-2
           SET  BW-OPERATION-AND   TO TRUE

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

           SET  BW-OPERATION-OR    TO TRUE

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT
           
           MOVE 2808555105         TO W-INPUT-1
           MOVE 3                  TO W-INPUT-2
           SET  BW-OPERATION-OR    TO TRUE

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

           SET  BW-OPERATION-XOR   TO TRUE

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

           MOVE 255                TO W-INPUT-1
           MOVE X'FFFFFFFF'        TO W-INPUT-2-CHARS

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

           DISPLAY 'BITWISET completed'
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9100-CALL-BITWISE.
      *----------------------

           SET  BW-INPUT-1-PTR     TO ADDRESS OF W-INPUT-1
           SET  BW-INPUT-2-PTR     TO ADDRESS OF W-INPUT-2
           MOVE LENGTH OF W-INPUT-1
                                   TO BW-INPUT-LEN
           SET  BW-OUTPUT-PTR      TO ADDRESS OF W-OUTPUT

           CALL W-BITWISE-PROG  USING W-BITWISE-PARAMETER

           PERFORM SUB-9110-DISPLAY THRU SUB-9110-EXIT
           .
       SUB-9100-EXIT.
           EXIT.
      /
       SUB-9110-DISPLAY.
      *-----------------

           SET  HD-INPUT-PTR       TO ADDRESS OF W-INPUT-1
           MOVE LENGTH OF W-INPUT-1
                                   TO HD-INPUT-LEN
           SET  HD-OUTPUT-PTR      TO ADDRESS OF W-HEX-1

           CALL W-HEXDUMP-PROG  USING W-HEXDUMP-PARAMETER

           SET  HD-INPUT-PTR       TO ADDRESS OF W-INPUT-2
           MOVE LENGTH OF W-INPUT-2
                                   TO HD-INPUT-LEN
           SET  HD-OUTPUT-PTR      TO ADDRESS OF W-HEX-2

           CALL W-HEXDUMP-PROG  USING W-HEXDUMP-PARAMETER

           SET  HD-INPUT-PTR       TO ADDRESS OF W-OUTPUT
           MOVE LENGTH OF W-OUTPUT TO HD-INPUT-LEN
           SET  HD-OUTPUT-PTR      TO ADDRESS OF W-HEX-3

           CALL W-HEXDUMP-PROG  USING W-HEXDUMP-PARAMETER

           DISPLAY 'X'''
                   W-HEX-1
                   ''''
                   W-OPERATION(BW-OPERATION)
                   'X'''
                   W-HEX-2
                   ''' = X'''
                   W-HEX-3
                   ''''
           .
       SUB-9110-EXIT.
           EXIT.
