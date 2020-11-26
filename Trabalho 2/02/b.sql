select A.COD_AN,
    A.nome,
    V.CRMV,
    V.nome,
    C.data_hora,
    C.valor
from Consultas C
    inner join Animais A on C.COD_AN = A.COD_AN
    inner join Veterinários V on C.CRMV = V.CRMV
where C.data_hora < "2010-05-01";