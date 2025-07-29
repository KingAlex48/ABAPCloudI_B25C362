CLASS zcl_sql_33_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_33_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
           FIELDS AVG( DISTINCT MaximumSeats ) AS AvgSeats, "No toma los valores repetidos
                  SUM( DISTINCT MaximumSeats ) AS SumSeats
           WHERE AirlineID EQ 'AA'
           INTO ( @DATA(lv_avg_seats), @DATA(lv_sum_seats) ).


    IF sy-subrc EQ 0.
      out->write( |Avg Seats: { lv_avg_seats } ; Sum Seats: { lv_sum_seats  }| ).
    ENDIF.





  ENDMETHOD.
ENDCLASS.
