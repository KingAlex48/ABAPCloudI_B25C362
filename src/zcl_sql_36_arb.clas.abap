CLASS zcl_sql_36_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_36_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**************ORDER OF EXECUTION******
*1.FROM
*2.WHERE
*3.GROUP BY
*4.HAVING
*5.SELECT
*6 ORDER BY
*7. UP TO (LIMIT)

    SELECT FROM /dmo/i_flight
              FIELDS AirlineID,
                     MIN( MaximumSeats ) AS MinSeats,
                     MAX( MaximumSeats ) AS MaxSeats
              WHERE FlightDate BETWEEN '20250101' AND '20301231'
              GROUP BY AirlineID HAVING AirlineID IN (  'AA', 'LH' , 'UA' )
              INTO TABLE @DATA(lt_results).


    IF sy-subrc EQ 0.
      out->write( lt_results ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
