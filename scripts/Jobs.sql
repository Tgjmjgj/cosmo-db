
CREATE OR REPLACE PROCEDURE KARP.ќбновление_добычи
  is 
    id_dob number;
    id_mest number;
    type_res nvarchar2(15);
    name_res nvarchar2(50);
    r_max number;
    r_nw number;
    cursor mr is
      SELECT д.ид_добычи, д.ид_месторождени€, б.тип_ресурса, б.название_ресурса FROM KARP.ƒобыча_ресурсов д
          inner join KARP.ћесторождени€_ресурсов м on д.ид_месторождени€ = м.ид_месторождени€
          inner join KARP.Ѕаза_ресурсов б on м.ид_ресурса = б.ид_ресурса;
  begin
    open mr;
    loop
      fetch mr into id_dob, id_mest, type_res, name_res;
      SELECT ѕотенциальный_запас - (продано + не_продано) INTO r_max FROM KARP.–азработка_месторождений
        WHERE ид_месторождени€ = id_mest;
      if (r_max > 1) then
      begin
        case type_res
          when 'акустика'  then r_nw := round(dbms_random.value(1,50));
          when 'реликви€'  then r_nw := round(dbms_random.value(1,2));
          when 'растительность'  then r_nw := round(dbms_random.value(50,600));
          when 'химикат'  then r_nw := round(dbms_random.value(1,10));
          when 'энергетик'  then r_nw := round(dbms_random.value(20,300));
          else  r_nw := round(dbms_random.value(5,100));
        end case;
        UPDATE KARP.ƒобыча_ресурсов SET наличие = наличие + r_nw WHERE ид_добычи = id_dob;
        dbms_output.put_line('»з месторождени€ ' || id_mest || ' добыто ' || r_nw || ' ' || name_res);
        end;
      else
        dbms_output.put_line('ћесторождение ' || id_mest || ' исчерпано');
      end if;
      exit when mr%notfound;
    end loop;
    close mr;
end ќбновление_добычи;

SELECT FAILURE_COUNT FROM user_scheduler_jobs;

begin
DBMS_SCHEDULER.CREATE_JOB(job_name => 'job_upd', job_type => 'STORED_PROCEDURE', 
    job_action => 'KARP.ќбновление_добычи;', enabled => true, start_date => SYSTIMESTAMP,
    repeat_interval => 'FREQ=DAILY; INTERVAL=1');
end;

begin
DBMS_SCHEDULER.ENABLE('job_upd');
end;

begin
DBMS_SCHEDULER.DROP_JOB('job_upd', true);
end;

begin
DBMS_SCHEDULER.RUN_JOB(job_name => 'job_upd');
end;

SELECT value FROM v$parameter WHERE UPPER(name) = 'JOB_QUEUE_PROCESSES';

SELECT г.название_государства, sum(з.количество) всего_куплено FROM KARP.√осударства г
    inner join KARP.ѕланеты п on п.ид_государства = г.ид_государства
    inner join KARP.“орговые_станции с on с.ид_планеты = п.ид_планеты
    inner join KARP.«аписи_сделок з on з.ид_покупающей_станции = с.ид_станции
  GROUP BY г.название_государства;
