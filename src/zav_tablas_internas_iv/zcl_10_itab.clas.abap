CLASS zcl_10_itab DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_10_itab IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


**********************************************************************FOR

*
*    TYPES:BEGIN OF lty_flights,
*            iduser     TYPE /dmo/customer_id,
*            aircode    TYPE /dmo/carrier_id,
*            flightnum  TYPE /dmo/connection_id,
*            key        TYPE land1,
*            seat       TYPE /dmo/plane_seats_occupied,
*            flightdate TYPE /dmo/flight_date,
*          END OF lty_flights.
*
*    DATA: gt_flights_info TYPE TABLE OF lty_flights,
*          gt_my_flights   TYPE TABLE OF lty_flights.
*
*
*    gt_my_flights = VALUE #( FOR i = 1 UNTIL i > 30 "Rellena la tabla hasta un valor dado.
*                            ( iduser      = | { 123456 +  i } - USER|
*                              aircode     = 'LH'
*                              flightnum   = 0001 + i
*                              key         = 'US'
*                              seat        = 0 + i
*                              flightdate  = cl_abap_context_info=>get_system_date(  ) + i  ) ).

*    gt_flights_info = VALUE #( FOR i = 1 WHILE i <= 20
*                    ( iduser      = | { 123456 +  i } - USER|
*                      aircode     = 'LH'
*                      flightnum   = 0001 + i
*                      key         = 'US'
*                      seat        = 0 + i
*                      flightdate  = cl_abap_context_info=>get_system_date(  ) + i  ) ).

*
*    gt_flights_info = VALUE #( FOR gs_my_flight IN gt_my_flights "Pasa datos de un itab a otro creando la estructura de destino directamente después del FOR.
*                      WHERE ( aircode = 'LH' AND flightnum GT  0012 )
*                      ( iduser      = gs_my_flight-iduser
*                        aircode     = gs_my_flight-aircode
*                        flightnum   = gs_my_flight-flightnum
*                        key         = gs_my_flight-key
*                        seat        = gs_my_flight-seat
*                        flightdate  = gs_my_flight-flightdate  ) ).
*
*    out->write( data = gt_my_flights name = 'gt_my_flights' ).
*    out->write( |\n| ).
*    out->write( data = gt_flights_info name = 'gt_flights_info' ).

********************************************************************** FOR NESTED
*
*    TYPES:BEGIN OF lty_flights,
*            aircode     TYPE /dmo/carrier_id,
*            flightnum   TYPE /dmo/connection_id,
*            flightdate  TYPE /dmo/flight_date,
*            flightprice TYPE /dmo/flight_price,
*            currency    TYPE /dmo/currency_code,
*          END OF lty_flights.
*
*    SELECT FROM /dmo/flight
*    FIELDS *
*    INTO TABLE @DATA(gt_flights_type).
*
*    SELECT FROM /dmo/booking_m
*    FIELDS carrier_id, connection_id, flight_price, currency_code
*    INTO TABLE @DATA(gt_airline)
*    UP TO 20 ROWS.
*
*    DATA gt_final TYPE SORTED TABLE OF lty_flights WITH NON-UNIQUE KEY flightprice .
*
*    gt_final = VALUE #( FOR gs_flight_type IN gt_flights_type WHERE ( carrier_id EQ 'AA' )
*                         FOR gs_airline IN gt_airline WHERE ( carrier_id = gs_flight_type-carrier_id )
*                          (  aircode    = gs_flight_type-carrier_id
*                            flightnum   = gs_flight_type-connection_id
*                            flightdate  = gs_flight_type-flight_date
*                            flightprice = gs_airline-flight_price
*                            currency    =  gs_airline-currency_code  ) ).
*
*    out->write( data =  gt_final name = 'gt_final' ).
*

**********************************************************************SELECT

    DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.

    SELECT FROM /dmo/flight
    FIELDS *
    WHERE carrier_id EQ 'LH'
    INTO TABLE @gt_flights.

*    SELECT carrier_id,connection_id, flight_date
*    FROM @gt_flights AS gt
*    INTO TABLE @DATA(gt_flights_copy).
*
*    out->write( data = gt_flights_copy name = 'gt_flights_copy' ).

**********************************************************************SORT (ORDENAR REGISTROS)

*    SORT gt_flights_copy.
*    out->write( data = gt_flights_copy name = 'gt_flights_copy' ).

*    SORT gt_flights DESCENDING. "Al ser una tabla estándar, se ordena por el campo clave de la DB.
*    out->write( data = gt_flights name = 'gt_flights' ).

*    SORT gt_flights_copy BY flight_date. "ordena por un campo en específico
*    out->write( data = gt_flights_copy name = 'gt_flights_copy_ascending' ).

*    SORT gt_flights_copy BY flight_date DESCENDING.
*    out->write( data = gt_flights_copy name = 'gt_flights_copy_descending' ).

*    SORT gt_flights_copy BY flight_date DESCENDING connection_id ASCENDING.
*    out->write( data = gt_flights_copy name = 'gt_flights_copy_mixed' ).
*


********************************************************************** MODIFY


*    SORT gt_flights DESCENDING.
*
*    out->write( data = gt_flights name = 'Before / gt_flights ' ).
*
*    LOOP AT gt_flights INTO DATA(gs_flights).
*
*      IF gs_flights-flight_date GT '20260101'.
*        gs_flights-flight_date = cl_abap_context_info=>get_system_date(  ).
*
**        MODIFY gt_flights FROM gs_flights INDEX 2.
*
**        MODIFY gt_flights FROM gs_flights TRANSPORTING flight_date. "Actualiza solo el campo indicado en este caso la fecha.
*
*        MODIFY gt_flights FROM VALUE #(  connection_id = '111' "SOLO MODIFICA LOS CAMPOS INDICADOS
*                                         carrier_id    = 'XX'
*                                         plane_type_id = 'YY' ) TRANSPORTING connection_id  "CON TRANSPORTING DEJA LOS DEMÁS CAMPOS CON SU VALOR, NO LOS INICIALIZA EN 000.
*                                                                              carrier_id
*                                                                              plane_type_id .
*      ENDIF.
*
*    ENDLOOP.
*
*    out->write( |\n| ).
*    out->write( data = gt_flights name = 'AFTER  gt_flights ' ).

**********************************************************************DELETE


    DATA: gt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
          gs_flights_struc TYPE /dmo/airport.

    SELECT FROM /dmo/airport
    FIELDS *
    WHERE country EQ 'US'
    INTO TABLE @gt_flights_struc.

    IF sy-subrc EQ 0.
      out->write( data = gt_flights_struc name = 'BEFORE gt_flights_struc ' ).

      LOOP AT gt_flights_struc INTO gs_flights_struc.

      ENDLOOP.


    ENDIF.






  ENDMETHOD.
ENDCLASS.
