select A.COD_AN,
    A.nome
from Animais A
where A.COD_AN not in (
        select E.COD_AN
        from Exames E
        where E.DATA >= "2010-01-01"
    );