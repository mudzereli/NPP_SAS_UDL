/*
 * BLOCK
 * COMMENT
 */
 
*REGULAR COMMENT;

%*MACRO COMMENT;

%let a = 1;
%let b = 2;

DATA test;
    set table1(keep=FIELD1 FIELD2 rename=(FIELD3 = FIELD4));
    if FIELD1 = 1 then FIELD2 = "STRING1";
    else               FIELD2 = 'STRING2';
    if 5 + 2 + 3 = 10 then do;
        FIELD4 = input(compress("STRING3","STRING"),1.);
    end;
run;

PROC sql;
    create table test2 as
    select  *,
            case 
                when FIELD1 = 0 then "true"
                else                 'false'
            end as CATEGORY
    from    table1
    where  FIELD2 in ("CRITERIA1",'CRITERIA2')
    group by FIELD3
    order by FIELD4;
quit;


PROC export data=dataset1 outfile="/sas/data/output/sheet_&yyyymm..xls" replace;
    sheet="SHEET1";
run;


%macro macro1;
    %do i = 0 %to -1 %by -1;
        %macro_dates(0,n);
        DATA sub1;
            format ff1 $format1.;
            format ff2 yymmn6.;
            format ff3 year4.;
            set rel&yymm..table1(keep=f1 f2 f3 rename=(f1=ff1 f2=ff2 f3=ff3));
            rename ff3 ff1;
        run;
    %end;
%mend macro1;

%macro1;