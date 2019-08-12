
CREATE OR REPLACE TRIGGER KARP.Обновление_кораблей
  AFTER INSERT OR UPDATE ON KARP.Корабли_перевозчики
  FOR EACH ROW
  declare
    pred number;
  begin
    SELECT стоимость_улучшения INTO pred FROM KARP.Виды_кораблей
      WHERE ид_класса_корабля = (:new.ид_класса_корабля + 1);
    if (:new.баланс > pred) then
      begin
        dbms_output.put_line('Корабль ' || :new.имя_корабля || ' улучшен до уровня ' || :new.ид_класса_корабля);
        UPDATE KARP.Корабли_перевозчики SET баланс = баланс - pred,
          ид_класса_корабля = ид_класса_корабля + 1 WHERE ид_корабля = :new.ид_корабля;
      end;
    end if;
    exception
      when no_data_found then
        dbms_output.put_line('Корабль максимального уровня');
end Обновление_кораблей;
  
CREATE OR REPLACE TRIGGER KARP.Уборка_заказов
  AFTER UPDATE ON KARP.Торговые_предложения
  FOR EACH ROW
  begin
    if (:new.покупка = 0) then
      begin
      dbms_output.put_line('Торговое предложение ' || :new.ид_предложения || ' завершено');
      DELETE FROM KARP.Торговые_предложения WHERE ид_предложения = :new.ид_предложения;
      end;
    end if;
end Уборка_заказов;

