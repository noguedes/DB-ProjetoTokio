CREATE TABLE tb_tok_ajuda_cliente (
    cd_chamada_ajuda  NUMBER GENERATED ALWAYS AS IDENTITY,description NUMBER(30),
    id_cliente       NUMBER(30) NOT NULL,
    tx_ajuda_cliente VARCHAR2(255) NOT NULL,
    ds_status        VARCHAR2(100) NOT NULL,
    id_corretor      number(30) not null
);

ALTER TABLE tb_tok_ajuda_cliente ADD CONSTRAINT tb_tok_ajuda_cliente_pk PRIMARY KEY ( cd_chamada_ajuda );

CREATE TABLE tb_tok_cliente (
    id_cliente           NUMBER GENERATED ALWAYS AS IDENTITY, description NUMBER(30),
    id_corretor          number(30) NOT NULL,
    nm_cliente           VARCHAR2(50) NOT NULL,
    nr_cpf_cliente       VARCHAR2(15) NOT NULL,
    dt_nasc_cliente      VARCHAR2(10) NOT NULL,
    ob_sexo_cliente      CHAR(1) NOT NULL,
    nr_rg_cliente        VARCHAR2(12) NOT NULL,
    nr_cep_cliente       VARCHAR2(11) NOT NULL,
    nr_tel_cliente       VARCHAR2(15) NOT NULL,
    ob_profissao_cliente VARCHAR2(100) NOT NULL,
    vl_renda_mensal      NUMBER(7, 2) NOT NULL,
    ob_email_cliente     VARCHAR2(100) NOT NULL,
    ds_senha_cliente     VARCHAR2(50) NOT NULL
);

COMMENT ON COLUMN tb_tok_cliente.nr_cpf_cliente IS
    'número de cpf unique ';

COMMENT ON COLUMN tb_tok_cliente.nr_rg_cliente IS
    'unique';

COMMENT ON COLUMN tb_tok_cliente.ob_email_cliente IS
    'unique';

ALTER TABLE tb_tok_cliente ADD CONSTRAINT tb_clientes_pk PRIMARY KEY ( id_cliente );

CREATE TABLE tb_tok_corretagem_a (
    cd_consulta       NUMBER GENERATED ALWAYS AS IDENTITY,description VARCHAR2(100),
    ob_tipo_habitacao CHAR(2) NOT NULL,
    vl_servico        NUMBER(8, 2) NOT NULL,
    cd_servico        VARCHAR2(100) NOT NULL,
    id_endereco       NUMBER NOT NULL,
    id_cliente        NUMBER(30) NOT NULL
);

COMMENT ON COLUMN tb_tok_corretagem_a.ob_tipo_habitacao IS
    'Ca = Casa | Ap = apartamento';

ALTER TABLE tb_tok_corretagem_a
    ADD CONSTRAINT tb_tok_ca_pk PRIMARY KEY ( cd_consulta,
                                              id_endereco,
                                              id_cliente );

CREATE TABLE tb_tok_corretagem_i (
    cd_consulta        NUMBER GENERATED ALWAYS AS IDENTITY,description VARCHAR2(100),
    nm_empresa_cliente VARCHAR2(100) NOT NULL,
    ob_tipo_seguimento VARCHAR2(100) NOT NULL,
    vl_servico         NUMBER(8, 2) NOT NULL,
    cd_servico         VARCHAR2(100) NOT NULL,
    id_endereco        NUMBER NOT NULL,
    id_cliente         NUMBER(30) NOT NULL
);

ALTER TABLE tb_tok_corretagem_i
    ADD CONSTRAINT tb_tok_ci_pk PRIMARY KEY ( cd_consulta,
                                              id_endereco,
                                              id_cliente );

CREATE TABLE tb_tok_corretagem_rp (
    cd_consulta       NUMBER GENERATED ALWAYS AS IDENTITY,description VARCHAR2(100),
    ob_tipo_habitacao CHAR(2) NOT NULL,
    vl_servico        NUMBER(8, 2) NOT NULL,
    cd_servico        VARCHAR2(100) NOT NULL,
    id_endereco       NUMBER NOT NULL,
    id_cliente        NUMBER(30) NOT NULL
);

COMMENT ON COLUMN tb_tok_corretagem_rp.ob_tipo_habitacao IS
    'Ca = Casa | Ap = apartamento';

ALTER TABLE tb_tok_corretagem_rp
    ADD CONSTRAINT tb_tok_crp_pk PRIMARY KEY ( cd_consulta,
                                               id_endereco,
                                               id_cliente );

CREATE TABLE tb_tok_corretor (
    id_corretor       NUMBER GENERATED ALWAYS AS IDENTITY,description VARCHAR2(30),
    nm_corretor       VARCHAR2(30) NOT NULL,
    ob_email_corretor VARCHAR2(100) NOT NULL,
    ob_senha_corretor VARCHAR2(30) NOT NULL
);

ALTER TABLE tb_tok_corretor ADD CONSTRAINT tb_tok_corretor_pk PRIMARY KEY ( id_corretor );

CREATE TABLE tb_tok_endereco_cliente (
    id_endereco           NUMBER GENERATED ALWAYS AS IDENTITY, description  NUMBER,
    id_cliente             NUMBER(30) NOT NULL,
    ob_endereco            VARCHAR2(80) NOT NULL,
    ob_local_rural         CHAR(1) NOT NULL,
    ob_portaria_eletr      CHAR(1) NOT NULL,
    ob_habitacao_alvenaria CHAR(1) NOT NULL,
    vl_imovel              NUMBER(10, 2) NOT NULL
);

COMMENT ON COLUMN tb_tok_endereco_cliente.ob_endereco IS
    'endereço completo do cliente';

COMMENT ON COLUMN tb_tok_endereco_cliente.ob_local_rural IS
    'S=sim | N=não';

COMMENT ON COLUMN tb_tok_endereco_cliente.ob_portaria_eletr IS
    'S=sim | N=não';

COMMENT ON COLUMN tb_tok_endereco_cliente.ob_habitacao_alvenaria IS
    'S=sim | N=não';

COMMENT ON COLUMN tb_tok_endereco_cliente.vl_imovel IS
    'valor total do imóvel';

ALTER TABLE tb_tok_endereco_cliente ADD CONSTRAINT tb_tok_endereco_cliente_pk PRIMARY KEY ( id_endereco,
                                                                                            id_cliente );

CREATE TABLE tb_tok_servicos (
    cd_servico VARCHAR2(100) NOT NULL,
    nm_servico VARCHAR2(50) NOT NULL
);

ALTER TABLE tb_tok_servicos ADD CONSTRAINT tb_tok_servicos_pk PRIMARY KEY ( cd_servico );

ALTER TABLE tb_tok_ajuda_cliente
    ADD CONSTRAINT fk_tok_cliente_ajuda FOREIGN KEY ( id_cliente )
        REFERENCES tb_tok_cliente ( id_cliente );
        
alter table tb_tok_ajuda_cliente
    add constraint fk_tok_corretor_ajuda foreign key (id_corretor)
    references tb_tok_corretor (id_corretor);

ALTER TABLE tb_tok_endereco_cliente
    ADD CONSTRAINT fk_tok_cliente_endereco FOREIGN KEY ( id_cliente )
        REFERENCES tb_tok_cliente ( id_cliente );

ALTER TABLE tb_tok_cliente
    ADD CONSTRAINT fk_tok_corretor_cliente FOREIGN KEY ( id_corretor )
        REFERENCES tb_tok_corretor ( id_corretor );

ALTER TABLE tb_tok_corretagem_a
    ADD CONSTRAINT fk_tok_endereco_a FOREIGN KEY ( id_endereco,
                                                   id_cliente )
        REFERENCES tb_tok_endereco_cliente ( id_endereco,
                                             id_cliente );

ALTER TABLE tb_tok_corretagem_i
    ADD CONSTRAINT fk_tok_endereco_i FOREIGN KEY ( id_endereco,
                                                   id_cliente )
        REFERENCES tb_tok_endereco_cliente ( id_endereco,
                                             id_cliente );

ALTER TABLE tb_tok_corretagem_rp
    ADD CONSTRAINT fk_tok_endereco_rp FOREIGN KEY ( id_endereco,
                                                    id_cliente )
        REFERENCES tb_tok_endereco_cliente ( id_endereco,
                                             id_cliente );

ALTER TABLE tb_tok_corretagem_a
    ADD CONSTRAINT fk_tok_servico_a FOREIGN KEY ( cd_servico )
        REFERENCES tb_tok_servicos ( cd_servico );

ALTER TABLE tb_tok_corretagem_i
    ADD CONSTRAINT fk_tok_servico_i FOREIGN KEY ( cd_servico )
        REFERENCES tb_tok_servicos ( cd_servico );

ALTER TABLE tb_tok_corretagem_rp
    ADD CONSTRAINT fk_tok_servico_rp FOREIGN KEY ( cd_servico )
        REFERENCES tb_tok_servicos ( cd_servico );
       
/*ADD UNIQUES*/

alter table tb_tok_cliente
add constraint nr_cpf_UNIQUE unique (nr_cpf_cliente);
alter table tb_tok_cliente
add constraint nr_rg_UNIQUE unique (nr_rg_cliente);
alter table tb_tok_cliente
add constraint ob_email_UNIQUE unique (ob_email_cliente);

alter table tb_tok_corretor
add constraint ob_emailcr_UNIQUE unique (ob_email_corretor);

commit;
/*CLOSE UNIQUES*/

/*SEQUENCES*/

commit;
/*CLOSE SEQUENCES*/

/*iNSERTS*/

insert into tb_tok_corretor
(nm_corretor, ob_email_corretor, ob_senha_corretor)
values('Fernando Gonçalves', 'fernando00@gmail.com', 'fefe123');
insert into tb_tok_corretor
(nm_corretor, ob_email_corretor, ob_senha_corretor)
values('José Alves', 'jose00@gmail.com', 'joalves123');
insert into tb_tok_corretor
(nm_corretor, ob_email_corretor, ob_senha_corretor)
values('Julio Bastista', 'julio@gmail.com', 'julinho123');

insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(1, 'Arthur Guedes', '384.456.578-40', '21/09/2004', 'M', '659340967', '7452309',
'11956384665', 'estudante', 1000.00, 'guedesbarroco@gmail.com', 'tutuguedes21');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(1, 'Luis zamapr', '384.453.578-45', '21/09/2004', 'M', '6538475560', '02198546',
'116529374665', 'estudante', 1000.00, 'zampar@gmail.com', 'zampar123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(1, 'João', '384.456.577-45', '21/09/2004', 'M', '647598677', '09567487356',
'119478567857', 'estudante', 1000.00, 'joao@gmail.com', 'joao123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(1, 'Fernanda', '384.456.578-49', '21/09/2004', 'F', '785683564', '9484756',
'1124355468', 'estudante', 1000.00, 'fernanda@gmail.com', 'fefe123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(1, 'Larissa', '344.456.578-45', '21/09/2004', 'F', '78467586', '032546576',
'1123444676778', 'estudante', 1000.00, 'larissa@gmailcom', 'larissa123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(2, 'Fernando', '384.456.178-45', '21/09/2004', 'M', '768798980', '09878943',
'11785460996', 'estudante', 1000.00, 'fernando99@gmail.com', 'nando123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(2, 'Augusto', '384.456.558-45', '21/09/2004', 'M', '094327865', '09876456',
'112309786774', 'estudante', 1000.00, 'augusto@gmailcom', 'augusto123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(2, 'Gabriela', '454.456.578-45', '21/09/2004', 'F', '457683113', '48709065',
'11232154665', 'estudante', 1000.00, 'gabriela@gmail.com', 'gabriela123');
insert into tb_tok_cliente 
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(2, 'Mirela', '384.456.578-41', '21/09/2004', 'F', '217845768', '02193543',
'1123748565576', 'estudante', 1000.00, 'mirela@gmail.com', 'mirela123');

insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(3, 'Francisca', '384.156.578-45', '21/09/2004', 'F', '84645985', '02198453',
'11674858866', 'estudante', 1000.00, 'francisca@gmail.com', 'francisca123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(3, 'Amanda', '384.456.556-45', '21/09/2004', 'F', '974351243', '0945673445',
'117865463221', 'estudante', 1000.00, 'amanda@gmail.com', 'amanda123');
insert into tb_tok_cliente
(id_corretor, nm_cliente, nr_cpf_cliente, dt_nasc_cliente, ob_sexo_cliente, nr_rg_cliente,
nr_cep_cliente, nr_tel_cliente, ob_profissao_cliente, vl_renda_mensal, ob_email_cliente, ds_senha_cliente)
values(3, 'delfino', '312.456.578-45', '21/09/2004', 'M', '6759867980', '09367544',
'11784567008', 'estudante', 1000.00, 'delfino@gmail.com', 'delfino123');



insert into tb_tok_ajuda_cliente
(id_corretor, id_cliente, tx_ajuda_cliente, ds_status)
values(1, 1, 'não estou conseguindo visualizar meus serviços', 'em análise');

insert into tb_tok_endereco_cliente
(id_cliente, ob_endereco, ob_local_rural, ob_portaria_eletr, ob_habitacao_alvenaria, vl_imovel)
values(2, 'Rua Fernando Falcão 1200', 'N', 'S', 'S', 300000.00);
insert into tb_tok_endereco_cliente
(id_cliente, ob_endereco, ob_local_rural, ob_portaria_eletr, ob_habitacao_alvenaria, vl_imovel)
values(2, 'Rua João Braga 12', 'S', 'N', 'S', 250000.00);
insert into tb_tok_endereco_cliente
(id_cliente, ob_endereco, ob_local_rural, ob_portaria_eletr, ob_habitacao_alvenaria, vl_imovel)
values(1, 'Av. Paulista 1100', 'N', 'S', 'S', 600000.00);
insert into tb_tok_endereco_cliente
(id_cliente, ob_endereco, ob_local_rural, ob_portaria_eletr, ob_habitacao_alvenaria, vl_imovel)
values(1, 'Rua da Mooca 110', 'N', 'S', 'S', 800000.00);
insert into tb_tok_endereco_cliente
(id_cliente, ob_endereco, ob_local_rural, ob_portaria_eletr, ob_habitacao_alvenaria, vl_imovel)
values(2, 'Rua Meireles 123', 'N', 'S', 'S', 250000.00);

insert into tb_tok_servicos
(cd_servico, nm_servico)
values(1, 'Seguro Residencial Premiado');
insert into tb_tok_servicos
(cd_servico, nm_servico)
values(2, 'Seguro Fiança Locatícia - Aluguel');
insert into tb_tok_servicos
(cd_servico, nm_servico)
values(3, 'Seguro Imobiliário');

insert into tb_tok_corretagem_rp
(ob_tipo_habitacao, vl_servico, cd_servico, id_endereco, id_cliente)
values('Ap', 1000.00, 1, 3, 1);
insert into tb_tok_corretagem_rp
(ob_tipo_habitacao, vl_servico, cd_servico, id_endereco, id_cliente)
values('Ca', 600.00, 1, 2, 2);
insert into tb_tok_corretagem_a
(ob_tipo_habitacao, vl_servico, cd_servico, id_endereco, id_cliente)
values('Ap', 1500.00, 2, 1, 2);
insert into tb_tok_corretagem_i
(nm_empresa_cliente, ob_tipo_seguimento, vl_servico, cd_servico, id_endereco,
id_cliente)
values('Guedes Investimentos', 'Investimentos', 3000.00, 3, 4, 1);
insert into tb_tok_corretagem_rp
(ob_tipo_habitacao, vl_servico, cd_servico, id_endereco, id_cliente)
values('Ap', 300000.00, 1, 5, 2);

commit;
/*CLOSE INSERTS*/

/*SELECTS*/

create or replace view V_cliente_corretor as
select cli.id_cliente ,cli.nm_cliente, cor.id_corretor, cor.nm_corretor
from tb_tok_cliente cli, tb_tok_corretor cor
where cli.id_cliente = cor.id_corretor;

select * from V_cliente_corretor;

create or replace view V_valores_corretagemI as
select ci.vl_servico, cli.nm_cliente, ser.nm_servico
from tb_tok_corretagem_i ci left join tb_tok_cliente cli
on(ci.cd_consulta = cli.id_cliente)inner join tb_tok_servicos ser
on ci.cd_consulta = ser.cd_servico;

select * from V_valores_corretagemI;

create or replace view V_valores_corretagemCRP as
select crp.vl_servico, cli.nm_cliente, ser.nm_servico
from tb_tok_corretagem_rp crp left join tb_tok_cliente cli
on(crp.cd_consulta = cli.id_cliente) inner join tb_tok_servicos ser
on crp.cd_servico = ser.cd_servico;

select * from V_valores_corretagemCRP;

create or replace view V_valores_corretagemA as
select ca.vl_servico, cli.nm_cliente, ser.nm_servico
from tb_tok_corretagem_a ca left join tb_tok_cliente cli
on (ca.cd_consulta = cli.id_cliente) inner join tb_tok_servicos ser
on ca.cd_servico = ser.cd_servico;

select * from V_valores_corretagemA;

--Nome e cpf do cliente + Seguro Imobiliário
create or replace view V_cliente_i as
select ci.cd_consulta, cli.nm_cliente, cli.nr_cpf_cliente, ser.nm_servico
from tb_tok_corretagem_i ci left join tb_tok_cliente cli
on (ci.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on ci.cd_servico = ser.cd_servico;

select * from V_cliente_rp;

--Nome e cpf do cliente + Seguro Residencial
create or replace view V_cliente_rp as
select crp.cd_consulta, cli.nm_cliente, cli.nr_cpf_cliente, ser.nm_servico
from tb_tok_corretagem_rp crp left join tb_tok_cliente cli
on (crp.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on crp.cd_servico = ser.cd_servico;

--Nome e cpf do cliente + Seguro Aluguel
create or replace view V_cliente_a as
select ca.cd_consulta, cli.nm_cliente, cli.nr_cpf_cliente, ser.nm_servico
from tb_tok_corretagem_a ca left join tb_tok_cliente cli
on (ca.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on ca.cd_servico = ser.cd_servico;

--Tipo de Habitação Aluguel
select ca.ob_tipo_habitacao, en.ob_endereco, cli.nm_cliente
from tb_tok_endereco_cliente en left join tb_tok_cliente cli
on(en.id_endereco = cli.id_cliente) inner join tb_tok_corretagem_a ca
on ca.cd_consulta = en.id_endereco;

--Tipo de Habitação Residencial premiado
select crp.ob_tipo_habitacao, en.ob_endereco, cli.nm_cliente
from tb_tok_endereco_cliente en left join tb_tok_cliente cli
on(en.id_endereco = cli.id_cliente) inner join tb_tok_corretagem_rp crp
on crp.cd_consulta = en.id_endereco;

--Nome e profissão do cliente
select nm_cliente, ob_profissao_cliente from tb_tok_cliente;

--Nome e profissão do cliente + Seguro Residencial
select crp.cd_consulta, cli.nm_cliente, cli.ob_profissao_cliente, ser.nm_servico
from tb_tok_corretagem_rp crp left join tb_tok_cliente cli
on (crp.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on crp.cd_servico = ser.cd_servico;

--Nome e profissão do cliente + Seguro Aluguel
select ca.cd_consulta, cli.nm_cliente, cli.ob_profissao_cliente, ser.nm_servico
from tb_tok_corretagem_a ca left join tb_tok_cliente cli
on (ca.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on ca.cd_servico = ser.cd_servico;

--Nome e profissão do cliente + Seguro Imobiliário
select ci.cd_consulta, cli.nm_cliente, cli.ob_profissao_cliente, ser.nm_servico
from tb_tok_corretagem_i ci left join tb_tok_cliente cli
on (ci.id_cliente = cli.id_cliente) inner join tb_tok_servicos ser
on ci.cd_servico = ser.cd_servico;

--Somando número de clientes por corretor
select count (*) qtd_cliente from tb_tok_cliente where id_corretor = 2;

--Soma dos valores do Seguro Residencial por cliente
select sum (vl_servico) vl_servico from tb_tok_corretagem_rp where id_cliente = 2;

--Select serviço residencial
select cli.nm_cliente, ecli.ob_endereco, ecli.ob_local_rural,
ecli.ob_portaria_eletr, ecli.ob_habitacao_alvenaria, ecli.vl_imovel,
crp.ob_tipo_habitacao, crp.vl_servico, ser.cd_servico
from tb_tok_endereco_cliente ecli left join tb_tok_cliente cli
on (ecli.id_cliente  = cli.id_cliente) inner join tb_tok_corretagem_rp crp
on (ecli.id_endereco = crp.id_endereco) inner join tb_tok_servicos ser
on crp.cd_servico = ser.cd_servico
where cd_consulta=2;

--Select serviço Aluguel
select cli.nm_cliente, ecli.ob_endereco, ecli.ob_local_rural,
ecli.ob_portaria_eletr, ecli.ob_habitacao_alvenaria, ecli.vl_imovel,
ca.ob_tipo_habitacao, ca.vl_servico, ser.cd_servico
from tb_tok_endereco_cliente ecli left join tb_tok_cliente cli
on (ecli.id_cliente  = cli.id_cliente) inner join tb_tok_corretagem_a ca
on (ecli.id_endereco = ca.id_endereco) inner join tb_tok_servicos ser
on ca.cd_servico = ser.cd_servico
where cd_consulta=1;

--Select serviço imobiliario
select cli.nm_cliente, ecli.ob_endereco, ecli.ob_local_rural,
ecli.ob_portaria_eletr, ecli.ob_habitacao_alvenaria, ecli.vl_imovel,
ci.vl_servico, ci.nm_empresa_cliente, ser.cd_servico
from tb_tok_endereco_cliente ecli left join tb_tok_cliente cli
on (ecli.id_cliente  = cli.id_cliente) inner join tb_tok_corretagem_i ci
on (ecli.id_endereco = ci.id_endereco) inner join tb_tok_servicos ser
on ci.cd_servico = ser.cd_servico
where cd_consulta=1;


select crp.cd_consulta, crp.vl_servico, ser.nm_servico
from tb_tok_corretagem_rp crp inner join tb_tok_servicos ser
on crp.cd_servico = ser.cd_servico;

select ca.cd_consulta, ca.vl_servico, ser.nm_servico
from tb_tok_corretagem_a ca inner join tb_tok_servicos ser
on ca.cd_servico = ser.cd_servico;

select ci.cd_consulta, ci.vl_servico, ser.nm_servico
from tb_tok_corretagem_i  ci inner join tb_tok_servicos ser
on ci.cd_servico = ser.cd_servico;

select crp.vl_servico, ser.nm_servico,  ecli.ob_endereco
from tb_tok_corretagem_rp crp left join tb_tok_endereco_cliente ecli
on(ecli.id_endereco = crp.id_endereco) inner join tb_tok_servicos ser
on(crp.cd_servico = ser.cd_servico) inner join tb_tok_cliente cli
on cli.id_cliente = ecli.id_cliente
where cli.id_cliente=1;

select cli.nm_cliente, aju.tx_ajuda_cliente, aju.ds_status
from tb_tok_ajuda_cliente aju inner join tb_tok_cliente cli
on  aju.id_cliente = cli.id_cliente;

/*CLOSE SELECTS*/