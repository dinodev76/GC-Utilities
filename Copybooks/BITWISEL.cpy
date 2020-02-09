      *========================= BITWISEL.cpy =========================*
      * Authors: Brian D Pead
      *
      * Description: Linkage parameter for subroutine BITWISE which 
      *              performs the requested bitwise operation.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      *01  BITWISE-PARAMETER.

      **** Input fields:
      ****     BW-OPERATION:
      ****         Operation to perform. 
      ****     BW-INPUT-1-PTR:
      ****         Pointer to first input. 
      ****     BW-INPUT-2-PTR:
      ****         Pointer to second input. 
      ****     BW-INPUT-LEN:
      ****         Length of inputs (output length is the same). 
      ****     BW-OUTPUT-PTR:
      ****         Pointer to output. 

      **** Output field:
      ****     The area pointed to by BW-OUTPUT-PTR. 

           05  BW-OPERATION        PIC S9(04) COMP.
               88  BW-OPERATION-AND                VALUE 1.
               88  BW-OPERATION-OR                 VALUE 2.
               88  BW-OPERATION-XOR                VALUE 3.

           05  BW-INPUT-1-PTR                      POINTER.

           05  BW-INPUT-2-PTR                      POINTER.

           05  BW-INPUT-LEN        PIC 9(09)  COMP.

           05  BW-OUTPUT-PTR                       POINTER.
