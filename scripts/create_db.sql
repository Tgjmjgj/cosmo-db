CREATE TABLE KARP.���������_�������(
  ��_�������  number constraint ��_���� primary key,
  ��������  nvarchar2(50) default '�� �������' constraint ��_����_���� unique,
  ������  number constraint ��_����_������ not null,
  ���������������� nvarchar2(200) default '�� ����������'
);
CREATE TABLE KARP.����_��������_���(
  ��_���� number constraint ��_��� primary key,
  ������������ nvarchar2(50) constraint ��_���_��� not null,
  ����� number(2) constraint ��_���_����� check(����� between 1 and 20),
  ��������������  nvarchar2(400) default '��� ����������',
  constraint ��_���_���_����� unique(������������, �����)
);
commit;
CREATE TABLE KARP.�������(
  ��_������� number  constraint ��_���� primary key,
  ��� nvarchar2(50) constraint ��_����_��� unique,
  ��_��������_������� number,
  ��_������� number constraint ��_����_���� not null,
  ��_���� number constraint ��_����_��� not null,
  ��_����������� number,
  ���������� nvarchar2(29) constraint ��_����_����� 
      check(���������� like '%,%,%'),
  �������_����������� number(2) constraint ��_����_������ 
      check(�������_����������� between 0 and 10),
  ��������� number default 0,
  ������  number constraint ��_����_��� not null,
  ����� number constraint ��_����_� not null,
  ������_�������� number(38,0) constraint ��_����_������ not null,
  ����������� blob,
  ��������� nvarchar2(100) default '�� �����������', 
  constraint ��_����_���
      foreign key(��_��������_�������) references KARP.�������(��_�������),
  constraint ��_����_����
      foreign key(��_�������) references KARP.���������_�������(��_�������),
  constraint ��_����_���
      foreign key(��_����) references KARP.����_��������_���(��_����)
);
commit;
CREATE TABLE KARP.�����������(
  ��_����������� number constraint ��_��� primary key,
  ��������_����������� nvarchar2(50) constraint ��_��_���_���� not null unique,
  ����������� number(12,2) default 100500,
  ��_������ number,
  ����� nvarchar2(50) default('�������'),
  ���� nvarchar2(50) not null,
  ��������� nvarchar2(50) default('�����������'),
  constraint ��_���_�����
      foreign key(��_������) references KARP.�������(��_�������)
);
commit;
ALTER TABLE KARP.������� ADD constraint ��_����_���
    foreign key(��_�����������) references KARP.�����������(��_�����������);
commit;
CREATE TABLE KARP.��������(
  ��_�������� number constraint ��_����� primary key,
  ��_�����������1 number constraint ��_�����_���1 not null,
  ��_�����������2 number constraint ��_�����_���2 not null,
  ��������� nvarchar2(12) constraint ��_�����_���
      check(��������� in ('����','�����������','�����')),
  constraint ��_�����_���1
      foreign key(��_�����������1) references KARP.�����������(��_�����������),
  constraint ��_�����_���2
      foreign key(��_�����������2) references KARP.�����������(��_�����������),
  constraint ��_�����_���1_���2 unique(��_�����������1, ��_�����������2)
);
CREATE TABLE KARP.����_��������(
  ��_�������  number constraint ��_���� primary key,
  ��������_�������  nvarchar2(50) constraint ��_��_����_���� not null unique,
  ���_������� nvarchar2(15) constraint ��_����_���
      check(���_������� in ('���������','���','��������','������','����',
        '�������','�������','��������','��������������','��������')),
  �����������_���������� number(2) constraint ��_����_����
      check(�����������_���������� between 1 and 99),
  �������_��������� number(2) constraint ��_����_�����
      check(�������_��������� between 0 and 10),
  �������� nvarchar2(200) default('�����������')
);
CREATE TABLE KARP.����_��������(
  ��_������_������� number constraint ��_���_��� primary key,
  ���������_��������� number constraint ��_���_���_�� not null,
  �����������_��������  number(2) constraint ��_���_���_�����
      check(�����������_�������� between 1 and 99)
);
commit;
CREATE TABLE KARP.�������_�����������(
  ��_������� number constraint ��_���� primary key,
  ���_������� nvarchar2(50) constraint ��_��_����_��� not null unique,
  ��_������_������� number constraint ��_����_����� not null,
  ������  number constraint ��_����_��� check(������ >= 0),
  ���������_������� nvarchar2(50) default '��������������',
  ������_������� number(2) constraint ��_����_���� 
    check(������_������� > 0),
  ��������������_���������� nvarchar2(200) default '���',
  constraint ��_���_����� foreign key(��_������_�������)
      references KARP.����_��������(��_������_�������)
);
CREATE TABLE KARP.��������_�������(
  ��_�������  number constraint ��_����� primary key,
  ��������_�������  nvarchar2(50) constraint ��_��_�����_�� not null unique,
  ���������_������� nvarchar2(50) default '� ������� ���������',
  ��_������� number constraint ��_�����_���� not null,
  constraint ��_�����_����
      foreign key(��_�������) references KARP.�������(��_�������)
);
commit;
CREATE TABLE KARP.��������_�����������(
  ��_����������� number constraint ��_����� primary key,
  ��_������� number constraint ��_�����_����� not null,
  ��_������� number constraint ��_�����_��� not null,
  ������� number default 0 constraint ��_�����_����� 
    check(������� >= 0),
  ���������_������� number default 0 constraint ��_�����_�����_�� 
    check(���������_������� > 0),
  constraint ��_�����_�����
      foreign key(��_�������) references KARP.��������_�������(��_�������),
  constraint ��_�����_���
      foreign key(��_�������) references KARP.����_��������(��_�������)
);
CREATE TABLE KARP.�������������_��������(
  ��_������������� number constraint ��_���� primary key,
  ��_������� number constraint ��_����_��� not null,
  ��_������� number constraint ��_����_���� not null,
  �������������_����� number(20) constraint ��_����_��� not null,
  constraint ��_����_���
      foreign key(��_�������) references KARP.����_��������(��_�������),
  constraint ��_����_����
      foreign key(��_�������) references KARP.�������(��_�������)
);
CREATE TABLE KARP.����������_���������(
  ��_���������  number constraint ��_����� primary key,
  ��_�������  number constraint ��_�����_���� not null,
  �����_���������� number constraint ��_�����_��� not null,
  ���������� nvarchar2(300) default '�����������',
  constraint ��_�����_����
      foreign key(��_�������) references KARP.�������(��_�������)
);
commit;
CREATE TABLE KARP.������_��������(
  ��_������  number constraint ��_��� primary key,
  ��_������������� number constraint ��_���_���� not null,
  ��_��������� number constraint ��_���_����� not null,
  ������� number(20) constraint ��_���_��� check(������� >= 0),
  constraint ��_���_���� foreign key(��_�������������)
      references KARP.�������������_��������(��_�������������),
  constraint ��_���_����� foreign key(��_���������)
      references KARP.����������_���������(��_���������),
  constraint ��_���_����_����� unique(��_�������������, ��_���������)
);
commit;
CREATE TABLE KARP.������_������(
  ��_������  number constraint ��_����� primary key,
  ��_����������_��������� number constraint ��_�����_���� not null,
  ��_����������_������� number constraint ��_�����_����� not null,
  ��_�������_����������� number constraint ��_�����_���� not null,
  ��_������� number constraint ��_�����_��� not null,
  ���������� number constraint ��_�����_���� not null,
  ��������� number constraint ��_�����_����� not null,
  constraint ��_�����_����� foreign key(��_����������_���������)
      references KARP.����������_���������(��_���������),
  constraint ��_�����_����� foreign key(��_����������_�������)
      references KARP.��������_�������(��_�������),
  constraint ��_�����_���� foreign key(��_�������_�����������)
      references KARP.�������_�����������(��_�������),
  constraint ��_�����_��� foreign key(��_�������)
      references KARP.����_��������(��_�������)
);
commit;

/*
DROP TABLE KARP.������_������;
DROP TABLE KARP.������_��������;
DROP TABLE KARP.����������_���������;
DROP TABLE KARP.�������������_��������;
DROP TABLE KARP.��������_�����������;
DROP TABLE KARP.��������_�������;
DROP TABLE KARP.�������_�����������;
DROP TABLE KARP.����_��������;
DROP TABLE KARP.����_��������;
DROP TABLE KARP.��������;
ALTER TABLE KARP.������� DROP constraint ��_����_���;
DROP TABLE KARP.�����������;
DROP TABLE KARP.�������;
DROP TABLE KARP.����_��������_���;
DROP TABLE KARP.���������_�������;
*/