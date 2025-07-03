CLASS zcl_inv_data_gen_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun.
    CONSTANTS: c_payed     TYPE c LENGTH 1 VALUE 'P',
               c_unpayed   TYPE c LENGTH 1 VALUE 'U',
               c_overdue   TYPE c LENGTH 1 VALUE 'O',
               c_cancelled TYPE c LENGTH 1 VALUE 'C',
               c_posted    TYPE c LENGTH 1 VALUE 'X'.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_inv_data_gen_arb IMPLEMENTATION.
  METHOD if_oo_adt_classrun~main.


    GET TIME STAMP FIELD DATA(lv_timestamp_begin).


    DELETE FROM zinvoice_lgl_arb . "Elimina todos los registros,usar con precaución.

    DO 100000 TIMES.
      MODIFY zinvoice_lgl_arb FROM TABLE @( VALUE #( ( invoice_id  =  sy-index
                                                      comp         = '1010'
                                                      customer     = 'Coca-Cola 2'
                                                      status       = c_payed
                                                      created_by   = cl_abap_context_info=>get_user_technical_name(  ) "Devuele los datos del usuario técnico
                                                      amount       = '1000'
                                                      currency_key = 'USD')

                                                    ( invoice_id   =  sy-index
                                                      comp         = '1020'
                                                      customer     = 'Pepsi 2'
                                                      status       = c_overdue
                                                      created_by   = cl_abap_context_info=>get_user_technical_name(  )
                                                      amount       = '2000'
                                                      currency_key = 'USD' )

                                                      ( invoice_id = sy-index
                                                      comp         = '1030'
                                                      customer     = 'Nestle 2'
                                                      status       = c_posted
                                                      created_by   = 'CB999999993'
                                                       amount      = '3000'
                                                      currency_key = 'EUR')

                                                      ( invoice_id = sy-index
                                                      comp         = '1040'
                                                      customer     = 'Pringles 2'
                                                      status       = c_payed
                                                      created_by   = 'CB999999993'
                                                       amount      = '4000'
                                                      currency_key = 'USD' )

                                                      ( invoice_id = sy-index
                                                      comp         = '1050'
                                                      customer     = 'Milka 2'
                                                      status       = c_cancelled
                                                      created_by   = 'CB999999993'
                                                       amount      = '5000'
                                                      currency_key = 'EUR' )
                                                      ) ).

    ENDDO.

    GET TIME STAMP FIELD DATA(lv_timestamp_end).

    DATA(lv_dif_sec) = cl_abap_tstmp=>subtract( "Diferencia entre dos tiempos
      EXPORTING
                         tstmp1 = lv_timestamp_end
                         tstmp2 = lv_timestamp_begin  ).

    out->write( |Total execution time: { lv_dif_sec }| ).


*      out->write( |{ sy-dbcnt } rows affected | ). "sy-dbcnt: VARIABLE DONDE LOS REGISROS DE LA DB HAN CAMBIADO








  ENDMETHOD.

ENDCLASS.
