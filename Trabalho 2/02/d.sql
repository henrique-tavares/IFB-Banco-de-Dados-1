select V.CRMV,
    V.nome,
    sum(C.valor)
from Veterinários V
    inner join Consultas C on V.CRMV = C.CRMV
where C.data_hora >= "2010-05-01"
    and C.data_hora <= "2010-05-31"
group by V.CRMV,
    V.nome
having sum(C.valor) > 10000;