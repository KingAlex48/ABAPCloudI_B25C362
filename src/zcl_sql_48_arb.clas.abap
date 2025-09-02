CLASS zcl_sql_48_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_48_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    SELECT FROM  /DMO/I_Flight AS Flight
           FIELDS *
           WHERE AirlineID IN ( SELECT FROM /DMO/I_Connection
                                        FIELDS AirlineID
                                        WHERE   AirlineID  EQ Flight~AirlineID
                                        AND   ConnectionID EQ Flight~ConnectionID )
           INTO TABLE @DATA(lt_flights).

    IF sy-subrc EQ 0.
      out->write( lines( lt_flights ) ).
      out->write( lt_flights ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
