CLASS zcl_sql_46_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_46_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************ANY


    SELECT FROM /DMO/I_Connection AS Connecction
           FIELDS *
           WHERE AirlineId EQ ANY ( SELECT FROM /DMO/I_Flight "Dame todas las conexiones donde la aerolínea tenga al menos un vuelo con 100 o más asientos ocupados."
                                           FIELDS AirlineID
                                           WHERE OccupiedSeats GE 300 )
           INTO TABLE @DATA(lt_flights).


    IF sy-subrc EQ 0.
      out->write( |ANY:  { lines( lt_flights )  }| ).
      out->write(  lt_flights  ).

    ENDIF.

**********************************************************************SOME

    SELECT FROM /DMO/I_Connection AS Connecction
           FIELDS *
           WHERE AirlineId EQ SOME ( SELECT FROM /DMO/I_Flight
                                           FIELDS AirlineID
                                           WHERE OccupiedSeats GE 300 )
            INTO TABLE @DATA(lt_flights_some).


    IF sy-subrc EQ 0.
      out->write( |SOME:  { lines( lt_flights_some )  }| ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
