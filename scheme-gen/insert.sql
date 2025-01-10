set transaction name 'insertion-data';

insert into institution values (SEQ_INSTITUTION.nextval, 'поликлиника', 'Поликлиника №17 имени Оракла', null);
insert into institution values (SEQ_INSTITUTION.nextval, 'поликлиника', 'Поликлиника №28 имени Постгреса', null);

insert into institution values (SEQ_INSTITUTION.nextval, 'больница', 'Госпиталь джаваскриптеров', 1);
insert into institution values (SEQ_INSTITUTION.nextval, 'больница', 'Питонистический диспансер', 1);
insert into institution values (SEQ_INSTITUTION.nextval, 'больница', 'Клиническая больница №123 имени Матанализа', 2);
insert into institution values (SEQ_INSTITUTION.nextval, 'больница', 'Городская больница №0', 2);


insert into staff values (SEQ_STAFF.nextval, 'Вилли', 'Вонка', 's', null, null, 'Мед. сестра', 'f', null, null, 1.0, 14, to_date('2020-03-20', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Сергей', 'Николаев', 's', null, null, 'Мед. сестра', 'f', null, null, 1.0, 14, to_date('2020-03-20', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Вилли', 'Вонка', 's', null, null, 'Мед. сестра', 'f', null, null, 1.0, 14, to_date('2020-03-20', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Тамара', 'Карасева', 's', null, null, 'Санитар', 'f', null, null, 1.0, 14, to_date('2020-03-20', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Ольга', 'Алексеева', 's', null, null, 'Уборщик', 'f', null, null, 1.0, 14, to_date('2020-03-20', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Олег', 'Олегов', 'm', null, null, 'Терапевт', 'f', null, null, 1.0, 14, to_date('2013-01-12', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Иван', 'Иванов', 'm', 'доцент', 'кандидат', 'Терапевт', 'f', null, null, 1.0, 14, to_date('2013-02-13', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Иван', 'Кузнецов', 'm', 'доцент', 'кандидат', 'Невропатолог', 'f', null, null, 1.0, 14, to_date('2012-03-30', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Мария', 'Петрова', 'm', null, null, 'Окулист', 'f', null, null, 1.0, 14, to_date('2016-01-09', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Елена', 'Сидорова', 'm', null, null, 'Окулист', 'f', null, null, 1.0, 14, to_date('2017-01-09', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Игорь', 'Сидоров', 'm', 'доцент', 'кандидат', 'Хирург', 't', 12, 0, 1.2, 14, to_date('2015-02-13', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Андрей', 'Петров', 'm', 'доцент', 'кандидат', 'Хирург', 't', 124, 1, 1.2, 14, to_date('2013-02-13', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Сергей', 'Васильев', 'm', 'профессор', 'доктор', 'Хирург', 't', 38, 0, 1.0, 14, to_date('2014-02-13', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Мария', 'Петрова', 'm', 'профессор', 'доктор', 'Гинеколог', 't', 8, 2, 1.0, 14, to_date('2015-02-19', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Иван', 'Соколов', 'm', 'профессор', 'доктор', 'Гинеколог', 't', 23, 0, 1.0, 14, to_date('2018-04-27', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Андрей', 'Яковлев', 'm', 'профессор', 'доктор', 'Стоматолог', 't', 25, 0, 1.8, 14, to_date('2013-01-16', 'yyyy-mm-dd'));
insert into staff values (SEQ_STAFF.nextval, 'Яков', 'Яковлев', 'm', 'доцент', 'кандидат', 'Стоматолог', 't', 10, 1, 1.2, 14, to_date('2016-04-22', 'yyyy-mm-dd'));

insert into staff values (SEQ_STAFF.nextval, 'Павел', 'Михайлов', 'm', null, null, 'Рентгенолог', 'f', null, null, 2.5, 14, to_date('2014-04-27', 'yyyy-mm-dd'));


insert into staff_institution values (1, 1);
insert into staff_institution values (1, 2);
insert into staff_institution values (2, 3);
insert into staff_institution values (2, 4);
insert into staff_institution values (2, 5);
insert into staff_institution values (3, 4);
insert into staff_institution values (3, 6);
insert into staff_institution values (4, 1);
insert into staff_institution values (4, 2);
insert into staff_institution values (4, 3);
insert into staff_institution values (4, 4);
insert into staff_institution values (4, 5);
insert into staff_institution values (4, 6);
insert into staff_institution values (5, 1);
insert into staff_institution values (5, 2);
insert into staff_institution values (5, 3);
insert into staff_institution values (5, 4);
insert into staff_institution values (5, 5);
insert into staff_institution values (5, 6);

insert into staff_institution values (6, 1);
insert into staff_institution values (6, 2);
insert into staff_institution values (7, 1);
insert into staff_institution values (8, 1);
insert into staff_institution values (8, 2);
insert into staff_institution values (8, 3);
insert into staff_institution values (8, 4);
insert into staff_institution values (8, 5);
insert into staff_institution values (8, 6);

insert into staff_institution values (9, 1);
insert into staff_institution values (9, 2);
insert into staff_institution values (9, 6);
insert into staff_institution values (10, 2);
insert into staff_institution values (10, 3);
insert into staff_institution values (10, 4);
insert into staff_institution values (10, 5);
insert into staff_institution values (10, 6);

insert into staff_institution values (11, 1);
insert into staff_institution values (11, 3);
insert into staff_institution values (11, 4);
insert into staff_institution values (12, 2);
insert into staff_institution values (12, 4);
insert into staff_institution values (12, 5);
insert into staff_institution values (12, 6);
insert into staff_institution values (13, 3);
insert into staff_institution values (13, 4);
insert into staff_institution values (13, 5);
insert into staff_institution values (13, 6);

insert into staff_institution values (14, 1);
insert into staff_institution values (14, 3);
insert into staff_institution values (14, 4);
insert into staff_institution values (14, 6);
insert into staff_institution values (15, 2);
insert into staff_institution values (15, 5);
insert into staff_institution values (15, 6);

insert into staff_institution values (16, 1);
insert into staff_institution values (16, 3);
insert into staff_institution values (17, 1);
insert into staff_institution values (17, 2);
insert into staff_institution values (17, 3);
insert into staff_institution values (17, 4);
insert into staff_institution values (17, 5);
insert into staff_institution values (17, 6);

insert into staff_institution values (18, 1);
insert into staff_institution values (18, 2);


insert into PATIENT values (SEQ_PATIENT.nextval, 'Баклажан', 'Контерстрайк', 1);
insert into PATIENT values (SEQ_PATIENT.nextval, 'Базилик', 'Комбикорм', 1);
insert into PATIENT values (SEQ_PATIENT.nextval, 'Бандерлог', 'Камамбер', 1);

insert into PATIENT values (SEQ_PATIENT.nextval, 'Бадминтон', 'Коленвал', 2);
insert into PATIENT values (SEQ_PATIENT.nextval, 'Браденбург', 'Кандибобер', 2);
insert into PATIENT values (SEQ_PATIENT.nextval, 'Бергамот', 'Кабачок', 2);
insert into PATIENT values (SEQ_PATIENT.nextval, 'Барбарис', 'Данкешон', 2);


insert into patient_staff values (1, 6);
insert into patient_staff values (2, 7);
insert into patient_staff values (3, 7);
insert into patient_staff values (4, 6);
insert into patient_staff values (5, 6);
insert into patient_staff values (6, 6);
insert into patient_staff values (7, 6);

insert into patient_staff values (1, 8);
insert into patient_staff values (2, 8);
insert into patient_staff values (3, 8);
insert into patient_staff values (4, 8);
insert into patient_staff values (5, 8);
insert into patient_staff values (6, 8);
insert into patient_staff values (7, 8);

insert into patient_staff values (1, 9);
insert into patient_staff values (2, 9);
insert into patient_staff values (3, 10);
insert into patient_staff values (4, 10);
insert into patient_staff values (5, 10);
insert into patient_staff values (6, 10);
insert into patient_staff values (7, 10);

insert into patient_staff values (1, 11);
insert into patient_staff values (2, 11);
insert into patient_staff values (3, 11);
insert into patient_staff values (4, 12);
insert into patient_staff values (5, 12);
insert into patient_staff values (6, 12);
insert into patient_staff values (7, 12);

insert into patient_staff values (3, 14);
insert into patient_staff values (7, 15);

insert into patient_staff values (1, 17);
insert into patient_staff values (2, 16);
insert into patient_staff values (3, 16);
insert into patient_staff values (4, 17);
insert into patient_staff values (5, 17);
insert into patient_staff values (6, 17);
insert into patient_staff values (7, 17);


insert into treatment values (SEQ_TREATMENT.nextval, 1, 'ОРВИ', to_date('2024-05-12', 'yyyy-mm-dd'), to_date('2024-05-15', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 2, 'ОРВИ', to_date('2024-04-01', 'yyyy-mm-dd'), to_date('2024-04-11', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 3, 'ОРВИ', to_date('2022-02-20', 'yyyy-mm-dd'), to_date('2022-02-25', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 4, 'ОРВИ', to_date('2021-05-11', 'yyyy-mm-dd'), to_date('2021-05-17', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 5, 'ОРВИ', to_date('2023-03-15', 'yyyy-mm-dd'), to_date('2023-03-19', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 6, 'ОРВИ', to_date('2023-05-12', 'yyyy-mm-dd'), to_date('2023-05-21', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 7, 'ОРВИ', to_date('2022-05-08', 'yyyy-mm-dd'), to_date('2022-05-16', 'yyyy-mm-dd'));

insert into treatment values (SEQ_TREATMENT.nextval, 1, 'Панкреатит', to_date('2024-05-15', 'yyyy-mm-dd'), to_date('2024-05-22', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 2, 'Панкреатит', to_date('2021-11-21', 'yyyy-mm-dd'), to_date('2021-12-15', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 3, 'Панкреатит', to_date('2023-06-15', 'yyyy-mm-dd'), to_date('2023-07-02', 'yyyy-mm-dd'));
insert into treatment values (SEQ_TREATMENT.nextval, 4, 'Панкреатит', to_date('2022-10-15', 'yyyy-mm-dd'), to_date('2022-10-30', 'yyyy-mm-dd'));

insert into treatment values (SEQ_TREATMENT.nextval, 4, 'Аппендецит', to_date('2021-10-15', 'yyyy-mm-dd'), to_date('2021-11-01', 'yyyy-mm-dd'));


insert into direction values (SEQ_DIRECTION.nextval, 'Удаление аппендецита', 6, 12, 4, to_date('2021-10-15', 'yyyy-mm-dd'), null);
insert into direction values (SEQ_DIRECTION.nextval, 'Удаление зуба', 4, 16, 1, to_date('2021-11-15', 'yyyy-mm-dd'), null);
insert into direction values (SEQ_DIRECTION.nextval, 'Удаление аппендецита', 4, 11, 2, to_date('2021-11-15', 'yyyy-mm-dd'), null);

commit;