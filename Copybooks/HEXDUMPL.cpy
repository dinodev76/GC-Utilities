      *========================= HEXDUMPL.cpy =========================*
      * Authors: Brian D Pead
      *
      * Description: Linkage parameter for subroutine HEXDUMP which 
      *              convert input buffer to hex output.
      *
      * License: MIT
      *
      * Date        Version  Description
      * ----        -------  -----------
      * 2020-02-08  1.0      First release
      *================================================================*

      *01  HEXDUMP-PARAMETER.

      **** Input fields:
      ****     HD-INPUT-PTR:
      ****         Pointer to input. 
      ****     HD-INPUT-LEN:
      ****         Length of input. 
      ****     HD-OUTPUT-PTR:
      ****         Pointer to output (area must be twice the length of
      ****         the input). 

      **** Output field:
      ****     The area pointed to by HD-OUTPUT-PTR. 

           05  HD-INPUT-PTR                        POINTER.

           05  HD-INPUT-LEN        PIC 9(09)  COMP.

           05  HD-OUTPUT-PTR                       POINTER.
