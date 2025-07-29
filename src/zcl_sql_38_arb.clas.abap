CLASS zcl_sql_38_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_38_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA: lv_page_number      TYPE i VALUE 1,
          lv_records_per_page TYPE i VALUE 5.

    DATA: gv_offset TYPE int8.

*    Page 1 = Block 0
*    Page 2 = Block 1

    gv_offset = ( lv_page_number - 1 ) * lv_records_per_page.

    SELECT FROM /DMO/I_Flight
           FIELDS *
           WHERE CurrencyCode EQ 'USD'
           ORDER BY AirlineID,ConnectionID, FlightDate ASCENDING
           INTO TABLE @DATA(lt_results)
           OFFSET @gv_offset "Saltate las primeras x filas
           UP TO @lv_records_per_page ROWS. "Traeme esas filas despues de haberte saltado.

    IF sy-subrc EQ 0.
      out->write( lt_results ).
      ELSE.
          out->write( 'No rows available for the next page' ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
