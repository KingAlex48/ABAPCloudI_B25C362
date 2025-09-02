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

    ls_employee-id = 0001.
    ls_employee-first_name = 'Laura'.
    ls_employee-last_name = 'Martinez'.
    ls_employee-email = 'lauram@logali.com'.
    ls_employee-phone_number = '28512369'.
    ls_employee-salary = '2000.3' .
    ls_employee-currency_code = 'EUR'.

    INSERT ls_employee INTO TABLE lt_employees.




    ""INSERT VALUE

    INSERT VALUE #( id = 0002
                    first_name = 'Mario'
                    last_name = 'Martinez'
                    email = 'mariom@logali.com'
                    phone_number = '28512987'
                    salary = '2000.3'
                    currency_code = 'EUR'     ) INTO TABLE lt_employees.

    INSERT INITIAL LINE INTO TABLE lt_employees. "Inserta un registro en blanco.



    INSERT VALUE #(     id = 0003
                        first_name = 'Daniela'
                        last_name = 'Linares'
                        email = 'danielal@logali.com'
                        phone_number = '285123345'
                        salary = '3000'
                        currency_code = 'EUR'     ) INTO  lt_employees INDEX 2.



*    INSERT LINES OF lt_employees INTO TABLE lt_employees2. "Pasa los registros de una tabla a otra.
*    INSERT LINES OF lt_employees TO 1 INTO TABLE lt_employees2.
*    INSERT LINES OF lt_employees FROM 2 TO 3 INTO TABLE lt_employees2.

    out->write( data = lt_employees name = 'Employee Table' ).
    out->write( |\n| ).
    out->write( data = lt_employees2 name = 'Employee Table 2 ' ).



  ENDMETHOD.
ENDCLASS.
