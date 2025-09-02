CLASS zcl_sql_26_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_26_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*    SELECT FROM zcarrier_arb
*           FIELDS *
*           WHERE currency_code EQ 'USD'
*           INTO TABLE @DATA(lt_airlines).
*
*    IF sy-subrc EQ 0.
*
*      LOOP AT lt_airlines ASSIGNING FIELD-SYMBOL(<ls_airline>).
*        <ls_airline>-name = |New %: { <ls_airline>-name }|.
*      ENDLOOP.
*
*      UPDATE zcarrier_arb FROM TABLE @lt_airlines.
*
*    ENDIF.

    CONSTANTS cv_escape TYPE c LENGTH 1 VALUE '?'. "Puede ser cualquier valor para el escape

    SELECT FROM zcarrier_arb
           FIELDS *
           WHERE name LIKE '%?%%' ESCAPE @cv_escape "Buscamos el valor explícito '%'
           INTO TABLE @DATA(lt_airlines).

    IF sy-subrc EQ 0.
      out->write( lt_airlines ).
    ELSE.
      out->write( 'No data' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
