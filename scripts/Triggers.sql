
CREATE OR REPLACE TRIGGER KARP.����������_��������
  AFTER INSERT OR UPDATE ON KARP.�������_�����������
  FOR EACH ROW
  declare
    pred number;
  begin
    SELECT ���������_��������� INTO pred FROM KARP.����_��������
      WHERE ��_������_������� = (:new.��_������_������� + 1);
    if (:new.������ > pred) then
      begin
        dbms_output.put_line('������� ' || :new.���_������� || ' ������� �� ������ ' || :new.��_������_�������);
        UPDATE KARP.�������_����������� SET ������ = ������ - pred,
          ��_������_������� = ��_������_������� + 1 WHERE ��_������� = :new.��_�������;
      end;
    end if;
    exception
      when no_data_found then
        dbms_output.put_line('������� ������������� ������');
end ����������_��������;
  
CREATE OR REPLACE TRIGGER KARP.������_�������
  AFTER UPDATE ON KARP.��������_�����������
  FOR EACH ROW
  begin
    if (:new.������� = 0) then
      begin
      dbms_output.put_line('�������� ����������� ' || :new.��_����������� || ' ���������');
      DELETE FROM KARP.��������_����������� WHERE ��_����������� = :new.��_�����������;
      end;
    end if;
end ������_�������;

