CLASS zcl_abap_cleaner DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_abap_cleaner IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_amount TYPE i,
          lv_vat    TYPE i VALUE 1.

    lv_amount += 1.
    lv_amount -= 1.
    lv_amount *= 1.

    lv_amount *= lv_vat.
    lv_amount /= lv_vat.

    lv_amount *= -10.

    lv_amount += 2.
    lv_vat *= -10.




  ENDMETHOD.

ENDCLASS.
