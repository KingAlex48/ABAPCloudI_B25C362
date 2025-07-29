CLASS zcl_sql_35_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_35_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
            FIELDS AirlineID, "Criterio por el que se va a agrupar la exp, agregación
                   COUNT( DISTINCT ConnectionID ) AS CountDistinctConn
            WHERE FlightDate GE '20250101'
            GROUP BY AirlineID "Se deben agregar en FIELDS
            INTO TABLE @DATA(lt_results).


    IF sy-subrc EQ 0.
      out->write( lt_results ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
