CLASS zcl_auth_checks_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_AUTH_CHECKS_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lv_country_code TYPE land VALUE 'EN'.
    DATA lv_company_code TYPE c LENGTH 10 VALUE 'LOGALI'.


    AUTHORITY-CHECK OBJECT 'ZAO_BILL'"OBJ. DE AUTORIZACIÓN 'Z'.
    ID 'ZAF_CCODE' FIELD lv_company_code
    ID 'ACTVT' FIELD '01'.

    AUTHORITY-CHECK OBJECT '/DMO/TRVL' "OBJ. DE AUTORIZACIÓN ESTÁNDAR
    ID 'DMO/CNTRY' FIELD lv_country_code "referencia a un campo del obj. de Aut.
    ID 'ACTVT' FIELD '01'. "verifica si el usuario tiene permiso para la actividad 01 (crear)



    DATA(lv_create_granted) =  COND #( WHEN sy-subrc = 0 THEN abap_true
                                                         ELSE abap_false ).

    IF lv_create_granted EQ abap_true.
      out->write( |YOU HAVE AUTHORIZATION TO USE THE COUNTRY CODE { lv_country_code } ON THE OPERATION | ).
    ELSE.
      out->write( |YOU DON´T HAVE AUTHORIZATION TO USE THE COUNTRY CODE { lv_country_code } ON THE OPERATION | ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
