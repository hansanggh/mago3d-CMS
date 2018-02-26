drop table if exists menu cascade;

-- �޴�
create table menu(
	menu_id				smallint,
	name				varchar(100)							not null,
	name_en				varchar(30)								not null,
	lang				varchar(10)								default 'ko',
	parent				smallint								default '1',
	depth				smallint								default '1',
	view_order			smallint								default '1',
	url					varchar(100)							not null,
	image				varchar(256),
	image_alt			varchar(100),
	css_class			varchar(30),
	default_yn			char(1)									default 'N',
	use_yn				char(1)									default 'Y',
	description			varchar(256),
	insert_date				timestamp without time zone			default now(),
	constraint menu_pk primary key (menu_id)	
);


comment on table menu is '�޴�';
comment on column menu.menu_id is '������ȣ';
comment on column menu.name is '�޴���';
comment on column menu.name_en is '���� �޴���';
comment on column menu.lang is '���';
comment on column menu.parent is '�θ� ������ȣ';
comment on column menu.depth is '����';
comment on column menu.view_order is '���� ����';
comment on column menu.url is 'URL';
comment on column menu.image is '�̹���';
comment on column menu.image_alt is '�̹��� Alt';
comment on column menu.css_class is 'css class��';
comment on column menu.default_yn is '�⺻ ǥ�� �޴�, Y : �⺻, N : ����';
comment on column menu.use_yn is '�������, Y : ���, N : ������';
comment on column menu.description is '����';
comment on column menu.insert_date is '�����';