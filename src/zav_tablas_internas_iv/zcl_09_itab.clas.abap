CLASS zcl_09_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_09_itab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    "Standart Table
    DATA: lt_flight_stand  TYPE STANDARD TABLE OF /dmo/flight WITH EMPTY KEY,
          lt_flight_stand2 TYPE TABLE OF /dmo/flight.

    "Sorted Table
    DATA lt_flight_sort TYPE SORTED TABLE OF /dmo/flight WITH NON-UNIQUE KEY carrier_id.

    "Hashed Table

    DATA lt_flight_has TYPE HASHED TABLE OF /dmo/flight WITH UNIQUE KEY carrier_id.


**********************************************************************************************AÑADIR

*
*    DATA: lt_employees TYPE STANDARD TABLE OF zemploy_table,
*          ls_employee  TYPE zemploy_table.
*
*    TYPES lty_employee LIKE lt_employees.
*
*    lt_employees = VALUE #(    ( id = 0000
*                                 first_name = 'Mario'
*                                 last_name = 'Martínez'
*                                 email = 'mariom@logali.com'
*                                 phone_number = '1234567'
*                                 salary = '2000.3'
*                                 currency_code = 'EUR' )  ).
*
*    out->write( lt_employees ).
*
*
*    DATA(lt_employes2) = VALUE lty_employee( ( id = 0000
*                                             first_name = 'Mario'
*                                             last_name = 'Martínez'
*                                             email = 'mariom@logali.com'
*                                             phone_number = '1234567'
*                                             salary = '2000.3'
*                                             currency_code = 'EUR' )
*
*                                         (   id = 0001
*                                             first_name = 'Laura'
*                                             last_name = 'García'
*                                             email = 'lgarcia@logali.com'
*                                             phone_number = '2364568'
*                                             salary = '2000.3 '
*                                             currency_code = 'EUR' ) ).
*
*    out->write( lt_employes2 ).


**********************************************************************INSERT

    DATA: lt_employees TYPE STANDARD TABLE OF zemploy_table,
          ls_employee  TYPE zemploy_table.

    DATA lt_employees2 LIKE lt_employees.
*
*    ls_employee-id = 0001.
*    ls_employee-first_name = 'Laura'.
*    ls_employee-last_name = 'Martinez'.
*    ls_employee-email = 'lauram@logali.com'.
*    ls_employee-phone_number = '28512369'.
*    ls_employee-salary = '2000.3' .
*    ls_employee-currency_code = 'EUR'.
*
*    INSERT ls_employee INTO TABLE lt_employees.
*
*
*
*
*    ""INSERT VALUE
*
*    INSERT VALUE #( id = 0002
*                    first_name = 'Mario'
*                    last_name = 'Martinez'
*                    email = 'mariom@logali.com'
*                    phone_number = '28512987'
*                    salary = '2000.3'
*                    currency_code = 'EUR'     ) INTO TABLE lt_employees.
*
*    INSERT INITIAL LINE INTO TABLE lt_employees. "Inserta un registro en blanco.
*
*
*
*    INSERT VALUE #(     id = 0003
*                        first_name = 'Daniela'
*                        last_name = 'Linares'
*                        email = 'danielal@logali.com'
*                        phone_number = '285123345'
*                        salary = '3000'
*                        currency_code = 'EUR'     ) INTO  lt_employees INDEX 2.
*
*
*
**    INSERT LINES OF lt_employees INTO TABLE lt_employees2. "Pasa los registros de una tabla a otra.
**    INSERT LINES OF lt_employees TO 1 INTO TABLE lt_employees2.
**    INSERT LINES OF lt_employees FROM 2 TO 3 INTO TABLE lt_employees2.
*
*    out->write( data = lt_employees name = 'Employee Table' ).
*    out->write( |\n| ).
*    out->write( data = lt_employees2 name = 'Employee Table 2 ' ).



**************************************************************************APPEND


    "APPEND (NO APTO PARA TIPO HASHED  Y SORTED SOLO STANDAR)

*
*    ls_employee-id = 0003   .
*    ls_employee-first_name = 'Daniela'   .
*    ls_employee-last_name = 'Linares'     .
*    ls_employee-email = 'danielal@logali.com'  .
*    ls_employee-phone_number = '285123345' .
*    ls_employee-salary = '3000'  .
*    ls_employee-currency_code = 'EUR'    .
*
*    APPEND ls_employee TO lt_employees.
*
*    APPEND INITIAL LINE TO lt_employees.
*
*    APPEND VALUE #(      id = 0002
*                         first_name = 'Mario'
*                         last_name = 'Martinez'
*                         email = 'marioml@logali.com'
*                         phone_number = '385163345'
*                         salary = '2000'
*                         currency_code = 'EUR'         ) TO lt_employees.
*
*
*    out->write( data = lt_employees name = 'Employee Table' ).
*




**********************************************************************CORRESPONDING
*
*    TYPES: BEGIN OF lty_flights,
*             carrier     TYPE /dmo/carrier_id,
*             connection  TYPE /dmo/connection_id,
*             flight_date TYPE /dmo/flight_date,
*           END OF lty_flights.
*
*
*    DATA: gt_my_flights TYPE STANDARD TABLE OF lty_flights,
*          gs_my_flight  TYPE lty_flights.
*
*    SELECT FROM /dmo/flight
*           FIELDS *
*           WHERE currency_code EQ 'EUR'
*           INTO TABLE @DATA(gt_flights).


**********************************************************************

    "MOVE-CORRESPONDING gt_flights TO gt_my_flights. "Pasa la info de una tabla a otra

*    gt_my_flights = CORRESPONDING #( gt_flights ). "Nueva sintaxis

**********************************************************************

*    MOVE-CORRESPONDING gt_flights TO gt_my_flights KEEPING TARGET LINES. "Conserva los valores anteriores

*    gt_my_flights = CORRESPONDING #( BASE ( gt_my_flights ) gt_flights ). "Conserva valores anteriores, nueva sintaxis

**********************************************************************

*
*    gt_my_flights = CORRESPONDING #(  gt_flights MAPPING carrier = carrier_id connection = connection_id ).
*
*
*    out->write( data = gt_flights name = ` gt_flights  ` ).
*    out->write( |\n| ).
*    out->write( data = gt_my_flights name = ` gt_my_flights  ` ).
*




**********************************************************************READ TABLE

    "READ TABLE with INDEX

    SELECT FROM /dmo/airport
    FIELDS *
    WHERE country EQ 'DE'
    INTO TABLE @DATA(lt_flights).

*    IF sy-subrc EQ 0.

*      READ TABLE lt_flights INTO DATA(ls_flights) INDEX 1. "Trae el registro con el índice indicado
*      out->write( data = lt_flights name = ` lt_flights  ` ).
*      out->write( data = ls_flights name = ` ls_flights  ` ).
*
*      READ TABLE lt_flights INTO DATA(ls_flights2) INDEX 2 TRANSPORTING airport_id city. "TRAE EN ESPECÍFICO LOS CAMPOS QUE QUEREMOS
*      out->write( data = ls_flights2 name = ` lt_flights 2` ).
*
*      READ TABLE lt_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>) INDEX 3.
*      out->write( data = <lfs_flight> name = ` <lfs_flight> ` ).

*
*      DATA(ls_data) = lt_flights[ 2 ]. "Nueva sintaxis
*
*      out->write( data = ls_data name = ` ls_data  ` ).
*
*      DATA(ls_data2) = VALUE #( lt_flights[ 20 ] OPTIONAL ). "Si no encuentra ningun registro imprime solo el encabezado.
*      out->write( data = ls_data2 name =  ` ls_data2  ` ).
*
*      DATA(ls_data3) = VALUE #( lt_flights[ 20 ] DEFAULT lt_flights[ 1 ] ). "Si no encuentra el registro muestra un por defecto
*      out->write( data = ls_data3 name =  ` ls_data3  ` ).
*
*
*
*    ENDIF.
**
**********************************************************************READ TABLE WITH KEY

    "READ TABLE WITH KEY

*    SELECT FROM /dmo/airport
*           FIELDS *
*           INTO TABLE @DATA(lt_flights).
*
*    IF sy-subrc EQ 0.
*
*      READ TABLE lt_flights INTO DATA(ls_flight) WITH KEY city = 'Berlin'. "Trae el registro con la llave indicada
*      out->write( data = lt_flights name = ` lt_flights  ` ).
*      out->write( data = ls_flight name = ` ls_flight  ` ).
*
*      DATA(ls_flight2) = lt_flights[ airport_id = 'JFK' ]. "Read table nueva sintaxis
*      out->write( data = ls_flight2 name = ` ls_flight2  ` ).
*
*      DATA(lv_flight) = lt_flights[ airport_id = 'JFK' ]-name.
*      out->write( data = lv_flight name = ` lv_flight ` ).
*
*    ENDIF.
*
*    "READ TABLE WITH PRIMARY KEY
*
*    DATA gt_flights_sort TYPE SORTED TABLE OF /dmo/airport
*    WITH NON-UNIQUE KEY airport_id.
*
*    SELECT FROM /dmo/airport
*    FIELDS *
*    INTO TABLE @gt_flights_sort.
*
*    READ TABLE gt_flights_sort INTO DATA(ls_flight3) WITH TABLE KEY airport_id = 'LAS'.
*    out->write( data = gt_flights_sort name = ` gt_flights_sort ` ).
*    out->write( data = ls_flight3 name = ` ls_flight3 ` ).
*
*    DATA(ls_flight4) = gt_flights_sort[ KEY primary_key airport_id = 'LAS' ].
*    out->write( data = ls_flight4 name = ` ls_flight4 ` ).

**********************************************************************CHEQUEO DE REGISTROS


    "LINE EXISTS


    DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.

    SELECT FROM /dmo/flight
    FIELDS *
    WHERE carrier_id EQ 'LH'
    INTO TABLE @gt_flights.

*    IF sy-subrc EQ 0.

*        READ TABLE gt_flights WITH KEY connection_id = '0403' TRANSPORTING NO FIELDS. "se obtiene la respuesta de que si existe o no el registro
*
*        IF sy-subrc EQ 0.
*          out->write( 'The flight exists in the database' ).
*        ELSE.
*          out->write( 'The flight doesn´t exists in the database' ).
*        ENDIF.



*      IF line_exists( gt_flights[ connection_id = '0403' ] ). "NUEVA SINTAXIS
*        out->write( 'The flight exists in the database' ).
*      ELSE.
*        out->write( 'The flight doesn´t exists in the database' ).
*      ENDIF.
*
*    ENDIF.


**********************************************************************LINE INDEX

*    IF sy-subrc EQ 0.
*
*      READ TABLE gt_flights WITH KEY connection_id = '0401' TRANSPORTING NO FIELDS.
*      DATA(lv_index) = sy-tabix. "sy-tabix: guarda el índice de la fila encontrada en READ TABLE
*      out->write( data = gt_flights name = 'gt_flights' ).
*      out->write( data = lv_index name = 'INDEX: ' ).
*
*      "lines
*
*      DATA(lv_num) = lines( gt_flights ). "número de registro de una itab.
*      out->write( data = lv_num name = 'lv_num: ' ).
*
*
*
*    ENDIF.


**********************************************************************LOOP AT


*    DATA gs_flight TYPE /dmo/flight.
*
*    LOOP AT gt_flights INTO gs_flight.
*      out->write( data = gs_flight name = ' gs_flight' ).
*    ENDLOOP.
*
*
*    LOOP AT gt_flights INTO DATA(gs_flight2) WHERE connection_id = '0401'.
*      out->write( data = gs_flight2 name = ' gs_flight2' ).
*    ENDLOOP.
*
*    LOOP AT gt_flights ASSIGNING FIELD-SYMBOL(<lfs_flight>) FROM 3 TO 8.
*      <lfs_flight>-currency_code = 'COP'. "cambia la moneda de los registro del 3 al 8
**      out->write( data = <lfs_flight> name = '<lfs_flight>' ).
*    ENDLOOP.
*
*    out->write( data = gt_flights name = ' gt_flights' ).







  ENDMETHOD.
ENDCLASS.
