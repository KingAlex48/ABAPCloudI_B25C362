CLASS zcl_sql_30_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_30_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/I_connection
           FIELDS *
           WHERE
                ( AirlineID EQ 'AA'
                 OR AirlineID EQ 'LH' )
            AND
               (  DepartureAirport EQ 'SFO'
                 OR DepartureAirport EQ 'JFK' )

             and
                not ConnectionID eq '0015'

            INTO TABLE @DATA(lt_flights).

    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ELSE.
      out->write( 'NO DATA' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
