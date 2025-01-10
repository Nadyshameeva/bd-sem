-- создание пакета для работы с сущностями
-- todo fix up patient procedures according to constraints
create
    or replace package healthcare_management as

    -- direction
    procedure add_direction(
        p_name in nvarchar2,
        p_institution_id in int,
        p_stuff_id in int,
        p_patient_id in int,
        p_direction_date in nvarchar2,
        p_expiration_date in nvarchar2
    );

    procedure update_direction(
        p_id in int,
        p_name in nvarchar2,
        p_institution_id in int,
        p_stuff_id in int,
        p_patient_id in int,
        p_direction_date in nvarchar2,
        p_expiration_date in nvarchar2
    );

    procedure delete_direction(
        p_id in int
    );

    -- процедуры для работы с таблицей institution
    procedure add_institution(
        p_institution_type in nvarchar2,
        p_name in nvarchar2,
        p_polyclinic in int
    );

    procedure update_institution(
        p_id in int,
        p_institution_type in nvarchar2,
        p_name in nvarchar2,
        p_polyclinic in int
    );

    procedure delete_institution(
        p_id in int
    );

    procedure delete_polyclinic(
        p_polyclinic_id in int
    );


    -- процедуры для работы с таблицей staff
    procedure add_staff(
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_staff_type in char,
        p_rank in nvarchar2,
        p_degree in nvarchar2,
        p_profile in nvarchar2,
        p_can_operate in char,
        p_operation_count in int,
        p_death_operation_count in int,
        p_salary_coefficient in float,
        p_vacation in int,
        p_start_date in nvarchar2
    );

    procedure update_staff(
        p_id in int,
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_staff_type in char,
        p_rank in nvarchar2,
        p_degree in nvarchar2,
        p_profile in nvarchar2,
        p_can_operate in char,
        p_operation_count in int,
        p_death_operation_count in int,
        p_salary_coefficient in float,
        p_vacation in int,
        p_start_date in nvarchar2
    );

    procedure delete_staff(
        p_id in int
    );

    -- процедуры для работы с таблицей patient
    procedure add_patient(
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_polyclinic in int
    );

    procedure update_patient(
        p_id in int,
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_polyclinic in int
    );

    procedure delete_patient(
        p_id in int
    );

    procedure clear_polyclinic(
        p_polyclinic_id in int
    );


    -- процедуры для работы с таблицей treatment
    procedure add_treatment(
        p_patient_id in int,
        p_diagnosis in nvarchar2,
        p_start_date in nvarchar2,
        p_finish_date in nvarchar2
    );

    procedure update_treatment(
        p_id in int,
        p_patient_id in int,
        p_diagnosis in nvarchar2,
        p_start_date in nvarchar2,
        p_finish_date in nvarchar2
    );

    procedure delete_treatment(
        p_id in int
    );


    -- patient-stuff
    procedure add_patient_to_stuff(
        p_patient_id in int,
        p_stuff_id in int
    );

    procedure delete_patient_from_stuff(
        p_patient_id in int,
        p_stuff_id in int
    );

    procedure delete_patient_from_all_stuff(
        p_patient_id in int
    );

    procedure delete_stuff_from_all_patients(
        p_stuff_id in int
    );


    -- stuff-institution
    procedure add_stuff_to_institution(
        p_stuff_id in int,
        p_institution_id in int
    );

    procedure delete_stuff_from_institution(
        p_stuff_id in int,
        p_institution_id in int
    );

    procedure delete_stuff_from_all_institutions(
        p_stuff_id in int
    );

    procedure delete_institution_from_all_stuff(
        p_institution_id in int
    );

end healthcare_management;
/

-- реализация пакета
create
    or replace package body healthcare_management as

    -- direction
    procedure add_direction(
        p_name in nvarchar2,
        p_institution_id in int,
        p_stuff_id in int,
        p_patient_id in int,
        p_direction_date in nvarchar2,
        p_expiration_date in nvarchar2
    )
        is
        v_last_id            int;
        v_patient_exists     int;
        v_stuff_exists       int;
        v_institution_exists int;
    begin
        select count(*)
        into v_institution_exists
        from institution
        where id = p_institution_id;

        select count(*)
        into v_stuff_exists
        from staff
        where id = p_stuff_id;

        select count(*)
        into v_patient_exists
        from patient
        where id = p_patient_id;

        if v_institution_exists = 0 then
            raise_application_error(-20004, 'Where is no institution with such id');
        end if;

        if v_stuff_exists = 0 then
            raise_application_error(-20004, 'Where is no stuff with such id');
        end if;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with such id');
        end if;

        select max(id) into v_last_id from direction;
        v_last_id := v_last_id + 1;

        insert into direction(id, name, institution_id, staff_id, patient_id, direction_date, expiration_date)
        values (v_last_id, p_name, p_institution_id, p_stuff_id, p_patient_id, to_date(p_direction_date, 'yyyy-mm-dd'),
                to_date(p_expiration_date, 'yyyy-mm-dd'));
    end;

    procedure update_direction(
        p_id in int,
        p_name in nvarchar2,
        p_institution_id in int,
        p_stuff_id in int,
        p_patient_id in int,
        p_direction_date in nvarchar2,
        p_expiration_date in nvarchar2
    )
        is
        v_direction_exists   int;
        v_patient_exists     int;
        v_stuff_exists       int;
        v_institution_exists int;
    begin
        select count(*)
        into v_direction_exists
        from direction
        where id = p_id;

        if v_direction_exists = 0 then
            raise_application_error(-20004, 'Where is no direction with such id');
        end if;

        select count(*)
        into v_institution_exists
        from institution
        where id = p_institution_id;

        select count(*)
        into v_stuff_exists
        from staff
        where id = p_stuff_id;

        select count(*)
        into v_patient_exists
        from patient
        where id = p_patient_id;

        if v_institution_exists = 0 then
            raise_application_error(-20004, 'Where is no institution with such id');
        end if;

        if v_stuff_exists = 0 then
            raise_application_error(-20004, 'Where is no stuff with such id');
        end if;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with such id');
        end if;

        update direction
        set name            = p_name,
            institution_id  = p_institution_id,
            staff_id        = p_stuff_id,
            patient_id      = p_patient_id,
            direction_date  = to_date(p_direction_date, 'yyyy-mm-dd'),
            expiration_date = to_date(p_expiration_date, 'yyyy-mm-dd')
        where id = p_id;
    end;

    procedure delete_direction(
        p_id in int
    )
        is
        v_direction_exists int;
    begin
        select count(*)
        into v_direction_exists
        from direction
        where id = p_id;

        if v_direction_exists = 0 then
            raise_application_error(-20004, 'Where is no direction with such id');
        end if;

        delete
        from direction
        where id = p_id;
    end;

    -- institution
    procedure add_institution(
        p_institution_type in nvarchar2,
        p_name in nvarchar2,
        p_polyclinic in int
    ) is
        v_last_id           int;
        v_polyclinic_exists int;
    begin
        select count(*)
        into v_polyclinic_exists
        from institution
        where id = p_polyclinic
          and institution_type = 'поликлиника';

        if v_polyclinic_exists = 0 and p_polyclinic is not null then
            raise_application_error(-20004, 'Where is no polyclinic with such id');
        end if;

        select max(id) into v_last_id from institution;
        v_last_id := v_last_id + 1;

        insert into institution (id, institution_type, name, polyclinic)
        values (v_last_id, p_institution_type, p_name, p_polyclinic);
    end add_institution;

    procedure update_institution(
        p_id in int,
        p_institution_type in nvarchar2,
        p_name in nvarchar2,
        p_polyclinic in int
    )
        is
        v_institution_exists int;
        v_polyclinic_exists  int;
    begin
        select count(*)
        into v_institution_exists
        from institution
        where id = p_id;

        if v_institution_exists = 0 then
            raise_application_error(-20004, 'Where is no institution with such id');
        end if;

        select count(*)
        into v_polyclinic_exists
        from institution
        where id = p_polyclinic
          and institution_type = 'поликлиника';

        if v_polyclinic_exists = 0 and p_polyclinic is not null then
            raise_application_error(-20004, 'Where is no polyclinic with such id');
        end if;

        update institution
        set institution_type = p_institution_type,
            name             = p_name,
            polyclinic       = p_polyclinic
        where id = p_id;
    end update_institution;

    procedure delete_institution(
        p_id in int
    )
        is
        v_institution_exists int;
    begin
        select count(*)
        into v_institution_exists
        from institution
        where id = p_id;

        if v_institution_exists = 0 then
            raise_application_error(-20004, 'Where is no institution with such id');
        end if;

        delete_institution_from_all_stuff(p_id);
        clear_polyclinic(p_id);
        delete_polyclinic(p_id);
        update direction set institution_id = null where institution_id = p_id;

        delete
        from institution
        where id = p_id;
    end delete_institution;

    procedure delete_polyclinic(
        p_polyclinic_id in int
    )
        is
    begin
        update institution set polyclinic = null where polyclinic = p_polyclinic_id;
    end;


    -- staff
    procedure add_staff(
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_staff_type in char,
        p_rank in nvarchar2,
        p_degree in nvarchar2,
        p_profile in nvarchar2,
        p_can_operate in char,
        p_operation_count in int,
        p_death_operation_count in int,
        p_salary_coefficient in float,
        p_vacation in int,
        p_start_date in nvarchar2
    )
        is
        v_last_id int;
    begin
        select max(id) into v_last_id from staff;
        v_last_id := v_last_id + 1;

        insert into staff (id, name, surname, staff_type, rank, degree, profile, can_operate, operation_count,
                           death_operation_count, salary_coefficient, vacation, start_date)
        values (v_last_id, p_name, p_surname, p_staff_type, p_rank, p_degree, p_profile, p_can_operate,
                p_operation_count, p_death_operation_count, p_salary_coefficient, p_vacation,
                to_date(p_start_date, 'yyyy-mm-dd'));
    end add_staff;

    procedure update_staff(
        p_id in int,
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_staff_type in char,
        p_rank in nvarchar2,
        p_degree in nvarchar2,
        p_profile in nvarchar2,
        p_can_operate in char,
        p_operation_count in int,
        p_death_operation_count in int,
        p_salary_coefficient in float,
        p_vacation in int,
        p_start_date in nvarchar2
    )
        is
        v_staff_exists int;
    begin
        select count(*)
        into v_staff_exists
        from staff
        where id = p_id;

        if v_staff_exists = 0 then
            raise_application_error(-20004, 'Where is no staff with such id');
        end if;

        update staff
        set name                  = p_name,
            surname               = p_surname,
            staff_type            = p_staff_type,
            rank                  = p_rank,
            degree                = p_degree,
            profile               = p_profile,
            can_operate           = p_can_operate,
            operation_count       = p_operation_count,
            death_operation_count = p_death_operation_count,
            salary_coefficient    = p_salary_coefficient,
            vacation              = p_vacation,
            start_date            = to_date(p_start_date, 'yyyy-mm-dd')
        where id = p_id;
    end update_staff;

    procedure delete_staff(
        p_id in int
    )
        is
        v_staff_exists int;
    begin
        select count(*)
        into v_staff_exists
        from staff
        where id = p_id;

        if v_staff_exists = 0 then
            raise_application_error(-20004, 'Where is no staff with such id');
        end if;

        delete_stuff_from_all_patients(p_id);
        delete_stuff_from_all_institutions(p_id);
        update direction set staff_id = null where staff_id = p_id;

        delete
        from staff
        where id = p_id;
    end delete_staff;

    -- patient
    procedure add_patient(
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_polyclinic in int
    )
        is
        v_last_id           int;
        v_polyclinic_exists int;
    begin
        select count(*) into v_polyclinic_exists from institution;

        if v_polyclinic_exists = 0 then
            raise_application_error(-20004, 'Where is no polyclinic with such id');
        end if;

        select max(id) into v_last_id from patient;
        v_last_id := v_last_id + 1;

        insert into patient (id, name, surname, polyclinic)
        values (v_last_id, p_name, p_surname, p_polyclinic);
    end add_patient;

    procedure update_patient(
        p_id in int,
        p_name in nvarchar2,
        p_surname in nvarchar2,
        p_polyclinic in int
    )
        is
        v_patient_exists    int;
        v_polyclinic_exists int;
    begin
        select count(*)
        into v_patient_exists
        from patient
        where id = p_id;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with such id');
        end if;

        select count(*)
        into v_polyclinic_exists
        from institution
        where id = p_polyclinic;

        if v_polyclinic_exists = 0 then
            raise_application_error(-20004, 'Where is no polyclinic with such id');
        end if;

        update patient
        set name       = p_name,
            surname    = p_surname,
            polyclinic = p_polyclinic
        where id = p_id;
    end update_patient;

    procedure delete_patient(
        p_id in int
    )
        is
        v_patient_exists int;
    begin
        select count(*)
        into v_patient_exists
        from patient
        where id = p_id;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with id');
        end if;

        delete_patient_from_all_stuff(p_id);
        delete from treatment where patient_id = p_id;
        delete from direction where patient_id = p_id;

        delete
        from patient
        where id = p_id;
    end delete_patient;

    procedure clear_polyclinic(
        p_polyclinic_id in int
    )
        is
    begin
        update patient set polyclinic = null where polyclinic = p_polyclinic_id;
    end;


    -- treatment
    procedure add_treatment(
        p_patient_id in int,
        p_diagnosis in nvarchar2,
        p_start_date in nvarchar2,
        p_finish_date in nvarchar2
    )
        is
        v_patient_exists int;
        v_last_id        int;
    begin
        select count(*)
        into v_patient_exists
        from patient
        where id = p_patient_id;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with such id');
        end if;

        select max(id) into v_last_id from treatment;
        v_last_id := v_last_id + 1;

        insert into treatment (id, patient_id, diagnosis, start_date, finish_date)
        values (v_last_id, p_patient_id, p_diagnosis, to_date(p_start_date, 'yyyy-mm-dd'),
                to_date(p_finish_date, 'yyyy-mm-dd'));
    end add_treatment;

    procedure update_treatment(
        p_id in int,
        p_patient_id in int,
        p_diagnosis in nvarchar2,
        p_start_date in nvarchar2,
        p_finish_date in nvarchar2
    )
        is
        v_treatment_exists int;
        v_patient_exists   int;
    begin
        select count(*)
        into v_treatment_exists
        from treatment
        where id = p_id;

        if v_treatment_exists = 0 then
            raise_application_error(-20004, 'Where is no treatment with such id');
        end if;

        select count(*)
        into v_patient_exists
        from patient
        where id = p_patient_id;

        if v_patient_exists = 0 then
            raise_application_error(-20004, 'Where is no patient with such id');
        end if;

        update treatment
        set patient_id  = p_patient_id,
            diagnosis   = p_diagnosis,
            start_date  = to_date(p_start_date, 'yyyy-mm-dd'),
            finish_date = to_date(p_finish_date, 'yyyy-mm-dd')
        where id = p_id;
    end update_treatment;

    procedure delete_treatment(
        p_id in int
    )
        is
        v_treatment_exists int;
    begin
        select count(*)
        into v_treatment_exists
        from treatment
        where id = p_id;

        if v_treatment_exists = 0 then
            raise_application_error(-20004, 'Where is no treatment with such id');
        end if;

        delete
        from treatment
        where id = p_id;
    end delete_treatment;


    -- patient-stuff
    procedure add_patient_to_stuff(
        p_patient_id in int,
        p_stuff_id in int
    )
        is
    begin
        insert into patient_staff (patient_id, staff_id)
        values (p_patient_id, p_stuff_id);
    end;

    procedure delete_patient_from_stuff(
        p_patient_id in int,
        p_stuff_id in int
    )
        is
    begin
        delete
        from patient_staff
        where patient_id = p_patient_id
          and staff_id = p_stuff_id;
    end;

    procedure delete_patient_from_all_stuff(
        p_patient_id in int
    )
        is
    begin
        delete
        from patient_staff
        where patient_id = p_patient_id;
    end;

    procedure delete_stuff_from_all_patients(
        p_stuff_id in int
    )
        is
    begin
        delete
        from patient_staff
        where staff_id = p_stuff_id;
    end;


    -- stuff-institution
    procedure add_stuff_to_institution(
        p_stuff_id in int,
        p_institution_id in int
    )
        is
    begin
        insert into staff_institution (staff_id, institution_id)
        values (p_stuff_id, p_institution_id);
    end;

    procedure delete_stuff_from_institution(
        p_stuff_id in int,
        p_institution_id in int
    )
        is
    begin
        delete
        from staff_institution
        where institution_id = p_institution_id
          and staff_id = p_stuff_id;
    end;

    procedure delete_stuff_from_all_institutions(
        p_stuff_id in int
    )
        is
    begin
        delete
        from staff_institution
        where staff_id = p_stuff_id;
    end;

    procedure delete_institution_from_all_stuff(
        p_institution_id in int
    )
        is
    begin
        delete
        from staff_institution
        where institution_id = p_institution_id;
    end;

end healthcare_management;
/
