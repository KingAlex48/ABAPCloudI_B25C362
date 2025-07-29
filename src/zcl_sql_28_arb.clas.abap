CLASS zcl_sql_28_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_28_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DATA lr_price TYPE RANGE OF /dmo/price.

    lr_price = VALUE #( ( sign   = 'I'  "I = INLCUYE, E = EXCLUYE
                          option = 'BT' "BETWENT
                          low    = 500
                          high   = 1500 ) ).

    APPEND VALUE #(      sign   = 'I'
                         option = 'EQ'
                         low    = '6629.00' )  TO lr_price.


    SELECT FROM zflight_arb
           FIELDS *
           WHERE price IN @lr_price
           AND currencycode EQ 'USD'
           INTO TABLE @DATA(lt_flights).


    IF sy-subrc EQ 0.
      out->write( lt_flights ).
    ENDIF.


  ENDMETHOD.
ENDCLASS.
