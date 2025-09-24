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

*    DATA: gt_flights TYPE STANDARD TABLE OF /dmo/flight.
*
*    SELECT FROM /dmo/flight
*    FIELDS *
*    WHERE carrier_id EQ 'LH'
*    INTO TABLE @gt_flights.

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


*    DATA: gt_flights_struc TYPE STANDARD TABLE OF /dmo/airport,
*          gs_flights_struc TYPE /dmo/airport.
*
*    SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country EQ 'US'
*    INTO TABLE @gt_flights_struc.
*
*    IF sy-subrc EQ 0.
*      out->write( data = gt_flights_struc name = 'BEFORE gt_flights_struc ' ).
*
*      LOOP AT gt_flights_struc INTO gs_flights_struc.
*
*        IF gs_flights_struc-airport_id = 'JFK' OR
*           gs_flights_struc-airport_id = 'BNA' OR
*           gs_flights_struc-airport_id = 'BOS' .
*
*          DELETE TABLE gt_flights_struc FROM gs_flights_struc.
*        ENDIF.
*
*      ENDLOOP.
*
*      DELETE gt_flights_struc INDEX 2.
*      DELETE gt_flights_struc FROM 5 TO 7 . "BORRA UN RANGO DE ÍNDICES
*      DELETE gt_flights_struc WHERE city IS INITIAL. "BORRA LOS CAMPOS DE CIUDAD VACÍOS.
*      DELETE ADJACENT DUPLICATES FROM gt_flights_struc COMPARING country."BORRA LOS VALORES REPETIDOS DEL CAMPO DADO.
*
*    ENDIF.
*    out->write( |\n| ).
*    out->write( data = gt_flights_struc name = 'AFTER gt_flights_struc ' ).
*

**********************************************************************CLEAR/FREE

*    DATA gt_flights_struc TYPE STANDARD TABLE OF /dmo/airport.
*
*
*    SELECT FROM /dmo/airport
*    FIELDS *
*    WHERE country EQ 'US'
*    INTO TABLE @gt_flights_struc.
*
*    out->write( data = gt_flights_struc name = 'BEFORE gt_flights_struc ' ).
*
*
*    IF sy-subrc EQ 0.

*      CLEAR gt_flights_struc. "LIMPIA LOS REGISTROS DE LA TABLA GUARDANDO EL ESPACIO EN MEMORIA
*
*      FREE gt_flights_struc. ""LIMPIA LOS REGISTROS DE LA TABLA ELIMINANDO ADEMÁS EL ESPACIO EN MEMORIA

*      gt_flights_struc = VALUE #(  ).

*    ENDIF.
*
*    out->write( |\n| ).
*    out->write( data = gt_flights_struc name = 'AFTER gt_flights_struc ' ).


**********************************************************************COLLECT

*    DATA: BEGIN OF ls_seats,
*            carrid TYPE /dmo/flight-carrier_id,
*            connid TYPE /dmo/flight-connection_id,
*            seats  TYPE /dmo/flight-seats_max,
*            price  TYPE /dmo/flight-price,
*          END OF ls_seats.
*
*    DATA gt_seats LIKE HASHED TABLE OF ls_seats WITH UNIQUE KEY carrid connid.
*
*    SELECT carrier_id, connection_id, seats_max, price
*           FROM /dmo/flight
*           INTO @ls_seats.
*
*      COLLECT ls_seats INTO gt_seats. "Inserta los registros a una itab excluyendo los repetidos. Para Tablas hashed y sorted
*
*    ENDSELECT.
*
*    out->write( data = gt_seats  name = 'gt_seats  ' ).


**********************************************************************LET

*    SELECT FROM  /dmo/flight
*    FIELDS *
*    WHERE currency_code EQ 'USD'
*    INTO TABLE @DATA(lt_flights).
*
*    SELECT FROM /dmo/booking_m
*    FIELDS *
*    INTO TABLE @DATA(lt_airline)
*    UP TO 50 ROWS.
*
*    " Recorremos la tabla de vuelos en USD
*    LOOP AT lt_flights INTO DATA(ls_fligh_let).
*
*      " Construimos un string con datos de aerolínea y vuelo
*      " usando LET para definir variables temporales dentro de la expresión
*
*      DATA(lv_flights) = CONV string( LET lv_airline     = lt_airline[ carrier_id = ls_fligh_let-carrier_id ]-travel_id   " Obtenemos travel_id de la tabla lt_airline
*                                          lv_fligh_price = lt_flights[ carrier_id = ls_fligh_let-carrier_id  " Obtenemos el precio desde lt_flights buscando por carrier_id + connection_id
*                                                                       connection_id = ls_fligh_let-connection_id ]-price
*                                           lv_carrid = lt_airline[ carrier_id = ls_fligh_let-carrier_id ]-carrier_id   " Obtenemos el carrier_id de la tabla lt_airline
*
*                                           IN | { lv_carrid } / Airline name: { lv_airline } / flight price: { lv_fligh_price } | ).   " Plantilla de string que inserta los valores de arriba
*
*      out->write( data = lv_flights  ).  " Mostramos el string construido en la salida
*
*    ENDLOOP.

**********************************************************************BASE

*    SELECT FROM  /dmo/flight
*       FIELDS *
*       WHERE currency_code EQ 'USD'
*       INTO TABLE @DATA(lt_flights).
*
*    out->write( data = lt_flights  name = 'INITIAL lt_flights  ' ).
*
*    DATA lt_seats TYPE TABLE OF /dmo/flight.
*
*
*    lt_seats =  VALUE #( BASE  lt_flights "crea una copia de la ITAB lt_flights y la asigna a lt_seats.
*                        ( carrier_id = 'CO'
*                          connection_id = '000123'
*                          flight_date = cl_abap_context_info=>get_system_date(  )
*                          price = '2000'
*                          currency_code = 'COP'
*                          plane_type_id = 'B213-58'
*                          seats_max = 120
*                          seats_occupied = 100  )  ).


*     lt_seats =  VALUE #( BASE  lt_seats ( LINES OF lt_flights ) "AGREGA LO QUE YA SE TIENE EN lt_seats + lt_flights
*
*                        ( carrier_id = 'PE'
*                          connection_id = '000123'
*                          flight_date = cl_abap_context_info=>get_system_date(  )
*                          price = '500'
*                          currency_code = 'USD'
*                          plane_type_id = 'B213-58'
*                          seats_max = 50
*                          seats_occupied = 10  )  ).

*
*    lt_seats = CORRESPONDING #( BASE ( lt_seats ) lt_flights ). "AGREGA LO QUE YA SE TIENE EN lt_seats + lt_flights
*
*    out->write( data = lt_seats name = ' lt_seats ' ).


**********************************************************************GROUP BY



    SELECT FROM /dmo/flight
    FIELDS *
    INTO TABLE @DATA(gt_dmo_flight).

    DATA gt_members LIKE gt_dmo_flight.

    "Grouping by column

    LOOP AT gt_dmo_flight ASSIGNING FIELD-SYMBOL(<lfs_dmo_fligh>)

*      GROUP BY <lfs_dmo_fligh>-carrier_id.

     GROUP BY ( airline = <lfs_dmo_fligh>-carrier_id  "AGRUPA POR AEROLÍNEA
                plane = <lfs_dmo_fligh>-plane_type_id ).  "Y POR PLANE TYPE ID

      CLEAR gt_members.

      LOOP AT GROUP <lfs_dmo_fligh> INTO DATA(gs_member).

        gt_members = VALUE #(  BASE gt_members ( gs_member ) ).

      ENDLOOP.

      out->write( data = gt_members name = ' gt_members ' ).

    ENDLOOP.














  ENDMETHOD.
ENDCLASS.
