select nome,
    endereco
from Proprietários
where cidade = "Itatiba"
union
select nome,
    endereco
from Veterinários
where cidade = "Itatiba";