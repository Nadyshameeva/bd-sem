set transaction name 'create-schema';

create table institution
(
    id               int primary key,
    institution_type nvarchar2(20)  not null,
    name             nvarchar2(200) not null,
    polyclinic       int references institution (id),
    constraint institution_type_check check ( institution_type in ('поликлиника', 'больница') )
);

create table staff
(
    id                    int primary key,
    name                  nvarchar2(100) not null,
    surname               nvarchar2(200) not null,
    staff_type            char,
    rank                  nvarchar2(20),
    degree                nvarchar2(20),
    profile               nvarchar2(20),
    can_operate           char,
    operation_count       int,
    death_operation_count int,
    salary_coefficient    float,
    vacation              int,
    start_date            date,
    constraint staff_type_check check ( staff_type in ('m', 's') ),
    constraint can_operate_check check ( can_operate in ('t', 'f') )
);

create table staff_institution
(
    staff_id       int references staff (id),
    institution_id int references institution (id),
    primary key (staff_id, institution_id)
);

create table patient
(
    id         int primary key,
    name       nvarchar2(100) not null,
    surname    nvarchar2(200) not null,
    polyclinic int references institution (id)
);

create table patient_staff
(
    patient_id int references patient (id),
    staff_id   int references staff (id),
    primary key (patient_id, staff_id)
);

create table treatment
(
    id          int primary key,
    patient_id  int references patient (id) not null,
    diagnosis   nvarchar2(300)              not null,
    start_date  date,
    finish_date date
);

create table direction
(
    id              int primary key,
    name            nvarchar2(100),
    institution_id  int references institution (id),
    staff_id        int references staff (id),
    patient_id      int references patient (id),
    direction_date  date,
    expiration_date date
);

create sequence seq_institution start with 1;
create sequence seq_staff start with 1;
create sequence seq_patient start with 1;
create sequence seq_treatment start with 1;
create sequence seq_direction start with 1;

commit;