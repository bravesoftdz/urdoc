
<sql>ALTER TRIGGER BI_SETRENOVATION_ID INACTIVE</sql> 

<sql>SET GENERATOR SETRENOVATION_ID TO 200</sql> 

<sql>insert into renovation (RENOVATION_ID,NAME,INDATE,TEXT) values (200,'���������� �2','2004-04-04',
'    - ���������� ������ ������������ ����� �� ���������;
    - ��������� ������� ����� �� ������������� �������� � �������������� ������;
    - ������� ����� ��� ������ ����������;
    - ���������� ������ �������� � �������� �������� � ������ ����������;
    - ������� �������� ������ ��������� � ������� (������ ����� ������������� �� ������ ���������);
    - ������� �������� ���������� ������ � �������;
    - ��������� ���������� ����� �� 999 ��� �������� ��������;
    - ������ ������ ���������, ����������� ������� �������������� �������� �� ������������ �����;
    - ��������� ����������� �������� ���� � ����������� ������;
    - ��������� ������� ������ �� ������ � ��������� ������������ (������������ ��������, �������������� ����, ����������� � �� ��������, ����������);
    - ���������� ������ ��� �������� �����;
    - ��������� ����������� ��������� ������� � ������ ����������;
    - ������� �������� �������� �������� ()
')</sql>

<sql>ALTER TRIGGER BI_SETRENOVATION_ID ACTIVE</sql>


<sql>update doc set renovation_id=200</sql>

<sql>update const set renovation_id=200</sql>

<sql>alter table reestr add words blob</sql>

<sql>
CREATE TABLE DOCLOCK (
    NUMREESTR INTEGER NOT NULL,
    YEARWORK INTEGER NOT NULL,
    TYPEREESTR_ID INTEGER NOT NULL
    );
</sql>


<sql>
grant select, delete, insert, update on doclock to user_urdoc
</sql>

<sql>
alter table doclock
add primary key (numreestr,yearwork,typereestr_id)
</sql>

<sql>
alter table doclock
add foreign key (typereestr_id) references typereestr (typereestr_id)
</sql>

<sql>
alter table doc
add sortnum integer
</sql>

<sql>
create table graphvisit
(
  graphvisit_id integer not null,
  who VARCHAR(150) NOT NULL COLLATE PXW_CYRL,
  dateaccept timestamp not null,
  dateservice timestamp
)
</sql>

<sql>
grant select, delete, insert, update on graphvisit to user_urdoc
</sql>

<sql>
alter table graphvisit
add primary key (graphvisit_id)
</sql>

<sql>
alter table graphvisit
add hint VARCHAR(250) NOT NULL COLLATE PXW_CYRL
</sql>

<sql>
CREATE GENERATOR setgraphvisit_ID;
</sql>
