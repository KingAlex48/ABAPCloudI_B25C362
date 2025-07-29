CLASS zcl_sql_47_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_47_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**EXITS: USAR Cuando quieres verificar si existe al menos un registro
**que cumpla cierta condición relacionada.

    SELECT FROM /DMO/I_Flight  AS flights
           FIELDS *
           WHERE OccupiedSeats LT Flights~MaximumSeats
           AND EXISTS ( SELECT FROM zcarrier_arb " Verifica Si existe al menos un valor que coinicide
                               FIELDS carrier_id "Si es así imprime los valores de la otra query , si no no.
                               WHERE carrier_id EQ flights~AirlineID )
            INTO TABLE @DATA(lt_flights).


    IF sy-subrc EQ 0.
      out->write( lines( lt_flights ) ).
      out->write( lt_flights ).

    ELSE.
      out->write( 'NO DATA' ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
