
<sql>ALTER TRIGGER BI_SETRENOVATION_ID INACTIVE</sql> 

<sql>SET GENERATOR SETRENOVATION_ID TO 300</sql> 

<sql>insert into renovation (RENOVATION_ID,NAME,INDATE,TEXT) values (300,'���������� �3','2004-12-09',
'    - ������� ����� �������������� ���;
    - ������� ����������� ������� ������ ���������� ������� �� �������;
    - ��������� �������� �������� ��������� � ���������� �����������;
    - ��������� �������, ����������� �� ����������� ����� �� �������;
    - ������ �������� � ��������� ����� ����� � �������������� ������;
    - ���������� ������ ����������� ������ �� ���������;
')</sql>

<sql>ALTER TRIGGER BI_SETRENOVATION_ID ACTIVE</sql>

<sql>update doc set renovation_id=300</sql>

<sql>update const set renovation_id=300</sql>



