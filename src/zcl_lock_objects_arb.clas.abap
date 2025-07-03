CLASS zcl_lock_objects_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .

    CONSTANTS: c_payed     TYPE c LENGTH 1 VALUE 'P',
               c_unpayed   TYPE c LENGTH 1 VALUE 'U',
               c_overdue   TYPE c LENGTH 1 VALUE 'O',
               c_cancelled TYPE c LENGTH 1 VALUE 'C',
               c_posted    TYPE c LENGTH 1 VALUE 'X'.



  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_lock_objects_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.


    "Creación de la instancia

    out->write( |User has started the business process| ).


    TRY.
        DATA(lo_lock_object) = cl_abap_lock_object_factory=>get_instance(
          EXPORTING
            iv_name        = 'EZINV_LGL_ARB' ).

      CATCH cx_abap_lock_failure.

        out->write( |Lock Object Instance not created | ).
        RETURN. "Se sale del programa no tiene caso seguir

    ENDTRY.

    DATA lt_parameter TYPE if_abap_lock_object=>tt_parameter.

    lt_parameter = VALUE #( ( name = 'INVOICE_ID'
                              value = REF #( '100' ) ) "Conversión char a tipo generico

                              ( name = 'COMP'
                                value = REF #( '1010' ) ) ).


    "Solicitud de bloqueo

    TRY.
        lo_lock_object->enqueue( it_parameter  =   lt_parameter ).

      CATCH cx_abap_foreign_lock cx_abap_lock_failure.
        out->write( |Not possible to write on the database. Object is locked| ).
        RETURN.

    ENDTRY.

    out->write( |Lock Object is active| ).



    "Introduzco los registros en la tabla

    DATA ls_invoice TYPE zinvoice_lgl_arb.

    ls_invoice = VALUE #( invoice_id   = '100'
                          comp         = '1010'
                          customer     = 'Coca-Cola 3'
                          status       = c_payed
                          created_by   = cl_abap_context_info=>get_user_technical_name(  )
                          amount       =  '2500'
                          currency_key = 'USD' ).

*    wait up to 10 seconds.

    MODIFY zinvoice_lgl_arb FROM @ls_invoice.

    IF sy-subrc EQ 0.

      out->write( |Business Object was updated on the DDBB| ).

    ENDIF.



    " Solicitud de liberación del objeto

    TRY.
        lo_lock_object->dequeue( it_parameter  = lt_parameter ).
      CATCH cx_abap_lock_failure.
        out->write( |Lock Object was not released| ).
    ENDTRY.

    out->write( |Lock Object was released| ).




  ENDMETHOD.
ENDCLASS.
