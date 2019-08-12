
CREATE OR REPLACE PROCEDURE KARP.����������_������
  is 
    id_dob number;
    id_mest number;
    type_res nvarchar2(15);
    name_res nvarchar2(50);
    r_max number;
    r_nw number;
    cursor mr is
      SELECT �.��_������, �.��_�������������, �.���_�������, �.��������_������� FROM KARP.������_�������� �
          inner join KARP.�������������_�������� � on �.��_������������� = �.��_�������������
          inner join KARP.����_�������� � on �.��_������� = �.��_�������;
  begin
    open mr;
    loop
      fetch mr into id_dob, id_mest, type_res, name_res;
      SELECT �������������_����� - (������� + ��_�������) INTO r_max FROM KARP.����������_�������������
        WHERE ��_������������� = id_mest;
      if (r_max > 1) then
      begin
        case type_res
          when '��������'  then r_nw := round(dbms_random.value(1,50));
          when '��������'  then r_nw := round(dbms_random.value(1,2));
          when '��������������'  then r_nw := round(dbms_random.value(50,600));
          when '�������'  then r_nw := round(dbms_random.value(1,10));
          when '���������'  then r_nw := round(dbms_random.value(20,300));
          else  r_nw := round(dbms_random.value(5,100));
        end case;
        UPDATE KARP.������_�������� SET ������� = ������� + r_nw WHERE ��_������ = id_dob;
        dbms_output.put_line('�� ������������� ' || id_mest || ' ������ ' || r_nw || ' ' || name_res);
        end;
      else
        dbms_output.put_line('������������� ' || id_mest || ' ���������');
      end if;
      exit when mr%notfound;
    end loop;
    close mr;
end ����������_������;

SELECT FAILURE_COUNT FROM user_scheduler_jobs;

begin
DBMS_SCHEDULER.CREATE_JOB(job_name => 'job_upd', job_type => 'STORED_PROCEDURE', 
    job_action => 'KARP.����������_������;', enabled => true, start_date => SYSTIMESTAMP,
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

SELECT �.��������_�����������, sum(�.����������) �����_������� FROM KARP.����������� �
    inner join KARP.������� � on �.��_����������� = �.��_�����������
    inner join KARP.��������_������� � on �.��_������� = �.��_�������
    inner join KARP.������_������ � on �.��_����������_������� = �.��_�������
  GROUP BY �.��������_�����������;
