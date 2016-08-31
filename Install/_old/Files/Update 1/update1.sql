
<sql>ALTER TABLE REESTR ADD ISDEL SMALLINT</sql>

<sql>ALTER TABLE SUBSVALUE DROP CONSTRAINT R_5_SUBSVALUE</sql>

<sql>DROP INDEX XIF31SUBSVALUE</sql>

<sql>ALTER TABLE CONST ADD RENOVATION_ID INTEGER</sql>

<sql>ALTER TABLE DOC ADD RENOVATION_ID INTEGER</sql>

<sql>ALTER TABLE NOTARIALACTION ADD VIEWHEREDITARY SMALLINT</sql>

<sql>CREATE TABLE REMINDER(REMINDER_ID INTEGER NOT NULL,
TEXT VARCHAR(1000) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
PRIORITY INTEGER NOT NULL)</sql>

<sql>ALTER TABLE REMINDER ADD CONSTRAINT XPKREMINDER PRIMARY KEY (REMINDER_ID)</sql>

<sql>grant select, delete, insert, update on reminder to user_urdoc</sql>

<sql>CREATE GENERATOR SETREMINDER_ID</sql>

<sql>CREATE TRIGGER BI_SETREMINDER_ID FOR REMINDER
ACTIVE BEFORE INSERT POSITION 0 
AS
BEGIN
    new.reminder_id = gen_id(setreminder_id, 1);
END</sql>

<sql>ALTER TRIGGER BI_SETREMINDER_ID INACTIVE</sql> 

<sql>SET GENERATOR SETREMINDER_ID TO 103</sql> 

<sql>INSERT INTO REMINDER (REMINDER_ID,TEXT,PRIORITY) VALUES (100,'����� CINTEx ����������� �� ������: �������� ������������ �������, ��� 91, ���� �� �����',1)</sql>
<sql>INSERT INTO REMINDER (REMINDER_ID,TEXT,PRIORITY) VALUES (101,'� �� ������ ���, ���� ������ ������ F1, �� ��������� �������� ���������� ������ ���������� � ���������',2)</sql>
<sql>INSERT INTO REMINDER (REMINDER_ID,TEXT,PRIORITY) VALUES (102,'������� �������� ����� �����: 34-09-27, 60-39-50 ��� ������ (3912)',2)</sql>
<sql>INSERT INTO REMINDER (REMINDER_ID,TEXT,PRIORITY) VALUES (103,'���� ����� �������� ��� �������� ����',2)</sql>

<sql>ALTER TRIGGER BI_SETREMINDER_ID ACTIVE</sql>

<sql>CREATE TABLE RENOVATION(RENOVATION_ID INTEGER NOT NULL,
NAME VARCHAR(150) CHARACTER SET WIN1251 NOT NULL COLLATE PXW_CYRL,
INDATE DATE NOT NULL,
TEXT BLOB NOT NULL)</sql>

<sql>ALTER TABLE RENOVATION ADD CONSTRAINT XPKRENOVATION PRIMARY KEY (RENOVATION_ID)</sql>

<sql>grant select, delete, insert, update on renovation to user_urdoc</sql>

<sql>CREATE GENERATOR SETRENOVATION_ID</sql>

<sql>CREATE TRIGGER BI_SETRENOVATION_ID FOR RENOVATION
ACTIVE BEFORE INSERT POSITION 0 
AS
BEGIN
    new.renovation_id = gen_id(setrenovation_id, 1);
END
</sql>

<sql>ALTER TRIGGER BI_SETRENOVATION_ID INACTIVE</sql> 

<sql>SET GENERATOR SETRENOVATION_ID TO 100</sql> 

<sql>insert into renovation (RENOVATION_ID,NAME,INDATE,TEXT) values (100,'���������� �1','2003-07-18',
'	- ������� �������������� ���� � ������� ���������� ���������;
	- �������� �������� ������������ ���� ��������� ����� ������������ (����������� ���� + ��� ���� +/- �������� ��������� � ����);
	- ����������� ������������ ������� ����������� ��� ���� ��������� ����� ����;
	- ��� ��������� �������� ���������� ���� ��������� ������� ��������������� �������� �������� �����������;
	- ������ ����������� �������� ���������� ������ �� �������;
	- ���� ����� ������ ���������� ���� �����;
	- ��������� ������ ������� ���������� ������ �� �������
	- ��� �� ���������� ������ �������� ������������� �������� � ���������� ���������;
	- �������������� ������ ��� ������ �������������� ����� ���������
	- ����� ��������������� ���� ��� ���������� ����������, ���� �������� ������ ��� ���������� ��������� � ��������;
	- ������� ����� ��� ������ ����������
	- ��������� ����������� ��������� �� ������� ������ � ������������ ����������� � �� �������� (����� ������������ � �� ������ �����)
	- ������� �������� ������ �� ��������� �������� ���������� �� �������;
	- �������� ����� ������� ����� ����������� ������� ������� ����������, ��� �� ������� � ������;
	- ����������� ������� � ������� �������� ��������������� �������� ��������� ����� ��� ��������� ��� �������� ������ ������� ���������;
	- ��� ��������� �� ������� ���������, �� ��������
	- ������� ��������� ����� ��� ������� �������� � �� �������������� ������������
	- ��������� �������������� ������ � ������������ �����������
')</sql>

<sql>ALTER TRIGGER BI_SETRENOVATION_ID ACTIVE</sql>

<sql>alter table subs add priority smallint</sql>

<sql>alter table subsvalue add priority smallint</sql>

<sql>update subs set priority=1</sql>

<sql>update subsvalue set priority=1</sql>

<sql>ALTER TABLE CONST ADD CONSTRAINT CONST_R1 FOREIGN KEY (RENOVATION_ID) REFERENCES RENOVATION(RENOVATION_ID)</sql>

<sql>ALTER TABLE DOC ADD CONSTRAINT DOC_R1 FOREIGN KEY (RENOVATION_ID) REFERENCES RENOVATION(RENOVATION_ID)</sql>

<sql>ALTER TABLE SUBSVALUE ADD CONSTRAINT R_5_SUBSVALUE FOREIGN KEY (SUBS_ID) REFERENCES SUBS(SUBS_ID) ON UPDATE CASCADE</sql>

<sql>update doc set renovation_id=100</sql>

<sql>update const set renovation_id=100</sql>

<sql>SET STATISTICS INDEX XPKSUBS</sql>

<sql>SET STATISTICS INDEX XPKSUBSVALUE</sql>