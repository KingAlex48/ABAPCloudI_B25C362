CLASS zcl_sql_56_arb DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_amdp_marker_hdb .
    INTERFACES if_oo_adt_classrun .

    TYPES: BEGIN OF ty_structure,
             id          TYPE c LENGTH 2,
*             id2         TYPE c LENGTH 2,
             name        TYPE c LENGTH 10,
*             name2       TYPE c LENGTH 10,
             datasource1 TYPE c LENGTH 15,
             datasource2 TYPE c LENGTH 15,
           END OF ty_structure,
           ty_table TYPE TABLE OF ty_structure.


    CLASS-METHODS get_full_join AMDP OPTIONS CDS SESSION CLIENT DEPENDENT
      EXPORTING VALUE(et_results) TYPE ty_table.


  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS zcl_sql_56_arb IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.

    zcl_sql_56_arb=>get_full_join( IMPORTING et_results = DATA(lt_results) ).
    out->write( lt_results ).

  ENDMETHOD.

  METHOD get_full_join BY DATABASE PROCEDURE FOR HDB
                       LANGUAGE SQLSCRIPT
                       OPTIONS READ-ONLY
                       USING z_i_datasource1
                             z_i_datasource2.
** LENGUAJE SQL SQRIPT
    ET_RESULTS = SELECT coalesce( ds1.id, ds2.id )  as id,
                        coalesce( ds1.name1, ds2.name2 ) as name,
                        ds1.datasource1,
                        ds2.datasource2
                  from z_i_datasource1 as ds1
                  full outer join z_i_datasource2 as ds2 on ds1.id = ds2.id
                  where not ( ds1.datasource1 is not null and ds2.datasource2 is not null )
                  order by id;

**WHERE NOT (54) :SE excluye los valores y se convierte en un full other join exc inner join.

 ENDMETHOD.
ENDCLASS.
