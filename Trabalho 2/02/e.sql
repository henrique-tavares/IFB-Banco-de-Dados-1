select nome
from Animais
    inner join Exames on Animais.COD_AN = Exames.COD_AN
group by nome
having sum(custo) == (
        select max(soma_custos)
        from (
                select sum(custo) soma_custos
                from Exames
                    inner join Animais on Exames.COD_AN = Animais.COD_AN
                group by Animais.nome
            )
    );