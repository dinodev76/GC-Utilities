      *============================ CRC32 =============================*
      * Authors: Brian D Pead
      *
      * Description: Subroutine to calculate a CRC-32 checksum on the  
      *              specified input.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

       IDENTIFICATION DIVISION.
      *========================

       PROGRAM-ID.                 CRC32.

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

       01  W-CHECKSUM-SHIFT        PIC 9(09)  COMP.
       01  W-BITWISE-RESULT        PIC 9(09)  COMP.
       01  W-BITWISE-PROG          PIC X(08)       VALUE 'BITWISE'.

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

       01  W-HIGH-VALUES-X         PIC X(04)       VALUE HIGH-VALUES.
       01  W-HIGH-VALUES-BIN REDEFINES W-HIGH-VALUES-X
                                   PIC 9(09)  COMP.

       01  W-INPUT-1               PIC 9(09)  COMP.
       01  W-INPUT-1-BYTES REDEFINES W-INPUT-1.
           05  W-INPUT-1-1-3       PIC X(03).
           05  W-INPUT-1-4         PIC X(01).

       01  W-INPUT-2               PIC 9(09)  COMP.
       01  W-INPUT-2-BYTES REDEFINES W-INPUT-2.
           05  W-INPUT-2-1-3       PIC X(03).
           05  W-INPUT-2-4         PIC X(01).

       01  W-SUB-1                 PIC S9(04) COMP.
       01  FILLER REDEFINES W-SUB-1.
           05  FILLER              PIC X(01)       VALUE X'00'.
           05  W-SUB-1-2           PIC X(01).

       01  W-SUB-2                 PIC S9(04) COMP.
       01  FILLER REDEFINES W-SUB-2.
           05  FILLER              PIC X(01)       VALUE X'00'.
           05  W-SUB-2-2           PIC X(01).

       01  W-BITWISE-PARAMETER.    COPY BITWISEL.

       COPY CRC32W.
      /
       LINKAGE SECTION.
      *----------------

       01  L-PARAMETER.            COPY CRC32L.

       01  L-BUFFER.
           05  L-BUFFER-BYTE       PIC X(01)       OCCURS 32768
                                                   INDEXED L-DX.
      /
       PROCEDURE DIVISION USING L-PARAMETER.
      *==================

       MAIN.
      *-----

           PERFORM SUB-1000-START-UP THRU SUB-1000-EXIT

           PERFORM SUB-2000-PROCESS THRU SUB-2000-EXIT
               VARYING L-DX FROM 1 BY 1
                 UNTIL L-DX > CRC-BUFFER-LEN

           IF      CRC-STAGE-START-END
           OR      CRC-STAGE-END
               PERFORM SUB-3000-COMPLEMENT THRU SUB-3000-EXIT
           END-IF
           .
       MAIN-EXIT.
           GOBACK.
      /
       SUB-1000-START-UP.
      *------------------

           IF      CRC-STAGE-START-END
           OR      CRC-STAGE-START
               MOVE W-HIGH-VALUES-BIN 
                                   TO CRC-CHECKSUM
           END-IF

           SET  ADDRESS OF L-BUFFER
                                   TO CRC-BUFFER-PTR
           SET  BW-OPERATION-XOR   TO TRUE
           MOVE 4                  TO BW-INPUT-LEN
           SET  BW-OUTPUT-PTR      TO ADDRESS OF W-BITWISE-RESULT

           IF      W-NOT-FIRST-CALL
               GO TO SUB-1000-EXIT
           END-IF

           SET W-NOT-FIRST-CALL    TO TRUE
           MOVE FUNCTION WHEN-COMPILED 
                                   TO W-COMPILED-DATE

           DISPLAY 'CRC32    compiled on '
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

      **** SHIFT CRC 8 BITS RIGHT:
           COMPUTE W-CHECKSUM-SHIFT
                                   =  CRC-CHECKSUM / 256

      **** USE LAST BYTE OF CRC:
           MOVE CRC-CHECKSUM       TO W-INPUT-1
           MOVE LOW-VALUES         TO W-INPUT-1-1-3

      **** NEXT BYTE OF INPUT:
           MOVE 0                  TO W-INPUT-2
           MOVE L-BUFFER-BYTE(L-DX)
                                   TO W-INPUT-2-4

      **** XOR LAST BYTE OF CRC AND NEXT BYTE OF INPUT:
           SET  BW-INPUT-1-PTR     TO ADDRESS OF W-INPUT-1
           SET  BW-INPUT-2-PTR     TO ADDRESS OF W-INPUT-2

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

      **** XOR TABLE ENTRY AND CRC>>8:
           SET  BW-INPUT-1-PTR     TO ADDRESS OF
                                     W-CRC32-ENTRY(W-BITWISE-RESULT + 1)
           SET  BW-INPUT-2-PTR     TO ADDRESS OF W-CHECKSUM-SHIFT

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

           MOVE W-BITWISE-RESULT   TO CRC-CHECKSUM
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-3000-COMPLEMENT.
      *--------------------

      **** BITWISE COMPLEMENT (I.E. BITWISE NOT):
           SET  BW-INPUT-1-PTR     TO ADDRESS OF CRC-CHECKSUM
           SET  BW-INPUT-2-PTR     TO ADDRESS OF W-HIGH-VALUES-X

           PERFORM SUB-9100-CALL-BITWISE THRU SUB-9100-EXIT

           MOVE W-BITWISE-RESULT   TO CRC-CHECKSUM
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9100-CALL-BITWISE.
      *----------------------

           CALL W-BITWISE-PROG  USING W-BITWISE-PARAMETER
           .
       SUB-9100-EXIT.
           EXIT.
