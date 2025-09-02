CLASS zcl_sql_55_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_55_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*Compara todas las combinaciones posibles entre registros de varias tablas.

    SELECT FROM zdatasource_1 AS ds1
           CROSS JOIN zdatasource_2 AS ds2
           CROSS JOIN zdatasource_3 AS ds3
           FIELDS ds1~id AS id1,
                  ds2~id AS id2,
                  ds3~id AS id3,
                  ds1~name1,
                  ds2~name2,
                  ds3~name3,
                  ds1~datasource1,
                  ds2~datasource2,
                  ds3~datasource3
           INTO TABLE @DATA(lt_results_cross).

    IF sy-subrc EQ 0.
      out->write( lines( lt_results_cross ) ). "5x5x5 = 125 rows
      out->write( lt_results_cross ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
