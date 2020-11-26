update Exames
set custo = custo * 0.95
where DATA >= "0217-05-01"
    and custo <= 50;
update Exames
set custo = custo * 0.93
where DATA >= "2017-05-01"
    and custo > 50;