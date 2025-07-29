CLASS zcl_sql_41_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_41_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    TYPES: BEGIN OF ty_content,
             AirlineID          TYPE /DMO/Carrier_ID,
             connectionid       TYPE /dmo/connection_id,
             FlightDate         TYPE /dmo/flight_date,
             Price              TYPE /dmo/flight_price,
             CurrencyCode       TYPE /dmo/currency_code,
             DepartureAirport   TYPE /dmo/airport_from_id,
             DestinationAirport TYPE /dmo/airport_to_id,
           END OF ty_content.


    DATA: lt_content          TYPE STANDARD TABLE OF ty_content,
          lv_datasource_name  TYPE string,
          lv_selected_columns TYPE string,
          lv_where_conditions TYPE string,
          lv_airline_id       TYPE string.

    DATA lx_dynamic_osql TYPE REF TO cx_root.

    lv_datasource_name = '/DMO/I_Connection'. " '/DMO/I_Flight' '/DMO/I_Connection'

    IF lv_datasource_name EQ '/DMO/I_Flight'.
      lv_selected_columns = |AirlineID, ConnectionID, FlightDate, Price, CurrencyCode|.
      lv_airline_id = 'LH'.
*      lv_where_conditions = |( AirlineID eq 'LH' or AirlineID eq 'AA' ) and CurrencyCode eq 'USD'|.
    ELSEIF lv_datasource_name EQ '/DMO/I_Connection'.
      lv_selected_columns = |AirlineID, ConnectionID, DepartureAirport, DestinationAirport|.
      lv_where_conditions = |AirlineID eq 'LH' or AirlineID eq 'AA'|.
      lv_airline_id = 'AA'.
    ELSE.
      RETURN.
    ENDIF.

    lv_where_conditions =  |AirlineID eq '{ lv_airline_id  }'|.

    TRY.

        SELECT FROM (lv_datasource_name)
               FIELDS (lv_selected_columns)
               WHERE (lv_where_conditions)
               INTO CORRESPONDING FIELDS OF TABLE @lt_content.

      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics
            cx_sy_dynamic_osql_error INTO lx_dynamic_osql.

        out->write( lx_dynamic_osql->get_text(  ) ).
        RETURN.
    ENDTRY.

    IF sy-subrc EQ 0.
      out->write( lines( lt_content ) ).
      out->write( lt_content ).
    ELSE.
      out->write( 'No data' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
