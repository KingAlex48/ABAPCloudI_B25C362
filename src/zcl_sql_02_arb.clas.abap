CLASS zcl_sql_02_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_02_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

*CASE 1

    IF 1 = 2 .

      DELETE FROM zcarrier_arb.   "Just for demo purposes only

      DATA lt_ddbb TYPE STANDARD TABLE OF zcarrier_arb.

      SELECT FROM /DMO/I_Carrier
              FIELDS *
              WHERE CurrencyCode EQ 'USD'
              INTO TABLE @DATA(lt_airlines).

      IF sy-subrc EQ 0.

        lt_ddbb = CORRESPONDING #(  lt_airlines MAPPING carrier_id = AirlineID
                                                       currency_code = CurrencyCode ).
        INSERT zcarrier_arb FROM TABLE @lt_ddbb.

        IF sy-subrc EQ 0.
          out->write( |The number of inserted row is: { sy-dbcnt }| ).
        ENDIF.

      ENDIF.

    ENDIF.

*CASE 2

    DELETE FROM zcarrier_arb.   "Just for demo purposes only


    SELECT FROM /DMO/I_Carrier
            FIELDS AirlineID AS carrier_id,
                   Name,
                   CurrencyCode AS currency_code
*            WHERE CurrencyCode EQ 'USD'
            INTO CORRESPONDING FIELDS OF TABLE @lt_ddbb.

    IF sy-subrc EQ 0.


     INSERT zcarrier_arb FROM TABLE @lt_ddbb.

*     INSERT zcarrier_arb FROM TABLE @( VALUE #( (  carrier_id    = 'AA'
*                                                    name          = 'American Airlines'
*                                                    currency_code = 'USD' ) ) ).

      IF sy-subrc EQ 0.
        out->write( |The number of inserted row is: { sy-dbcnt }| ).
      ENDIF.

    ENDIF.



  ENDMETHOD.
ENDCLASS.
