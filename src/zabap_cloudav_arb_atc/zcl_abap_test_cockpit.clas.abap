CLASS zcl_abap_test_cockpit DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_ABAP_TEST_COCKPIT IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

********************************************************CÓDIGO NO EFICIENTE
       SELECT  FROM /dmo/i_connection
               FIELDS DepartureTime
               INTO  TABLE @DATA(lt_connection).

********************************************************CÓDIGO EFICIENTE
*    SELECT SINGLE FROM /dmo/i_connection
*           FIELDS DepartureTime
*           INTO  @DATA(ls_connection).



  ENDMETHOD.
ENDCLASS.
