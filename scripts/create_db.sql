CREATE TABLE KARP.Планетные_системы(
  ид_системы  number constraint пк_сист primary key,
  название  nvarchar2(50) default 'не названа' constraint ун_сист_назв unique,
  размер  number constraint нн_сист_размер not null,
  первооткрыватель nvarchar2(200) default 'не установлен'
);
CREATE TABLE KARP.Виды_небесных_тел(
  ид_вида number constraint пк_вид primary key,
  наименование nvarchar2(50) constraint нн_вид_имя not null,
  класс number(2) constraint пр_вид_класс check(класс between 1 and 20),
  характеристика  nvarchar2(400) default 'нет информации',
  constraint ун_вид_имя_класс unique(наименование, класс)
);
commit;
CREATE TABLE KARP.Планеты(
  ид_планеты number  constraint пк_план primary key,
  имя nvarchar2(50) constraint ун_план_имя unique,
  ид_основной_планеты number,
  ид_системы number constraint нн_план_сист not null,
  ид_вида number constraint нн_план_вид not null,
  ид_государства number,
  координаты nvarchar2(29) constraint пр_план_коорд 
      check(координаты like '%,%,%'),
  уровень_пригодности number(2) constraint пр_план_пригод 
      check(уровень_пригодности between 0 and 10),
  население number default 0,
  радиус  number constraint нн_план_рад not null,
  масса number constraint нн_план_м not null,
  период_вращения number(38,0) constraint нн_план_период not null,
  изображение blob,
  состояние nvarchar2(100) default 'не установлено', 
  constraint вк_план_осн
      foreign key(ид_основной_планеты) references KARP.Планеты(ид_планеты),
  constraint вк_план_сист
      foreign key(ид_системы) references KARP.Планетные_системы(ид_системы),
  constraint вк_план_вид
      foreign key(ид_вида) references KARP.Виды_небесных_тел(ид_вида)
);
commit;
CREATE TABLE KARP.Государства(
  ид_государства number constraint пк_гос primary key,
  название_государства nvarchar2(50) constraint нн_ун_гос_назв not null unique,
  процветание number(12,2) default 100500,
  ид_центра number,
  режим nvarchar2(50) default('анархия'),
  раса nvarchar2(50) not null,
  правитель nvarchar2(50) default('отсутствует'),
  constraint вк_гос_центр
      foreign key(ид_центра) references KARP.Планеты(ид_планеты)
);
commit;
ALTER TABLE KARP.Планеты ADD constraint вк_план_гос
    foreign key(ид_государства) references KARP.Государства(ид_государства);
commit;
CREATE TABLE KARP.Политика(
  ид_политики number constraint пк_полит primary key,
  ид_государства1 number constraint нн_полит_гос1 not null,
  ид_государства2 number constraint нн_полит_гос2 not null,
  отношения nvarchar2(12) constraint пр_полит_отн
      check(отношения in ('союз','нейтралитет','война')),
  constraint вк_полит_гос1
      foreign key(ид_государства1) references KARP.Государства(ид_государства),
  constraint вк_полит_гос2
      foreign key(ид_государства2) references KARP.Государства(ид_государства),
  constraint ун_полит_гос1_гос2 unique(ид_государства1, ид_государства2)
);
CREATE TABLE KARP.База_ресурсов(
  ид_ресурса  number constraint пк_база primary key,
  название_ресурса  nvarchar2(50) constraint нн_ун_база_назв not null unique,
  тип_ресурса nvarchar2(15) constraint пр_база_тип
      check(тип_ресурса in ('энергетик','газ','жидкость','металл','руда',
        'топливо','химикат','акустика','растительность','реликвия')),
  коэффициент_значимости number(2) constraint пр_база_знач
      check(коэффициент_значимости between 1 and 99),
  уровень_опасности number(2) constraint пр_база_опасн
      check(уровень_опасности between 0 and 10),
  описание nvarchar2(200) default('отсутствует')
);
CREATE TABLE KARP.Виды_кораблей(
  ид_класса_корабля number constraint пк_вид_кор primary key,
  стоимость_улучшения number constraint нн_вид_кор_ст not null,
  коэффициент_мощности  number(2) constraint пр_вид_кор_коэфф
      check(коэффициент_мощности between 1 and 99)
);
commit;
CREATE TABLE KARP.Корабли_перевозчики(
  ид_корабля number constraint пк_карв primary key,
  имя_корабля nvarchar2(50) constraint нн_ун_карв_имя not null unique,
  ид_класса_корабля number constraint нн_карв_класс not null,
  баланс  number constraint пр_карв_бал check(баланс >= 0),
  состояние_корабля nvarchar2(50) default 'работоспособен',
  размер_экипажа number(2) constraint пр_карв_экип 
    check(размер_экипажа > 0),
  дополнительная_информация nvarchar2(200) default 'нет',
  constraint вк_кор_класс foreign key(ид_класса_корабля)
      references KARP.Виды_кораблей(ид_класса_корабля)
);
CREATE TABLE KARP.Торговые_станции(
  ид_станции  number constraint пк_станц primary key,
  торговая_станция  nvarchar2(50) constraint нн_ун_станц_тс not null unique,
  состояние_станции nvarchar2(50) default 'в рабочем состоянии',
  ид_планеты number constraint нн_станц_план not null,
  constraint вк_станц_план
      foreign key(ид_планеты) references KARP.Планеты(ид_планеты)
);
commit;
CREATE TABLE KARP.Торговые_предложения(
  ид_предложения number constraint пк_предл primary key,
  ид_станции number constraint нн_предл_станц not null,
  ид_ресурса number constraint нн_предл_рес not null,
  покупка number default 0 constraint пр_предл_покуп 
    check(покупка >= 0),
  стоимость_покупки number default 0 constraint пр_предл_стоим_пк 
    check(стоимость_покупки > 0),
  constraint вк_предл_станц
      foreign key(ид_станции) references KARP.Торговые_станции(ид_станции),
  constraint вк_предл_рес
      foreign key(ид_ресурса) references KARP.База_ресурсов(ид_ресурса)
);
CREATE TABLE KARP.Месторождения_ресурсов(
  ид_месторождения number constraint пк_мест primary key,
  ид_ресурса number constraint нн_мест_рес not null,
  ид_планеты number constraint нн_мест_план not null,
  потенциальный_запас number(20) constraint нн_мест_зап not null,
  constraint вк_мест_рес
      foreign key(ид_ресурса) references KARP.База_ресурсов(ид_ресурса),
  constraint вк_мест_план
      foreign key(ид_планеты) references KARP.Планеты(ид_планеты)
);
CREATE TABLE KARP.Добывающие_поселения(
  ид_поселения  number constraint пк_посел primary key,
  ид_планеты  number constraint нн_посел_план not null,
  число_работников number constraint нн_посел_раб not null,
  информация nvarchar2(300) default 'отсутствует',
  constraint вк_посел_план
      foreign key(ид_планеты) references KARP.Планеты(ид_планеты)
);
commit;
CREATE TABLE KARP.Добыча_ресурсов(
  ид_добычи  number constraint пк_доб primary key,
  ид_месторождения number constraint нн_доб_мест not null,
  ид_поселения number constraint нн_доб_посел not null,
  наличие number(20) constraint пр_доб_нал check(наличие >= 0),
  constraint вк_доб_мест foreign key(ид_месторождения)
      references KARP.Месторождения_ресурсов(ид_месторождения),
  constraint вк_доб_посел foreign key(ид_поселения)
      references KARP.Добывающие_поселения(ид_поселения),
  constraint ун_доб_мест_посел unique(ид_месторождения, ид_поселения)
);
commit;
CREATE TABLE KARP.Записи_сделок(
  ид_сделки  number constraint пк_сделк primary key,
  ид_продающего_поселения number constraint нн_сделк_прод not null,
  ид_покупающей_станции number constraint нн_сделк_покуп not null,
  ид_корабля_перевозчика number constraint нн_сделк_карв not null,
  ид_ресурса number constraint нн_сделк_рес not null,
  количество number constraint нн_сделк_колв not null,
  стоимость number constraint нн_сделк_стоим not null,
  constraint вк_сделк_посел foreign key(ид_продающего_поселения)
      references KARP.Добывающие_поселения(ид_поселения),
  constraint вк_сделк_станц foreign key(ид_покупающей_станции)
      references KARP.Торговые_станции(ид_станции),
  constraint вк_сделк_карв foreign key(ид_корабля_перевозчика)
      references KARP.Корабли_перевозчики(ид_корабля),
  constraint вк_сделк_рес foreign key(ид_ресурса)
      references KARP.База_ресурсов(ид_ресурса)
);
commit;

/*
DROP TABLE KARP.Записи_сделок;
DROP TABLE KARP.Добыча_ресурсов;
DROP TABLE KARP.Добывающие_поселения;
DROP TABLE KARP.Месторождения_ресурсов;
DROP TABLE KARP.Торговые_предложения;
DROP TABLE KARP.Торговые_станции;
DROP TABLE KARP.Корабли_перевозчики;
DROP TABLE KARP.Виды_кораблей;
DROP TABLE KARP.База_ресурсов;
DROP TABLE KARP.Политика;
ALTER TABLE KARP.Планеты DROP constraint вк_план_гос;
DROP TABLE KARP.Государства;
DROP TABLE KARP.Планеты;
DROP TABLE KARP.Виды_небесных_тел;
DROP TABLE KARP.Планетные_системы;
*/