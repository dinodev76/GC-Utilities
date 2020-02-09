      *============================ CRC32T ============================*
      * Authors: Brian D Pead
      *
      * Description: Program to test subroutine CRC32.
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

       PROGRAM-ID.                 CRC32T.

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

       01  W-CRC32-PROG            PIC X(08)       VALUE 'CRC32'.
       01  W-HEXDUMP-PROG          PIC X(08)       VALUE 'HEXDUMP'.
       01  W-HEX                   PIC X(08).

       01  W-BUFFER                                VALUE
           'The quick brown fox jumps over the lazy dog'.
           05  W-BUFFER-1          PIC X(20).
           05  W-BUFFER-2          PIC X(20).
           05  W-BUFFER-3          PIC X(03).

       01  W-COMPILED-DATE.
           05  W-COMPILED-DATE-YYYY
                                   PIC X(04).
           05  W-COMPILED-DATE-MM  PIC X(02).
           05  W-COMPILED-DATE-DD  PIC X(02).
           05  W-COMPILED-TIME-HH  PIC X(02).
           05  W-COMPILED-TIME-MM  PIC X(02).
           05  W-COMPILED-TIME-SS  PIC X(02).
           05  FILLER              PIC X(07).

       01  W-CRC32-PARAMETER.      COPY CRC32L.

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

           DISPLAY 'CRC32T   compiled on '
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

      **** CALCULATE CHECKSUM OF ENTIRE TEXT IN 1 CALL:

           SET  CRC-STAGE-START-END
                                   TO TRUE 
           SET  CRC-BUFFER-PTR     TO ADDRESS OF W-BUFFER
           MOVE LENGTH OF W-BUFFER TO CRC-BUFFER-LEN

           PERFORM SUB-9100-CALL-CRC32 THRU SUB-9100-EXIT

           PERFORM SUB-9200-DISPLAY-HEX THRU SUB-9200-EXIT

      **** CALCULATE CHECKSUM OF TEXT IN 3 CHUNKS:

           SET  CRC-STAGE-START    TO TRUE 
           SET  CRC-BUFFER-PTR     TO ADDRESS OF W-BUFFER-1
           MOVE LENGTH OF W-BUFFER-1
                                   TO CRC-BUFFER-LEN

           PERFORM SUB-9100-CALL-CRC32 THRU SUB-9100-EXIT

           SET  CRC-STAGE-IN-PROCESS
                                   TO TRUE 
           SET  CRC-BUFFER-PTR     TO ADDRESS OF W-BUFFER-2
           MOVE LENGTH OF W-BUFFER-2
                                   TO CRC-BUFFER-LEN

           PERFORM SUB-9100-CALL-CRC32 THRU SUB-9100-EXIT

           SET  CRC-STAGE-END      TO TRUE 
           SET  CRC-BUFFER-PTR     TO ADDRESS OF W-BUFFER-3
           MOVE LENGTH OF W-BUFFER-3
                                   TO CRC-BUFFER-LEN

           PERFORM SUB-9100-CALL-CRC32 THRU SUB-9100-EXIT

           PERFORM SUB-9200-DISPLAY-HEX THRU SUB-9200-EXIT
           .
       SUB-2000-EXIT.
           EXIT.
      /
       SUB-3000-SHUT-DOWN.
      *-------------------

           DISPLAY 'CRC32T   completed'
           .
       SUB-3000-EXIT.
           EXIT.
      /
       SUB-9100-CALL-CRC32.
      *----------------------

           CALL W-CRC32-PROG    USING W-CRC32-PARAMETER
           .
       SUB-9100-EXIT.
           EXIT.
      /
       SUB-9200-DISPLAY-HEX.
      *---------------------

           SET  HD-INPUT-PTR       TO ADDRESS OF CRC-CHECKSUM
           MOVE LENGTH OF CRC-CHECKSUM
                                   TO HD-INPUT-LEN
           SET  HD-OUTPUT-PTR      TO ADDRESS OF W-HEX

           CALL W-HEXDUMP-PROG  USING W-HEXDUMP-PARAMETER

           DISPLAY 'Checksum of '''
                   W-BUFFER
                   ''' is X'''
                   W-HEX
                   ''''
           .
       SUB-9200-EXIT.
           EXIT.
