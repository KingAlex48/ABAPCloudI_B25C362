CLASS zcl_sql_45_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_45_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


*    SELECT FROM /DMO/I_Flight
*           FIELDS AirlineID,
*                  COUNT( * ) AS FlightsAvaiables
*           GROUP BY AirlineID
*           ORDER BY FlightsAvaiables DESCENDING
*           INTO TABLE @DATA(lt_flights).
*           UP TO 1 ROWS.

**********************************************************************


    SELECT FROM /DMO/I_Flight
           FIELDS AirlineID,
                  COUNT( * ) AS FlightsAvaiables
           GROUP BY AirlineID
           HAVING COUNT( * ) GE ALL ( SELECT FROM /DMO/I_Flight ""Dame la(s) aerolínea(s) con el máximo número de vuelos."
                                             FIELDS COUNT( * )
                                             GROUP BY AirlineID )
           INTO TABLE @DATA(lt_flights).


    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
