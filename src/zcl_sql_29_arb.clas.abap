CLASS zcl_sql_29_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_29_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    CONSTANTS lc_no_value TYPE c VALUE ''.

    SELECT FROM zflight_arb
           FIELDS *
           WHERE currencycode IS NULL " NO TENEMOS NIGUNA ASIGNACIÓN DE MEMORIA EN LA DB
           OR currencycode EQ @lc_no_value "Valor con espacio vacío,tenemos un asignación en DB
           OR currencycode EQ @space "Valor con un espacio
           INTO TABLE @DATA(lt_flight).

    IF sy-subrc EQ 0.
      out->write( lt_flight ).
    ELSE.
      out->write( 'Not null or empty values available' ).
    ENDIF.



  ENDMETHOD.
ENDCLASS.
