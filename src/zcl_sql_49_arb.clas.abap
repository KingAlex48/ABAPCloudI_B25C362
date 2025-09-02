CLASS zcl_sql_49_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_SQL_49_ARB IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    DELETE FROM zdatasource_1.
    INSERT zdatasource_1 FROM TABLE @( VALUE  #( ( id        = 1
                                                 name1       = 'One'
                                                 datasource1 = 'Data Source 1')
                                               ( id          = 2
                                                 name1       = 'Two'
                                                 datasource1 = 'Data Source 1' )
                                                 ( id        = 3
                                                 name1       = 'Three'
                                                 datasource1 = 'Data Source 1' )
                                                 ( id        = 4
                                                 name1       = 'Four'
                                                 datasource1 = 'Data Source 1' )
                                                 ( id        = 5
                                                 name1       = 'Five'
                                                 datasource1 = 'Data Source 1' )  ) ).

    DELETE FROM zdatasource_2.
    INSERT zdatasource_2 FROM TABLE @( VALUE  #( ( id        = 2
                                                 name2       = 'Two'
                                                 datasource2 = 'Data Source 2')
                                               ( id          = 3
                                                 name2       = 'Three'
                                                 datasource2 = 'Data Source 2' )
                                                 ( id        = 6
                                                 name2       = 'Six'
                                                 datasource2 = 'Data Source 2' )
                                                 ( id        = 7
                                                 name2       = 'Seven'
                                                 datasource2 = 'Data Source 2' )
                                                 ( id        = 8
                                                 name2       = 'Eight'
                                                 datasource2 = 'Data Source 2' )  ) ).

    DELETE FROM zdatasource_3.
    INSERT zdatasource_3 FROM TABLE @( VALUE  #( ( id        = 3
                                                 name3       = 'Three'
                                                 datasource3 = 'Data Source 3')
                                               ( id          = 8
                                                 name3       = 'Eight'
                                                 datasource3 = 'Data Source 3' )
                                                 ( id        = 9
                                                 name3       = 'Nine'
                                                 datasource3 = 'Data Source 3' )
                                                 ( id        = 10
                                                 name3       = 'Ten'
                                                 datasource3 = 'Data Source 3' )
                                                 ( id        = 11
                                                 name3       = 'Eleven'
                                                 datasource3 = 'Data Source 3' )  ) ).



  ENDMETHOD.
ENDCLASS.
