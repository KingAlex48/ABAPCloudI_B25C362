CLASS zcl_sql_25_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_25_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lv_search_criteria TYPE string VALUE '__rlin%'.

    SELECT FROM /DMO/I_Airport
           FIELDS *
           WHERE name like @lv_search_criteria
           INTO TABLE @DATA(lt_airports).

    IF sy-subrc EQ 0.
      out->write( lt_airports ).
    ELSE.
      out->write( 'NO DATA' ).
    ENDIF.







  ENDMETHOD.
ENDCLASS.
