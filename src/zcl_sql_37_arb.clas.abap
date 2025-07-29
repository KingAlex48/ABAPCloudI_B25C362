CLASS zcl_sql_37_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_37_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    SELECT FROM /dmo/i_flight
              FIELDS AirlineID,
                     ConnectionID,
                     FlightDate,
                     Price,
                     CurrencyCode
              WHERE FlightDate BETWEEN '20240101' AND '20301231'
              ORDER BY Flightdate DESCENDING "ASCENDING
              INTO TABLE @DATA(lt_results).

    IF sy-subrc EQ 0.
*      out->write( lt_results ).
    ENDIF.
**********************************************************************

    SELECT FROM /dmo/i_flight
           FIELDS AirlineID,
                  ConnectionID,
                  FlightDate,
                  Price,
                  CurrencyCode
           WHERE FlightDate BETWEEN '20240101' AND '20301231'
           ORDER BY PRIMARY KEY "Ordena de manera descendente por defecto
           INTO TABLE @lt_results.

    IF sy-subrc EQ 0.
      out->write( lt_results ).
    ENDIF.

**********************************************************************

**************ORDER OF EXECUTION******
*1.FROM
*2.WHERE
*3.GROUP BY
*4.HAVING
*5.SELECT
*6 ORDER BY
*7. UP TO (LIMIT)

    SELECT FROM /dmo/i_flight
              FIELDS AirlineID,
                     MIN( Price ) AS MinPrice
              WHERE PlaneType EQ '767-200'
              GROUP BY AirlineID, CurrencyCode HAVING CurrencyCode IN (  'USD', 'EUR'  )
              ORDER BY AirlineID ASCENDING
              INTO TABLE @DATA(lt_flights)
              UP TO 3 ROWS.


    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ENDIF.

********************************************************************** SELECT SINGLE
    SELECT SINGLE FROM /dmo/i_flight
           FIELDS *
           "ODER BY
           INTO @DATA(ls_result_single).




  ENDMETHOD.
ENDCLASS.
