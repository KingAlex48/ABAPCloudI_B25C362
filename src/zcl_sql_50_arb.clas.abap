CLASS zcl_sql_50_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_50_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM zdatasource_1 AS ds1
           INNER JOIN zdatasource_2 AS ds2 ON ds1~id EQ ds2~id
           FIELDS ds1~id ,
                  ds1~name1 AS name,
                  ds1~datasource1,
                  ds2~datasource2
           INTO TABLE @DATA(lt_results).


    IF sy-subrc EQ 0.
*      out->write( lt_results ).
    ENDIF.

    SELECT FROM (  (  /DMO/I_Flight AS Flight
           INNER JOIN /DMO/I_Connection AS Connection ON flight~AirlineID     EQ connection~AirlineID
                                                      AND flight~ConnectionID EQ connection~ConnectionID ) "Relaciona cada vuelo con su conexión
            INNER JOIN /DMO/I_Airport AS DepartureAirport   ON connection~DepartureAirport   = departureairport~AirportID " obtiene el nombre del aeropuerto de salida.
            INNER JOIN /DMO/I_Airport AS DestinationAirport ON connection~DestinationAirport = destinationairport~AirportID ) " obtiene el nombre del aeropuerto de destino.
            FIELDS flight~AirlineID,
                   flight~ConnectionID,
                   flight~FlightDate,
                   connection~DepartureAirport,
                   departureairport~Name AS DepartureName,
                   connection~DestinationAirport,
                   destinationairport~Name AS DestinationName,
                   flight~Price,
                   flight~CurrencyCode
            INTO TABLE @DATA(lt_flights).


    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ENDIF.




  ENDMETHOD.
ENDCLASS.
