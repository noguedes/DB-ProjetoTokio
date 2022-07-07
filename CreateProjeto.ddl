
CREATE TABLE tb_tok_ajuda_cliente (
    cd_chamada_ajuda NUMBER(30) NOT NULL,
    id_cliente       NUMBER(30) NOT NULL,
    tx_ajuda_cliente VARCHAR2(255) NOT NULL,
    ds_status        VARCHAR2(100) NOT NULL
);

ALTER TABLE tb_tok_ajuda_cliente ADD CONSTRAINT tb_tok_ajuda_cliente_pk PRIMARY KEY ( cd_chamada_ajuda );

CREATE TABLE tb_tok_cliente (
    id_cliente           NUMBER(30) NOT NULL,
    id_corretor          VARCHAR2(30) NOT NULL,
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
    cd_consulta       VARCHAR2(100) NOT NULL,
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
    cd_consulta        VARCHAR2(100) NOT NULL,
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
    cd_consulta       VARCHAR2(100) NOT NULL,
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
    id_corretor       VARCHAR2(30) NOT NULL,
    nm_corretor       VARCHAR2(30) NOT NULL,
    ob_email_corretor VARCHAR2(100) NOT NULL,
    ob_senha_corretor VARCHAR2(30) NOT NULL
);

ALTER TABLE tb_tok_corretor ADD CONSTRAINT tb_tok_corretor_pk PRIMARY KEY ( id_corretor );

CREATE TABLE tb_tok_endereco_cliente (
    id_endereco            NUMBER NOT NULL,
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
