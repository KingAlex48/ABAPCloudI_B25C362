CLASS zcl_gtt_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_gtt_arb IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

*    DATA lt_employees TYPE STANDARD TABLE OF zempl_lgl_arb.

*    INSERT zempl_lgl_arb FROM TABLE @( VALUE #( ( emp_id = '0001'
*                                                   first_name = 'Jhon'
*                                                   last_name = 'Smith' ) ) ) .

    SELECT FROM zempl_lgl_arb
          FIELDS *
          INTO TABLE @DATA(lt_employees).

    IF sy-subrc EQ 0.
      out->write( lt_employees ).
    ELSE.
      out->write( |No data| ).
    ENDIF.

*    DELETE FROM zempl_lgl_arb. "Uso en lenguajes anteriores
*    COMMIT WORK.
*    ROLLBACK WORK.



  ENDMETHOD.

ENDCLASS.
