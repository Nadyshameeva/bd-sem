create
    or replace package log_management_pkg as

    -- просмотр
    procedure view_logs(
        p_start_time in date default null,
        p_end_time in date default null,
        p_action_type in varchar2 default null
    );

    -- отмена
    procedure revert_operation(
        p_log_id in number
    );

    -- отчет
    procedure generate_summary(
        p_order_by_entity_name in boolean,
        p_order_by_action_type in boolean,
        p_order_by_action_count in boolean
    );

end log_management_pkg;
/

create
    or replace package body log_management_pkg as

    procedure view_logs(
        p_start_time in date default null,
        p_end_time in date default null,
        p_action_type in varchar2 default null
    ) is
        cursor logs_cur
            is select log_id, entity_name, entity_id, action_type, action_date
               from action_log
               where (p_start_time is null or action_date >= p_start_time)
                 and (p_end_time is null or action_date <= p_end_time)
                 and (p_action_type is null or action_type = p_action_type);
        logs_record logs_cur%rowtype;
    begin
        dbms_output.put_line('log_id | entity_name | entity_id | action_type | action_date');
        for logs_record in logs_cur
            loop
                dbms_output.put_line(logs_record.LOG_ID || ' ' || logs_record.ENTITY_NAME || ' ' ||
                                     logs_record.ENTITY_ID || ' ' || logs_record.ACTION_TYPE || ' ' ||
                                     logs_record.ACTION_DATE);
            end loop;
    end;

    procedure revert_operation(
        p_log_id in number
    )
        is
        v_entity_name varchar2(30);
        v_action_type
                      varchar2(10);
        v_old_data
                      clob;
        v_new_data    clob;
        v_sql_stmt
                      varchar2(4000);
        json_data_old json_object_t;
        json_data_new json_object_t;
    begin
        select entity_name, action_type, old_data, new_data
        into v_entity_name, v_action_type, v_old_data, v_new_data
        from action_log
        where log_id = p_log_id;

        DBMS_OUTPUT.PUT_LINE('JSON OBJECT new = ' || v_new_data);
        DBMS_OUTPUT.PUT_LINE('JSON OBJECT old = ' || v_old_data);

        if v_old_data is not null then
            json_data_old := JSON_OBJECT_T.PARSE(v_old_data);
        end if;

        if v_new_data is not null then
            json_data_new := JSON_OBJECT_T.PARSE(v_new_data);
        end if;

        dbms_output.put_line('objects converted');

        if v_entity_name = 'direction' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where id = ' || json_data_new.get_Number('id');
            elsif v_action_type = 'update' then
                v_sql_stmt := 'update ' || v_entity_name || ' set name = ''' || json_data_old.get_string('name')
                    || ''', institution_id = ' || json_data_old.get_number('institution_id')
                    || ', staff_id = ' || json_data_old.get_number('staff_id')
                    || ', patient_id = ' || json_data_old.get_number('patient_id')
                    || ', direction_date = ' || json_data_old.get_date('direction_date')
                    || ', expiration_date = ' || json_data_old.get_date('expiration_date')
                    || ' where id = ' || json_data_old.get_Number('id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_old.get_number('id') || ', '''
                    || json_data_old.get_string('name') || ''', '
                    || json_data_old.get_number('institution_id') || ', '
                    || json_data_old.get_number('staff_id') || ', '
                    || json_data_old.get_number('patient_id') || ', '
                    || json_data_old.get_date('direction_date') || ', '
                    || json_data_old.get_date('expiration_date') || ')';
            end if;
        end if;

        if v_entity_name = 'institution' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where id = ' || json_data_new.get_Number('id');
            elsif v_action_type = 'update' then
                v_sql_stmt := 'update ' || v_entity_name || ' set name = ''' || json_data_old.get_string('name')
                    || ''', institution_type = ''' || json_data_old.get_string('institution_type')
                    || ''', polyclinic = ' || json_data_old.get_number('polyclinic')
                    || ' where id = ' || json_data_old.get_Number('id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_old.get_number('id') || ', '''
                    || json_data_old.get_string('institution_type') || ''', '''
                    || json_data_old.get_string('name') || ''', '
                    || json_data_old.get_number('polyclinic') || ')';
            end if;
        end if;

        if v_entity_name = 'patient' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where id = ' || json_data_new.get_Number('id');
            elsif v_action_type = 'update' then
                v_sql_stmt := 'update ' || v_entity_name || ' set name = ''' || json_data_old.get_string('name')
                    || ''', surname = ' || json_data_old.get_string('surname')
                    || ''', polyclinic = ' || json_data_old.get_number('polyclinic')
                    || ' where id = ' || json_data_old.get_Number('id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_old.get_number('id') || ', '''
                    || json_data_old.get_string('name') || ''', '''
                    || json_data_old.get_string('surname') || ''', '
                    || json_data_old.get_number('polyclinic') || ')';
            end if;
        end if;

        if v_entity_name = 'staff' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where id = ' || json_data_new.get_Number('id');
            elsif v_action_type = 'update' then
                v_sql_stmt := 'update ' || v_entity_name || ' set name = ''' || json_data_old.get_string('name')
                    || ''', surname = ''' || json_data_old.get_string('surname')
                    || ''', staff_type = ''' || json_data_old.get_string('staff_type')
                    || ''', rank = ''' || json_data_old.get_string('rank')
                    || ''', degree = ''' || json_data_old.get_string('degree')
                    || ''', profile = ''' || json_data_old.get_string('profile')
                    || ''', can_operate = ''' || json_data_old.get_string('can_operate')
                    || ''', operation_count = ' || json_data_old.get_number('operation_count')
                    || ', death_operation_count = ' || json_data_old.get_number('death_operation_count')
                    || ', salary_coefficient = ' || json_data_old.get_number('salary_coefficient')
                    || ', vacation = ' || json_data_old.get_number('vacation')
                    || ', start_date = ' || json_data_old.get_date('start_date')
                    || ' where id = ' || json_data_new.get_Number('id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_old.get_number('id') || ', '''
                    || json_data_old.get_string('name') || ''', '''
                    || json_data_old.get_string('surname') || ''', '''
                    || json_data_old.get_string('staff_type') || ''', '''
                    || json_data_old.get_string('rank') || ''', '''
                    || json_data_old.get_string('degree') || ''', '''
                    || json_data_old.get_string('profile') || ''', '''
                    || json_data_old.get_string('can_operate') || ''', '
                    || json_data_old.get_number('operation_count') || ', '
                    || json_data_old.get_number('death_operation_count') || ', '
                    || json_data_old.get_number('salary_coefficient') || ', '
                    || json_data_old.get_number('vacation') || ', '
                    || json_data_old.get_date('start_date') || ')';
            end if;
        end if;

        if v_entity_name = 'treatment' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where id = ' || json_data_new.get_Number('id');
            elsif v_action_type = 'update' then
                v_sql_stmt :=
                        'update ' || v_entity_name || ' set patient_id = ' || json_data_old.get_number('patient_id')
                            || ', diagnosis = ''' || json_data_old.get_string('diagnosis')
                            || ''', start_date = ' || json_data_old.get_number('start_date')
                            || ', finish_date = ' || json_data_old.get_number('finish_date')
                            || ' where id = ' || json_data_old.get_number('id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_old.get_number('id') || ', '
                    || json_data_old.get_number('patient_id') || ', '''
                    || json_data_old.get_string('diagnosis') || ''', '
                    || json_data_old.get_number('start_date') || ', '
                    || json_data_old.get_number('finish_date') || ')';
            end if;
        end if;

        if v_entity_name = 'patient_staff' then
            if v_action_type = 'insert' then
                v_sql_stmt := 'delete from ' || v_entity_name || ' where patient_id = ' ||
                              json_data_new.get_Number('patient_id')
                    || ' and staff_id = ' || json_data_new.get_Number('staff_id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_new.get_Number('patient_id') || ', '
                    || json_data_new.get_Number('staff_id') || ')';
            end if;
        end if;

        if v_entity_name = 'staff_institution' then
            if v_action_type = 'insert' then
                v_sql_stmt :=
                        'delete from ' || v_entity_name || ' where staff_id = ' || json_data_new.get_Number('staff_id')
                            || ' and institution_id = ' || json_data_new.get_number('institution_id');
            else
                v_sql_stmt := 'insert into ' || v_entity_name || ' values (' ||
                              json_data_new.get_Number('staff_id') || ', '
                    || json_data_new.get_number('institution_id') || ')';
            end if;
        end if;

        dbms_output.put_line(v_sql_stmt);

        execute immediate v_sql_stmt;
    end;

    procedure generate_summary(
        p_order_by_entity_name in boolean,
        p_order_by_action_type in boolean,
        p_order_by_action_count in boolean
    )
        is
        TYPE action_log_rec IS RECORD
                               (
                                   entity_name action_log.entity_name%TYPE,
                                   action_type action_log.action_type%TYPE,
                                   cnt         NUMBER
                               );
        TYPE action_log_cur IS REF CURSOR;
        cur_action_log action_log_cur;
        v_rec          action_log_rec;
        v_order_clause nvarchar2(500) := '';
        v_query        nvarchar2(500);

    begin
        if
            p_order_by_entity_name then
            v_order_clause := 'entity_name';
        end if;

        if
            p_order_by_action_type then
            if v_order_clause is not null then
                v_order_clause := v_order_clause || ', action_type';
            else
                v_order_clause := 'action_type';
            end if;
        end if;

        if
            p_order_by_action_count then
            if v_order_clause is not null then
                v_order_clause := v_order_clause || ', count(*)';
            else
                v_order_clause := 'count(*)';
            end if;
        end if;

        v_query := 'select entity_name, action_type, count(*)
                       from action_log
                       group by entity_name, action_type
                       order by ' || v_order_clause;

        dbms_output.put_line('v_query = ' || v_query);

        open cur_action_log for v_query;

        loop
            fetch cur_action_log into v_rec;
            exit when cur_action_log%notfound;
            dbms_output.put_line('Entity Name: ' || v_rec.entity_name ||
                                 ', Action Type: ' || v_rec.action_type ||
                                 ', Count: ' || v_rec.cnt);
        end loop;

        close cur_action_log;
    end;

end log_management_pkg;
/
