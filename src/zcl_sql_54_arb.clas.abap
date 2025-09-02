CLASS zcl_sql_54_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_54_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************LEFT EXCLUDING INNER JOIN
    SELECT FROM zdatasource_1 AS ds1
           FIELDS *
           WHERE ds1~id NOT IN ( SELECT FROM zdatasource_2 AS ds2
                                         FIELDS id
                                         WHERE ds1~id = ds2~id )
            INTO TABLE @DATA(lt_results_EX_LEFT).

    IF sy-subrc EQ 0.
      out->write( |LEFT EXCLUDING INNER JOIN :  | ).
      out->write( lt_results_EX_LEFT ).
    ENDIF.

    out->write(  cl_abap_char_utilities=>newline ).
**********************************************************************RIGHT EXCLUDING INNER JOIN
    SELECT FROM zdatasource_2 AS ds2
            FIELDS *
            WHERE ds2~id NOT IN ( SELECT FROM zdatasource_1 AS ds1
                                          FIELDS id
                                          WHERE ds1~id = ds2~id )
             INTO TABLE @DATA(lt_results_EX_RIGHT).

    IF sy-subrc EQ 0.
      out->write( |RIGHT EXCLUDING INNER JOIN:  | ).
      out->write( lt_results_EX_RIGHT ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
