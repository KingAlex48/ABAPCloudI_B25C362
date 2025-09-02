CLASS zcl_save_github DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SAVE_GITHUB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    out->write( 'Save me to GitHub Again'  ).


  ENDMETHOD.
ENDCLASS.
