\l : lister les bdd
\c nomBase : se connecter à la bdd nomBase
\dt : lister les tables de la bdd
\d nomTable: affichr la structure de nomTable
------------
 

select e.nom, e.embauche, s.nom, s.embauche from emp as e, emp as s where e.embauche < s.embauche and e.sup = s.noemp;
select emp.nom, serv.service from emp,serv where emp.noserv = serv.noserv;
select noserv from serv where noserv not in (select noserv from emp);

select prenom from emp where emploi='DIRECTEUR'
UNION
select prenom from emp where emploi='TECHNICIEN' and noserv = 1;



select distinct service from serv  INNER JOIN  emp on serv.noserv=emp.noserv;

select nom,prenom,ville from emp,serv where emp.noserv = serv.noserv and serv.ville='LILLE';

select nom,prenom from emp where sup in (select sup from emp where nom='DUBOIS') and nom !='DUBOIS';

select nom,prenom from emp where embauche in (select embauche from emp where embauche in (select embauche from emp where nom = 'DUMONT'));

select nom, embauche from emp where embauche in (select embauche from emp where embauche < (select embauche from emp where nom='MINET'));

select nom, prenom, embauche from emp where embauche < ( select min(embauche) from emp where noserv=6);

select nom,prenom,sal from emp where sal > (select min(sal) from emp where noserv=3) order by sal asc;

/* question 61 trop d'imbrications (3 IN) */
select nom,noserv,emploi,sal from emp where noserv in (select noserv from serv where ville in (select ville from serv where noserv in (select noserv from emp where nom='HAVET')));
/* Bonne  manière : */
select * from emp,serv where emp.noserv=serv.noserv and ville = (select ville from serv, emp where emp.noserv=serv.noserv and emp.nom='HAVET');

select nom,prenom,emploi from emp where emploi in (select emploi from emp where noserv=3);

select nom,prenom,emploi,sal from emp where emploi in (select emploi from emp where nom='CARON') and sal > (select sal from emp where nom='CARON');

-- q65
select nom,prenom from emp where emp.noserv=1 and emploi in (select distinct emploi from emp, serv where serv.service='VENTES');

-- q66
select nom,prenom from emp where noserv in (select noserv from serv where ville='LILLE') and emploi = (select emploi from emp where nom='RICHARD') order by nom;
select nom,prenom,ville from emp,serv where emp.noserv=serv.noserv and emp.noserv in (select noserv from serv where ville='LILLE') and emploi = (select emploi from emp where nom='RICHARD') order by nom;

-- q67
select nom,prenom,noserv,sal from emp as e where sal > (select avg(sal) from emp where e.noserv = noserv);

-- q68
select extract('Year' from  timestamp '2022-11-01');
select extract('Year' from  embauche);
select to_char(embauche, 'YYYY');

select to_char(embauche,'YYYY') from emp,serv where emp.noserv=serv.noserv and serv.service='VENTES';
select extract('Year' from embauche) from emp,serv where emp.noserv=serv.noserv and serv.service='VENTES';

select nom,prenom,service,embauche from emp,serv where emp.noserv = serv.noserv and serv.service='INFORMATIQUE' and to_char(embauche,'YYYY') in (select to_char(embauche,'YYYY') from emp,serv where emp.noserv=serv.noserv and serv.service='VENTES');


-- q69
select e.nom, e.noserv, e.sup, s.nom, s.noemp, s.noserv from emp as e, emp as s where e.sup = s.noemp and e.noserv != s.noserv;

-- q70
select distinct s.nom, s.prenom, s.sal, serv.service from emp as e, emp as s, serv where e.sup = s.noemp and s.noserv = serv.noserv order by sal desc;


-- q71
select nom, emploi, round(sal,2) as revenu from emp;

-- q72
select nom,sal,comm from emp where comm > sal*2;

-- q73
select nom, prenom, emploi, comm, sal, round(100*comm/(sal/12),2) as pctComm from emp where emploi='VENDEUR' ;

-- q74
select nom, emploi, service, round(sal + comm, 0) as revenu_annuel from emp,serv where emp.noserv=serv.noserv and emploi = 'VENDEUR';

-- q75
select nom, prenom, emploi, sal, comm, round((sal+coalesce(comm,0))/12,2) as revenu_mensuel from emp;

-- q76
select nom, prenom, emploi, sal as salaire, comm as commissions, round((sal+coalesce(comm,0))/12,2) as gain_mensuel from emp;

-- q77
select nom, prenom, emploi, round(sal,2) as salaire, comm as commissions, round((sal+coalesce(comm,0))/12,2) as "gain mensuel" from emp;

-- q78
select nom, emploi, round(sal/12/22,2) as "salaire journalier", round(sal/12/22/8,2) as "salaire horaire" from emp;

-- q79
-- ===================================================

-- q80
select concat(rpad(service, 15, '-'),'> ',ville) as "concat & rpad" from serv;

-- q81
select nom, emploi, position(substr(emploi,1,1) in 'PDCVT') as "code emploi" from emp;

-- q82
select case when noserv=1 then '*****' else nom end case, prenom, noserv from emp;

-- q83
 select substr(service,1,5) from serv;

 -- q84
 select * from emp where to_char(embauche, 'YYYY')='1988';

 -- q85
 select upper(nom), initcap(nom), lower(nom) from emp;

 -- q86
select nom, case when position('E' in nom)=0 then '' else to_char(position('E' in nom),'9') end case from emp;

 -- 87
 select service, length(service) as "nb de lettres" from serv;

 -- q88
 select nom, sal, rpad('', CAST(round(30*sal/(select max(sal) from emp)) as INTEGER), chr(219)) from emp order by sal desc;

-- q90
select nom, emploi, to_char(embauche, 'DD-MM-YY') as embauche from emp;

-- q91
select nom, emploi, to_char(embauche, 'fm day DD month YY') as embauche from emp;

-- q95
select nom, prenom, embauche, cast(now() as date), cast(now() as date) - embauche as "nb de jours" from emp;

-- q96
select nom, date_part('year',age(date'1986-06-26'))*12 + date_part('month', age(embauche)) as "nb de mois" from emp;

-- q97
select nom, prenom, age(embauche) from emp where cast(date_part('year', age(embauche)) as integer) < 30;

select nom, prenom, age(embauche) from emp where age(embauche) < interval '30 years';


-- q98
select nom, prenom, age(embauche) from emp where cast(date_part('year', age(embauche)) as integer) > 30;
select nom, prenom, age(embauche) from emp where age(embauche) > interval '30 years';



-- q99
select now() - date '1986-06-26';

-- q100
select date'1986-06-26' + interval '10000 days';



-- q102
select emploi, round(avg(sal),2) as "Salaire moyen" from emp group by emploi;


-- q103
select sum(sal) as "Somme salaires", sum(comm) as "Somme des comm" from emp where emploi='VENDEUR';

-- q104
select max(sal) as "Max", min(sal) as "Min", max(sal)-min(sal) as "Diff" from emp;


-- q105 pour chaque mois :
select date_part('month', embauche), count(*) from emp group by date_part('month', embauche);

-- q106
select service from serv where length(service) = (select min(length(service)) from serv);

-- q107
select nom, emploi, round(sal+coalesce(comm,0)/12,2) as "revenus mensuel" from emp where sal = (select max(sal) from emp);

-- q108
select count(*) from emp where noserv=3 and comm !=0;

-- q109
select count(distinct emploi) from emp where noserv=1;

-- q110
select count(*) from emp where noserv=3;


/*111 : Pour chaque service, afficher son N° et le salaire moyen des employés du service
arrondi l’euro près.*/
select service, (select round(avg(sal)) from emp where serv.noserv = emp.noserv group by noserv) from emp,serv group by serv.noserv;

/*112 : Pour chaque service donner le salaire annuel moyen de tous les employés qui ne
sont ni président, ni directeur.*/
select service, (select round(avg(sal)) from emp where serv.noserv = emp.noserv and emploi!='DIRECTEUR' and emploi!='PRESIDENT' group by noserv) from emp,serv group by serv.noserv;


/*113 : Grouper les employés par service et par emploi à l'intérieur de chaque service,
pour chaque groupe afficher l'effectif et le salaire moyen.*/
select noserv, count(*) as "effectif", round(avg(sal)) as "salaire moy." from emp group by noserv;
select emploi, count(*) as "effectif", round(avg(sal)) as "salaire moy." from emp group by emploi;


/*114 : Idem en remplaçant le numéro de service par le nom du service.*/
select service, count(*) as "effectif", round(avg(sal)) as "salaire moy." from emp,serv where emp.noserv = serv.noserv group by serv.service;


/*115 : Afficher l'emploi, l'effectif, le salaire moyen pour tout type d'emploi ayant plus
de deux représentants.*/
select emploi, count(*) as "effectif", round(avg(sal)) as "salaire moy." from emp group by emploi having count(*) > 1;

/* 116 : Sélectionner les services ayant au mois deux vendeurs.*/
select service from emp,serv where serv.noserv=emp.noserv and emploi='VENDEUR' group by service having count(*) > 1;

/*117 : Sélectionner les services ayant une commission moyenne supérieure au quart du
salaire moyen.*/
select service, round(avg(comm)) as "comm. moy." from emp,serv where serv.noserv=emp.noserv and emploi='VENDEUR' group by service having count(*) > 1 and round(avg(comm)) > (select avg(sal)/4 from emp);


/*118 : Sélectionner les emplois ayant un salaire moyen supérieur au salaire moyen des
directeurs.*/
select emploi from emp group by emploi having avg(sal) > (select avg(sal) from emp where emploi='DIRECTEUR');


/* 119 : Afficher, sur la même ligne, pour chaque service, le nombre d'employés ne
touchant pas de commission et le nombre d'employés touchant une commission.*/
select e. noserv, count(*) as "eff", (select count(*) from emp as f where e.noserv=f.noserv and comm is not null) as "avec comm", (select count(*) from emp as g where e.noserv=g.noserv and comm is null) as "sans comm" from emp as e group by noserv;

select count(case when comm is not null then 1 end) as "employés qui touchent une commission", count(case when comm is null then 1 end) as "employés sui touchent pas de commission", noserv from emp group by noserv;

/*120 : Afficher l'effectif, la moyenne et le total pour les salaires et les commissions par
emploi.*/
select emploi, count(*), round(avg(sal)) as "moy sal", sum(sal) as "sum sal", round(avg(comm)) as "avg com", sum(comm) as "sum com" from emp group by emploi;











