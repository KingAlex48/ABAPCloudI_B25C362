CLASS zcl_sql_43_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_43_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM zflight_arb AS Flights
           FIELDS flights~airlineid AS Airline,
                  connectionid      AS Connection
           GROUP BY  airlineid, connectionid
           INTO TABLE @DATA(lt_flights).

    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
