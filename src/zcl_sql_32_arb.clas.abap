CLASS zcl_sql_32_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_32_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
           FIELDS AVG( MaximumSeats ) AS AvgSeats, "promedio
                  SUM( MaximumSeats ) AS SumSeats "sumatoria
           WHERE AirlineID EQ 'AA'
           INTO ( @DATA(lv_avg_seats), @DATA(lv_sum_seats) ).


    IF sy-subrc EQ 0.
      out->write( |Avg Seats: { lv_avg_seats } ; Sum Seats: { lv_sum_seats  }| ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
