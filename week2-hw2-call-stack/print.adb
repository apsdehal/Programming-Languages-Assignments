with Text_IO; use Text_IO;

procedure print is
  task t1 is
    entry go;
  end t1;

  task t2 is
    entry go;
  end t2;

  task body t1 is
  begin
    loop
      accept go do
        Put("one");
        New_Line;
      end go;
      t2.go;
    end loop;
  end t1;

  task body t2 is
  begin
    loop
      accept go do
        Put("two");
        New_Line;
      end go;
      t1.go;
    end loop;
  end t2;
begin
  t1.go;
end print;
