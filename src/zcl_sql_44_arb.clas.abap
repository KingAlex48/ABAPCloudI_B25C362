CLASS zcl_sql_44_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_44_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

**********************************************************************
    SELECT FROM /DMO/I_Flight
           FIELDS *
           WHERE Price EQ ( SELECT FROM /DMO/I_Flight
                                   FIELDS MIN( Price ) )
           INTO TABLE @DATA(lt_flights_lowcost).


    IF sy-subrc EQ 0.
      out->write( lt_flights_lowcost ).
    ENDIF.

********************************************************************** DO NOT USE

    TRY.

        SELECT FROM /DMO/I_Connection
               FIELDS *
               WHERE AirlineID EQ  ( SELECT FROM /DMO/I_Flight
                                       FIELDS AirlineID
                                       WHERE departureAirport EQ 'JFK' )
               INTO TABLE @DATA(lt_flights).


        IF sy-subrc EQ 0.
          out->write( lt_flights ).
        ENDIF.

      CATCH cx_sy_open_sql_db INTO DATA(lx_sql_db).
        out->write( lx_sql_db->get_text(  ) ).

    ENDTRY.



  ENDMETHOD.
ENDCLASS.
