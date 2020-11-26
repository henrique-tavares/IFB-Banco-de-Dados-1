select A.nome
from Animais A
where not exists (
        select *
        from Veterinários
        where cidade = "Prinópolis"
            and CRMV not in (
                select CRMV
                from Consultas
                where Consultas.COD_AN = A.COD_AN
            )
    );