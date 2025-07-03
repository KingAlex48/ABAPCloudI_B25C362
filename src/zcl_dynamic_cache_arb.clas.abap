CLASS zcl_dynamic_cache_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_dynamic_cache_arb IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.

    GET TIME STAMP FIELD DATA(lv_timestamp_begin).

    SELECT FROM zinvoice_lgl_arb
           FIELDS comp,
                  currency_key,
                  SUM( amount ) AS TotalAmount
                  GROUP BY comp, currency_key
                  INTO TABLE @DATA(lt_invoices).

    IF sy-subrc EQ 0.

      GET TIME STAMP FIELD DATA(lv_timestamp_end).

      DATA(lv_dif_sec) = cl_abap_tstmp=>subtract( "Diferencia entre dos tiempos
        EXPORTING
                           tstmp1 = lv_timestamp_end
                           tstmp2 = lv_timestamp_begin  ).

      out->write( |Number of records : { lines( lt_invoices ) }| ).
      out->write( lt_invoices ).

      out->write( |Total execution time: { lv_dif_sec }| ).


    ENDIF.


  ENDMETHOD.

ENDCLASS.
