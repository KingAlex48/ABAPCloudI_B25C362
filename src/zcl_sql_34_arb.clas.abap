CLASS zcl_sql_34_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_34_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
           FIELDS COUNT( * ) AS  CountAll, "Nos dice el número de registros
                  COUNT( DISTINCT MaximumSeats ) AS CountMaximumSeats
           WHERE AirlineID EQ 'AA'
           INTO ( @DATA(lv_count_all), @DATA(lv_distinct_seats) ).


    IF sy-subrc EQ 0.
      out->write( |Count All: { lv_count_all } ; Sum Seats: { lv_distinct_seats }| ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
