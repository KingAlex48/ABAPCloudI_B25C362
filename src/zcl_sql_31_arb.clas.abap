CLASS zcl_sql_31_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_31_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
           FIELDS MIN( MaximumSeats )
           INTO @DATA(lv_min_seats).

    IF sy-subrc EQ 0.
      out->write( |Min Seats: { lv_min_seats }| ).
    ENDIF.


    SELECT FROM /dmo/i_flight
           FIELDS MIN( MaximumSeats ) AS MinSeats,
                  MAX( MaximumSeats ) AS MaxSeats
                  INTO ( @lv_min_seats, @DATA(lv_max_seats) ).

    IF sy-subrc EQ 0.
      out->write( |Min Seats: { lv_min_seats }; Max Seats: { lv_max_seats }| ).
    ENDIF.


    SELECT FROM /dmo/i_flight
          FIELDS MIN( MaximumSeats ) AS MinSeats,
                 MAX( MaximumSeats ) AS MaxSeats
                 INTO @DATA(ls_max_seats).

    IF sy-subrc EQ 0.
      out->write( ls_max_seats ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
