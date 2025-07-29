CLASS zcl_sql_42_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_42_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lo_generic_data TYPE REF TO data. "Declara una variable de tipo referencia genérica a datos

    FIELD-SYMBOLS <lt_itab> TYPE STANDARD TABLE.


    DATA: lv_datasource_name  TYPE string,
          lv_selected_columns TYPE string,
          lv_where_conditions TYPE string,
          lv_airline_id       TYPE string.

    DATA lx_dynamic_osql TYPE REF TO cx_root.

    lv_datasource_name = '/DMO/I_Connection' . " '/DMO/I_Flight' '/DMO/I_Connection'

    IF lv_datasource_name EQ '/DMO/I_Flight'.
      lv_selected_columns = |AirlineID, ConnectionID, FlightDate, Price, CurrencyCode|.
      lv_airline_id = 'LH'.
*      lv_where_conditions = |( AirlineID eq 'LH' or AirlineID eq 'AA' ) and CurrencyCode eq 'USD'|.
    ELSEIF lv_datasource_name EQ '/DMO/I_Connection'.
      lv_selected_columns = |AirlineID, ConnectionID, DepartureAirport, DestinationAirport|.
*      lv_where_conditions = |AirlineID eq 'LH' or AirlineID eq 'AA'|.
      lv_airline_id = 'AA'.
    ELSE.
      RETURN.
    ENDIF.

    lv_where_conditions =  |AirlineID eq '{ lv_airline_id  }'|.

    TRY.

        DATA(lo_comp_table) = CAST cl_abap_structdescr( cl_abap_typedescr=>describe_by_name( lv_datasource_name
                                                                                            ) )->get_components( ). " Obtiene los componentes (campos) de la estructura del CDS View indicado por nombre en lv_datasource_name,
                                                                                                                     "convirtiendo dinámicamente su tipo a estructura."
        DATA(lo_struct_type) = cl_abap_structdescr=>create( lo_comp_table ). "Usa la lista de componentes (lo_comp_table) para crear una definición de estructura dinámica (tipo estructura).

        DATA(lo_table_type) = cl_abap_tabledescr=>create( lo_struct_type ). "lo_table_type representa el tipo de una tabla interna con la misma estructura que el CDS View.

        CREATE DATA lo_generic_data TYPE HANDLE lo_table_type. "crea una instancia real de la tabla interna en memoria, usando el tipo dinámico lo_table_type.
        ASSIGN lo_generic_data->* TO <lt_itab>. "Asigna la tabla interna dinámica creada al símbolo de campo <lt_itab>

        SELECT FROM (lv_datasource_name)
               FIELDS (lv_selected_columns)
               WHERE (lv_where_conditions)
               INTO TABLE @<lt_itab>.

      CATCH cx_sy_dynamic_osql_syntax
            cx_sy_dynamic_osql_semantics
            cx_sy_dynamic_osql_error INTO lx_dynamic_osql.

        out->write( lx_dynamic_osql->get_text(  ) ).
        RETURN.
    ENDTRY.

    IF sy-subrc EQ 0.
      out->write( lines( <lt_itab> ) ).
      out->write( <lt_itab> ).
    ELSE.
      out->write( 'No data' ).
    ENDIF.

  ENDMETHOD.
ENDCLASS.
