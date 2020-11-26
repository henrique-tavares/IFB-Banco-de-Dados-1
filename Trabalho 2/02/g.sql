delete from Animais
where COD_AN in (
        select A.COD_AN
        from Animais A
            inner join Proprietários P on A.COD_AN = P.COD_AN
        where P.nome = "Renato Sencão"
    );
delete from Propietários
where nome = "Renato Sencão";