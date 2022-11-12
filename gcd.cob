      * Tested with GNU COBOL 4
      *
      * Synopsis:
      *
      * $ cobc -x gcd.cob -o gcd-cob
      * $ ./gcd-cob 11 22 33 121
      *
       IDENTIFICATION DIVISION.
       PROGRAM-ID. GCD.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-COUNT PIC 9(20).
       01 WS-GCD PIC Z(20).
       01 WS-NUM PIC 9(20).
       PROCEDURE DIVISION.
           ACCEPT WS-COUNT FROM ARGUMENT-NUMBER.
           IF WS-COUNT = 0 STOP RUN.
           ACCEPT WS-GCD FROM ARGUMENT-VALUE.
           PERFORM WITH TEST BEFORE UNTIL WS-COUNT = 1
             ACCEPT WS-NUM FROM ARGUMENT-VALUE
             CALL 'GCD2' USING WS-GCD, WS-NUM
             SUBTRACT 1 FROM WS-COUNT
           END-PERFORM.
           DISPLAY FUNCTION TRIM (WS-GCD LEADING).
       END PROGRAM GCD.

       IDENTIFICATION DIVISION.
       PROGRAM-ID. GCD2.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-C PIC 9(20).
       LINKAGE SECTION.
       01 L-A PIC Z(20).
       01 L-B PIC 9(20).
       PROCEDURE DIVISION USING L-A, L-B.
           PERFORM WITH TEST BEFORE UNTIL L-B = 0
             MOVE L-B TO WS-C
             DIVIDE WS-C INTO L-A GIVING L-A REMAINDER L-B
             MOVE WS-C TO L-A
           END-PERFORM.
       END PROGRAM GCD2.

