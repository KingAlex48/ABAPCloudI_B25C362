CLASS zcl_sql_27_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_27_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM zcarrier_arb
           FIELDS *
           WHERE carrier_id IN ( 'AA', 'AC', 'JL', 'WZ' )
           INTO TABLE @DATA(lt_airlines).

    IF sy-subrc EQ 0.
      out->write( lt_airlines ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
