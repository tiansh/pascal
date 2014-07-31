unit filexist;
interface
  function Exist(Path:string):boolean;
implementation
uses Dos;
  function Exist(Path:string):boolean;
    var
      S: PathStr;
  begin
    S := FSearch(Path, GetEnv(''));
    Exist :=  S <> '';
  end;
end.
