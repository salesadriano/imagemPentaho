-- MySQL dump 10.13  Distrib 8.0.25, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: transparenciaDB
-- ------------------------------------------------------
-- Server version	5.5.5-10.5.10-MariaDB-1:10.5.10+maria~focal

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary view structure for view `cargos`
--

DROP TABLE IF EXISTS `cargos`;
/*!50001 DROP VIEW IF EXISTS `cargos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `cargos` AS SELECT 
 1 AS `CARGOSERVIDOR`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `contratos`
--

DROP TABLE IF EXISTS `contratos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `contratos` (
  `IDCONTRATO` bigint(20) NOT NULL AUTO_INCREMENT,
  `MATRICULASERVIDOR` bigint(20) DEFAULT NULL,
  `NUMEROCONTRATO` int(11) DEFAULT NULL,
  `CPFSERVIDOR` bigint(20) DEFAULT NULL,
  `TIPOCONTRATO` varchar(50) DEFAULT NULL,
  `CARGOSERVIDOR` varchar(400) DEFAULT NULL,
  `DATAADMISSAO` datetime DEFAULT NULL,
  PRIMARY KEY (`IDCONTRATO`),
  UNIQUE KEY `contratos_UN` (`MATRICULASERVIDOR`,`NUMEROCONTRATO`,`CPFSERVIDOR`,`TIPOCONTRATO`)
) ENGINE=InnoDB AUTO_INCREMENT=32026 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `despesa_covid`
--

DROP TABLE IF EXISTS `despesa_covid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesa_covid` (
  `TIPODOCUMENTO` varchar(1000) DEFAULT NULL,
  `NUMERODOCUMENTO` varchar(1000) DEFAULT NULL,
  `ANODOCUMENTO` int(11) DEFAULT NULL,
  `TIPODOCUMENTOORIGEM` varchar(1000) DEFAULT NULL,
  `NUMERODOCUMENTOORIGEM` varchar(1000) DEFAULT NULL,
  `ANODOCUMENTOORIGEM` int(11) DEFAULT NULL,
  `DATAEMISSAO` date DEFAULT NULL,
  `DATABAIXA` date DEFAULT NULL,
  `VALORDOCUMENTO` decimal(15,2) DEFAULT NULL,
  `VALORANULADO` decimal(15,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `despesa_extra`
--

DROP TABLE IF EXISTS `despesa_extra`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `despesa_extra` (
  `NUMERODESPESAEXTRA` bigint(20) NOT NULL,
  `ANODESPESAEXTRA` int(11) NOT NULL,
  `ENTIDADE` varchar(255) DEFAULT NULL,
  `DATAEMISSAO` datetime DEFAULT NULL,
  `DATABORDERO` datetime DEFAULT NULL,
  `DATAPAGAMENTO` datetime DEFAULT NULL,
  `DATABAIXA` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `NUMEROEMISSOES` varchar(255) DEFAULT NULL,
  `ORGAO` int(11) DEFAULT NULL,
  `UNIDADE` int(11) DEFAULT NULL,
  `TIPOGUIA` varchar(255) DEFAULT NULL,
  `CONTAEXTRAORCAMENTARIA` varchar(255) DEFAULT NULL,
  `HISTORICO` varchar(500) DEFAULT NULL,
  `DESCRICAO` varchar(500) DEFAULT NULL,
  `CODIGOCREDOR` varchar(255) DEFAULT NULL,
  `RAZAOSOCIAL` varchar(500) DEFAULT NULL,
  `CODIGOCLASSECREDOR` varchar(255) DEFAULT NULL,
  `NOMECLASSECREDOR` varchar(255) DEFAULT NULL,
  `CODIGOBANCO` varchar(255) DEFAULT NULL,
  `CODIGOAGENCIA` varchar(255) DEFAULT NULL,
  `CONTABANCARIA` varchar(255) DEFAULT NULL,
  `NATUREZAPAGAMENTO` varchar(255) DEFAULT NULL,
  `VALORDESPESAEXTRA` decimal(15,2) unsigned DEFAULT NULL,
  `TOTALANULADODESPESAEXTRA` decimal(15,2) DEFAULT NULL,
  `DOCUMENTODESPESAEXTRA` varchar(255) DEFAULT NULL,
  `FORMAPAGAMENTO` varchar(255) DEFAULT NULL,
  `TIPOOPERACAOBANCARIA` varchar(255) DEFAULT NULL,
  `CONTAFINANCEIRA` varchar(255) DEFAULT NULL,
  `TAC` varchar(255) DEFAULT NULL,
  `EVENTOCONTABIL` int(11) DEFAULT NULL,
  PRIMARY KEY (`NUMERODESPESAEXTRA`,`ANODESPESAEXTRA`),
  KEY `despesa_extra_CODIGOCLASSECREDOR_IDX` (`CODIGOCLASSECREDOR`) USING BTREE,
  KEY `despesa_extra_ORGAO_IDX` (`ORGAO`) USING BTREE,
  KEY `despesa_extra_ANODESPESAEXTRA_IDX` (`ANODESPESAEXTRA`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `diarias`
--

DROP TABLE IF EXISTS `diarias`;
/*!50001 DROP VIEW IF EXISTS `diarias`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `diarias` AS SELECT 
 1 AS `IDEMPENHO`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CPFCNPJCREDOR_`,
 1 AS `IDPAGAMENTO`,
 1 AS `ANOPAGAMENTO`,
 1 AS `ENTIDADE`,
 1 AS `ANOLIQUIDACAO`,
 1 AS `NUMEROLIQUIDACAO`,
 1 AS `DATAPAGAMENTO`,
 1 AS `MESPAGAMENTO`,
 1 AS `STATUS`,
 1 AS `RAZAOSOCIAL`,
 1 AS `HISTORICO`,
 1 AS `VALORPAGAMENTO`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `empenho_consolidado`
--

DROP TABLE IF EXISTS `empenho_consolidado`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empenho_consolidado` (
  `IDEMPENHO` bigint(20) NOT NULL AUTO_INCREMENT,
  `IDENTIDADE` int(11) NOT NULL,
  `NUMEROEMPENHO` bigint(50) NOT NULL,
  `ANOEMPENHO` int(11) NOT NULL,
  `ENTIDADE` varchar(500) DEFAULT NULL,
  `DATAEMPENHO` datetime DEFAULT NULL,
  `TIPOEMPENHO` varchar(50) DEFAULT NULL,
  `DATAPROGRAMACAO` datetime DEFAULT NULL,
  `NUMEROEMISSOES` int(11) DEFAULT NULL,
  `STATUS` varchar(50) DEFAULT NULL,
  `PEDIDOEMPENHO` varchar(255) DEFAULT NULL,
  `MOTIVOEMPENHO` varchar(500) DEFAULT NULL,
  `NUMEROCONTRATO` varchar(50) DEFAULT NULL,
  `DATAPEDIDO` datetime DEFAULT NULL,
  `MODALIDADELICITACAO` varchar(255) DEFAULT NULL,
  `NUMEROLICITACAO` varchar(255) DEFAULT NULL,
  `HISTORICO` varchar(500) DEFAULT NULL,
  `CODIGOCREDOR` int(11) DEFAULT NULL,
  `RAZAOSOCIAL` varchar(255) DEFAULT NULL,
  `CPFCNPJCREDOR` varchar(50) DEFAULT NULL,
  `CPFCNPJCREDOR_` bigint(20) DEFAULT NULL,
  `CLASSECREDOR` varchar(255) DEFAULT NULL,
  `BANCO` varchar(50) DEFAULT NULL,
  `BANCO_` int(11) DEFAULT NULL,
  `AGENCIA` varchar(50) DEFAULT NULL,
  `AGENCIA_` varchar(50) DEFAULT NULL,
  `CONTA` varchar(50) DEFAULT NULL,
  `CONTA_` varchar(50) DEFAULT NULL,
  `ORGAO` int(11) NOT NULL,
  `UNIDADE` int(11) DEFAULT NULL,
  `REDUZIDOFUNCIONAL` int(11) DEFAULT NULL,
  `FUNCIONALPROGRAMATICA` varchar(50) DEFAULT NULL,
  `DESPESAORCAMENTARIA` varchar(50) DEFAULT NULL,
  `FONTERECURSO` int(11) DEFAULT NULL,
  `DETALHAMENTOFONTE` varchar(255) DEFAULT NULL,
  `VALOREMPENHADO` decimal(15,2) DEFAULT NULL,
  `NATUREZARECURSO` varchar(255) DEFAULT NULL,
  `NUMEROCONVENIO` int(11) DEFAULT NULL,
  `ANOCONVENIO` int(11) DEFAULT NULL,
  `NUMEROPROCESSO` varchar(255) DEFAULT NULL,
  `ANOPROCESSO` int(11) DEFAULT NULL,
  `EVENTOCONTABIL` int(11) DEFAULT NULL,
  `TOTALLIQUIDADO` decimal(15,2) DEFAULT NULL,
  `TOTALPAGO` decimal(15,2) DEFAULT NULL,
  `COMPLETO` varchar(1000) DEFAULT NULL,
  `HASHCOMPLETO` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`IDEMPENHO`),
  KEY `empenho_consolidado_ANOEMPENHO_IDX` (`ANOEMPENHO`) USING BTREE,
  KEY `empenho_consolidado_NUMEROEMPENHO_IDX` (`NUMEROEMPENHO`) USING BTREE,
  KEY `empenho_consolidado_STATUS_IDX` (`STATUS`) USING BTREE,
  KEY `empenho_consolidado_DATAPEDIDO_IDX` (`DATAPEDIDO`) USING BTREE,
  KEY `empenho_consolidado_NUMEROLICITACAO_IDX` (`NUMEROLICITACAO`) USING BTREE,
  KEY `empenho_consolidado_CODIGOCREDOR_IDX` (`CODIGOCREDOR`) USING BTREE,
  KEY `empenho_consolidado_CPFCNPJCREDOR__IDX` (`CPFCNPJCREDOR_`) USING BTREE,
  KEY `empenho_consolidado_ORGAO_IDX` (`ORGAO`) USING BTREE,
  KEY `empenho_consolidado_FONTERECURSO_IDX` (`FONTERECURSO`) USING BTREE,
  KEY `empenho_consolidado_ANOCONVENIO_IDX` (`ANOCONVENIO`) USING BTREE,
  KEY `empenho_consolidado_NUMEROCONVENIO_IDX` (`NUMEROCONVENIO`) USING BTREE,
  KEY `empenho_consolidado_ANOPROCESSO_IDX` (`ANOPROCESSO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=146001 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `empenho_liquidacao`
--

DROP TABLE IF EXISTS `empenho_liquidacao`;
/*!50001 DROP VIEW IF EXISTS `empenho_liquidacao`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empenho_liquidacao` AS SELECT 
 1 AS `IDEMPENHO`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `NUMEROEMPENHO`,
 1 AS `ANOEMPENHO`,
 1 AS `IDLIQUIDACAO`,
 1 AS `NUMEROLIQUIDACAO`,
 1 AS `ANOLIQUIDACAO`,
 1 AS `DATAEMISSAO`,
 1 AS `STATUS`,
 1 AS `NUMEROEMISSOES`,
 1 AS `PREVISAOPAGAMENTO`,
 1 AS `DATAEMPENHO`,
 1 AS `HISTORICO`,
 1 AS `TIPOEMPENHO`,
 1 AS `CODIGOCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `EXERCICIO`,
 1 AS `UNIDADE`,
 1 AS `REDUZIDOPROGRAMATICA`,
 1 AS `FUNCIONALPROGRAMATICA`,
 1 AS `DESPESAORCAMENTARIA`,
 1 AS `FONTERECURSO`,
 1 AS `VALORDALIQUIDACAO`,
 1 AS `ANULADOLIQUIDACAO`,
 1 AS `VALOREMPENHO`,
 1 AS `TOTALALIQUIDAR`,
 1 AS `PAGODALIQUIDACAO`,
 1 AS `TOTALAPAGAR`,
 1 AS `DESCRITIVOLIQUIDACAO`,
 1 AS `TIPODOCUMENTO`,
 1 AS `DOCUMENTOCOMPROBATORIO`,
 1 AS `ANODOCUMENTO`,
 1 AS `MESDOCUMENTO`,
 1 AS `DATADOCUMENTO`,
 1 AS `EVENTOCONTABIL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `empenho_pagamento`
--

DROP TABLE IF EXISTS `empenho_pagamento`;
/*!50001 DROP VIEW IF EXISTS `empenho_pagamento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empenho_pagamento` AS SELECT 
 1 AS `IDEMPENHO`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CPFCNPJCREDOR_`,
 1 AS `IDPAGAMENTO`,
 1 AS `NUMEROPAGAMENTO`,
 1 AS `ANOPAGAMENTO`,
 1 AS `ENTIDADE`,
 1 AS `ANOLIQUIDACAO`,
 1 AS `NUMEROLIQUIDACAO`,
 1 AS `DATAEMISSAO`,
 1 AS `DATABORDERO`,
 1 AS `DATAPAGAMENTO`,
 1 AS `DATABAIXA`,
 1 AS `STATUS`,
 1 AS `CODIGOCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `CODIGOBANCO`,
 1 AS `CODIGOAGENCIA`,
 1 AS `CONTABANCARIA`,
 1 AS `CONTAFINANCEIRA`,
 1 AS `DESCRICAOPAGAMENTO`,
 1 AS `HISTORICO`,
 1 AS `CODIGONATUREZAPAGAMENTO`,
 1 AS `DESCRICAONATUREZAPAGAMENTO`,
 1 AS `NUMEROEMISSOES`,
 1 AS `VALORPAGAMENTO`,
 1 AS `TOTALCONSIGNACOES`,
 1 AS `TOTALDESCONTO`,
 1 AS `FORMAPAGAMENTO`,
 1 AS `TIPOOPERACAOBANCARIA`,
 1 AS `DOCUMENTOPAGAMENTO`,
 1 AS `EVENTOCONTABIL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `empenho_pagamento_covid`
--

DROP TABLE IF EXISTS `empenho_pagamento_covid`;
/*!50001 DROP VIEW IF EXISTS `empenho_pagamento_covid`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empenho_pagamento_covid` AS SELECT 
 1 AS `IDEMPENHO`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CPFCNPJCREDOR_`,
 1 AS `IDPAGAMENTO`,
 1 AS `NUMEROPAGAMENTO`,
 1 AS `ANOPAGAMENTO`,
 1 AS `ENTIDADE`,
 1 AS `ANOLIQUIDACAO`,
 1 AS `NUMEROLIQUIDACAO`,
 1 AS `DATAEMISSAO`,
 1 AS `DATABORDERO`,
 1 AS `DATAPAGAMENTO`,
 1 AS `DATABAIXA`,
 1 AS `STATUS`,
 1 AS `CODIGOCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `CODIGOBANCO`,
 1 AS `CODIGOAGENCIA`,
 1 AS `CONTABANCARIA`,
 1 AS `CONTAFINANCEIRA`,
 1 AS `DESCRICAOPAGAMENTO`,
 1 AS `CODIGONATUREZAPAGAMENTO`,
 1 AS `DESCRICAONATUREZAPAGAMENTO`,
 1 AS `NUMEROEMISSOES`,
 1 AS `VALORPAGAMENTO`,
 1 AS `TOTALCONSIGNACOES`,
 1 AS `TOTALDESCONTO`,
 1 AS `FORMAPAGAMENTO`,
 1 AS `TIPOOPERACAOBANCARIA`,
 1 AS `DOCUMENTOPAGAMENTO`,
 1 AS `EVENTOCONTABIL`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `empenhos`
--

DROP TABLE IF EXISTS `empenhos`;
/*!50001 DROP VIEW IF EXISTS `empenhos`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empenhos` AS SELECT 
 1 AS `IDENTIDADE`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `IDEMPENHO`,
 1 AS `NUMEROEMPENHO`,
 1 AS `ANOEMPENHO`,
 1 AS `DATAEMPENHO`,
 1 AS `TIPOEMPENHO`,
 1 AS `DATAPROGRAMACAO`,
 1 AS `NUMEROEMISSOES`,
 1 AS `STATUS`,
 1 AS `MOTIVOEMPENHO`,
 1 AS `NUMEROCONTRATO`,
 1 AS `PEDIDOEMPENHO`,
 1 AS `DATAPEDIDO`,
 1 AS `MODALIDADELICITACAO`,
 1 AS `NUMEROLICITACAO`,
 1 AS `HISTORICO`,
 1 AS `CODIGOCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CLASSECREDOR`,
 1 AS `BANCO`,
 1 AS `AGENCIA`,
 1 AS `CONTA`,
 1 AS `UNIDADE`,
 1 AS `REDUZIDOFUNCIONAL`,
 1 AS `FUNCIONALPROGRAMATICA`,
 1 AS `DESPESAORCAMENTARIA`,
 1 AS `FONTERECURSO`,
 1 AS `DETALHAMENTOFONTE`,
 1 AS `VALOREMPENHADO`,
 1 AS `NATUREZARECURSO`,
 1 AS `NUMEROCONVENIO`,
 1 AS `ANOCONVENIO`,
 1 AS `NUMEROPROCESSO`,
 1 AS `ANOPROCESSO`,
 1 AS `EVENTOCONTABIL`,
 1 AS `TOTALLIQUIDADO`,
 1 AS `TOTALPAGO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `empenhos_covid`
--

DROP TABLE IF EXISTS `empenhos_covid`;
/*!50001 DROP VIEW IF EXISTS `empenhos_covid`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `empenhos_covid` AS SELECT 
 1 AS `IDENTIDADE`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `IDEMPENHO`,
 1 AS `NUMEROEMPENHO`,
 1 AS `ANOEMPENHO`,
 1 AS `DATAEMPENHO`,
 1 AS `TIPOEMPENHO`,
 1 AS `DATAPROGRAMACAO`,
 1 AS `NUMEROEMISSOES`,
 1 AS `STATUS`,
 1 AS `MOTIVOEMPENHO`,
 1 AS `NUMEROCONTRATO`,
 1 AS `PEDIDOEMPENHO`,
 1 AS `DATAPEDIDO`,
 1 AS `MODALIDADELICITACAO`,
 1 AS `NUMEROLICITACAO`,
 1 AS `HISTORICO`,
 1 AS `CODIGOCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CLASSECREDOR`,
 1 AS `BANCO`,
 1 AS `AGENCIA`,
 1 AS `CONTA`,
 1 AS `UNIDADE`,
 1 AS `REDUZIDOFUNCIONAL`,
 1 AS `FUNCIONALPROGRAMATICA`,
 1 AS `DESPESAORCAMENTARIA`,
 1 AS `FONTERECURSO`,
 1 AS `DETALHAMENTOFONTE`,
 1 AS `VALOREMPENHADO`,
 1 AS `NATUREZARECURSO`,
 1 AS `NUMEROCONVENIO`,
 1 AS `ANOCONVENIO`,
 1 AS `NUMEROPROCESSO`,
 1 AS `ANOPROCESSO`,
 1 AS `EVENTOCONTABIL`,
 1 AS `TOTALLIQUIDADO`,
 1 AS `TOTALPAGO`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `entidadade_empenho`
--

DROP TABLE IF EXISTS `entidadade_empenho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entidadade_empenho` (
  `IDENTIDADE` bigint(20) NOT NULL,
  `IDEMPENHO` bigint(20) NOT NULL,
  PRIMARY KEY (`IDENTIDADE`,`IDEMPENHO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `entidade`
--

DROP TABLE IF EXISTS `entidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entidade` (
  `IDENTIDADE` bigint(20) NOT NULL AUTO_INCREMENT,
  `ORGAO` bigint(20) NOT NULL,
  `ENTIDADE` varchar(200) DEFAULT NULL,
  `NOMEENTIDADE` varchar(1000) NOT NULL,
  `SIGLA` varchar(20) DEFAULT NULL,
  `HASHCOMPLETO` varchar(8000) DEFAULT NULL,
  PRIMARY KEY (`IDENTIDADE`),
  UNIQUE KEY `entidade_UN` (`ORGAO`,`ENTIDADE`),
  UNIQUE KEY `UK_entidade_hash` (`HASHCOMPLETO`) USING HASH,
  KEY `entidade_entidade_IDX` (`ENTIDADE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=15496 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `entidade_despesas`
--

DROP TABLE IF EXISTS `entidade_despesas`;
/*!50001 DROP VIEW IF EXISTS `entidade_despesas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entidade_despesas` AS SELECT 
 1 AS `IDENTIDADE`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `ANOEMPENHO`,
 1 AS `TOTALEMPENHADO`,
 1 AS `TOTALLIQUIDADO`,
 1 AS `TOTALPAGO`,
 1 AS `TOTALDESPESAEXTRA`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `entidade_despesas_covid`
--

DROP TABLE IF EXISTS `entidade_despesas_covid`;
/*!50001 DROP VIEW IF EXISTS `entidade_despesas_covid`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entidade_despesas_covid` AS SELECT 
 1 AS `IDENTIDADE`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `ANOEMPENHO`,
 1 AS `TOTALEMPENHADO`,
 1 AS `TOTALLIQUIDADO`,
 1 AS `TOTALPAGO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `entidade_receitas`
--

DROP TABLE IF EXISTS `entidade_receitas`;
/*!50001 DROP VIEW IF EXISTS `entidade_receitas`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `entidade_receitas` AS SELECT 
 1 AS `IDENTIDADE`,
 1 AS `ORGAO`,
 1 AS `ENTIDADE`,
 1 AS `ANORECEITA`,
 1 AS `ORCADOINICIAL`,
 1 AS `RECEITAREALIZADA`,
 1 AS `RECEITAAREALIZAR`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `fornecedor`
--

DROP TABLE IF EXISTS `fornecedor`;
/*!50001 DROP VIEW IF EXISTS `fornecedor`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `fornecedor` AS SELECT 
 1 AS `CPFCNPJCREDOR`,
 1 AS `RAZAOSOCIAL`,
 1 AS `ANOEMPENHO`,
 1 AS `QUANTITADEEMPENHOS`,
 1 AS `TOTALEMPENHADO`,
 1 AS `TOTALLIQUIDADO`,
 1 AS `TOTALPAGO`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `liquidacao`
--

DROP TABLE IF EXISTS `liquidacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liquidacao` (
  `IDLIQUIDACAO` bigint(20) NOT NULL AUTO_INCREMENT,
  `NUMEROLIQUIDACAO` bigint(20) NOT NULL,
  `ANOLIQUIDACAO` int(11) NOT NULL,
  `ENTIDADE` varchar(255) DEFAULT NULL,
  `NUMEROEMPENHO` bigint(20) DEFAULT NULL,
  `ANOEMPENHO` int(11) DEFAULT NULL,
  `DATAEMISSAO` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `NUMEROEMISSOES` int(11) DEFAULT NULL,
  `PREVISAOPAGAMENTO` varchar(255) DEFAULT NULL,
  `DATAEMPENHO` datetime DEFAULT NULL,
  `HISTORICO` varchar(500) DEFAULT NULL,
  `TIPOEMPENHO` varchar(255) DEFAULT NULL,
  `CODIGOCREDOR` int(11) DEFAULT NULL,
  `RAZAOSOCIAL` varchar(255) DEFAULT NULL,
  `EXERCICIO` int(11) DEFAULT NULL,
  `ORGAO` int(11) NOT NULL,
  `UNIDADE` int(11) DEFAULT NULL,
  `REDUZIDOPROGRAMATICA` int(11) DEFAULT NULL,
  `FUNCIONALPROGRAMATICA` varchar(50) DEFAULT NULL,
  `DESPESAORCAMENTARIA` varchar(50) DEFAULT NULL,
  `FONTERECURSO` int(11) DEFAULT NULL,
  `VALORDALIQUIDACAO` decimal(15,2) DEFAULT NULL,
  `ANULADOLIQUIDACAO` decimal(15,2) DEFAULT NULL,
  `VALOREMPENHO` decimal(15,2) DEFAULT NULL,
  `TOTALALIQUIDAR` decimal(15,2) DEFAULT NULL,
  `PAGODALIQUIDACAO` decimal(15,2) DEFAULT NULL,
  `TOTALAPAGAR` decimal(15,2) DEFAULT NULL,
  `DESCRITIVOLIQUIDACAO` varchar(255) DEFAULT NULL,
  `TIPODOCUMENTO` varchar(255) DEFAULT NULL,
  `DOCUMENTOCOMPROBATORIO` varchar(255) DEFAULT NULL,
  `ANODOCUMENTO` int(11) DEFAULT NULL,
  `MESDOCUMENTO` int(11) DEFAULT NULL,
  `DATADOCUMENTO` datetime DEFAULT NULL,
  `EVENTOCONTABIL` int(11) DEFAULT NULL,
  PRIMARY KEY (`IDLIQUIDACAO`),
  KEY `liquidacao_MESDOCUMENTO_IDX` (`MESDOCUMENTO`) USING BTREE,
  KEY `liquidacao_ANODOCUMENTO_IDX` (`ANODOCUMENTO`) USING BTREE,
  KEY `liquidacao_FONTERECURSO_IDX` (`FONTERECURSO`) USING BTREE,
  KEY `liquidacao_ORGAO_IDX` (`ORGAO`) USING BTREE,
  KEY `liquidacao_EXERCICIO_IDX` (`EXERCICIO`) USING BTREE,
  KEY `liquidacao_CODIGOCREDOR_IDX` (`CODIGOCREDOR`) USING BTREE,
  KEY `liquidacao_ANOEMPENHO_IDX` (`ANOEMPENHO`) USING BTREE,
  KEY `liquidacao_NUMEROEMPENHO_IDX` (`NUMEROEMPENHO`) USING BTREE,
  KEY `liquidacao_ANOLIQUIDACAO_IDX` (`ANOLIQUIDACAO`) USING BTREE,
  KEY `liquidacao_NUMEROLIQUIDACAO_IDX` (`NUMEROLIQUIDACAO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=183718 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `liquidacao_empenho`
--

DROP TABLE IF EXISTS `liquidacao_empenho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `liquidacao_empenho` (
  `IDEMPENHO` bigint(20) NOT NULL,
  `IDLIQUIDACAO` bigint(20) NOT NULL,
  PRIMARY KEY (`IDEMPENHO`,`IDLIQUIDACAO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagamento`
--

DROP TABLE IF EXISTS `pagamento`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento` (
  `IDPAGAMENTO` bigint(20) NOT NULL AUTO_INCREMENT,
  `NUMEROPAGAMENTO` bigint(20) NOT NULL,
  `ANOPAGAMENTO` int(11) NOT NULL,
  `ENTIDADE` varchar(500) DEFAULT NULL,
  `ANOLIQUIDACAO` int(11) DEFAULT NULL,
  `NUMEROLIQUIDACAO` bigint(20) DEFAULT NULL,
  `DATAEMISSAO` datetime DEFAULT NULL,
  `DATABORDERO` datetime DEFAULT NULL,
  `DATAPAGAMENTO` datetime DEFAULT NULL,
  `DATABAIXA` datetime DEFAULT NULL,
  `STATUS` varchar(255) DEFAULT NULL,
  `CODIGOCREDOR` varchar(255) DEFAULT NULL,
  `RAZAOSOCIAL` varchar(255) DEFAULT NULL,
  `CODIGOBANCO` varchar(255) DEFAULT NULL,
  `CODIGOAGENCIA` varchar(255) DEFAULT NULL,
  `CONTABANCARIA` varchar(255) DEFAULT NULL,
  `CONTAFINANCEIRA` varchar(255) DEFAULT NULL,
  `DESCRICAOPAGAMENTO` varchar(255) DEFAULT NULL,
  `CODIGONATUREZAPAGAMENTO` varchar(255) DEFAULT NULL,
  `DESCRICAONATUREZAPAGAMENTO` varchar(255) DEFAULT NULL,
  `NUMEROEMISSOES` varchar(255) DEFAULT NULL,
  `VALORPAGAMENTO` decimal(15,2) DEFAULT NULL,
  `TOTALCONSIGNACOES` decimal(15,2) DEFAULT NULL,
  `TOTALDESCONTO` decimal(15,2) DEFAULT NULL,
  `FORMAPAGAMENTO` varchar(255) DEFAULT NULL,
  `TIPOOPERACAOBANCARIA` varchar(255) DEFAULT NULL,
  `DOCUMENTOPAGAMENTO` varchar(255) DEFAULT NULL,
  `EVENTOCONTABIL` int(11) DEFAULT NULL,
  PRIMARY KEY (`IDPAGAMENTO`),
  KEY `pagamento_CODIGONATUREZAPAGAMENTO_IDX` (`CODIGONATUREZAPAGAMENTO`) USING BTREE,
  KEY `pagamento_CODIGOCREDOR_IDX` (`CODIGOCREDOR`) USING BTREE,
  KEY `pagamento_NUMEROLIQUIDACAO_IDX` (`NUMEROLIQUIDACAO`) USING BTREE,
  KEY `pagamento_ANOLIQUIDACAO_IDX` (`ANOLIQUIDACAO`) USING BTREE,
  KEY `pagamento_ANOPAGAMENTO_IDX` (`ANOPAGAMENTO`) USING BTREE,
  KEY `pagamento_NUMEROPAGAMENTO_IDX` (`NUMEROPAGAMENTO`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=186309 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagamento_empenho`
--

DROP TABLE IF EXISTS `pagamento_empenho`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento_empenho` (
  `IDEMPENHO` bigint(20) NOT NULL,
  `IDPAGAMENTO` bigint(20) NOT NULL,
  PRIMARY KEY (`IDEMPENHO`,`IDPAGAMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `pagamento_liquidacao`
--

DROP TABLE IF EXISTS `pagamento_liquidacao`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pagamento_liquidacao` (
  `IDLIQUIDACAO` bigint(20) NOT NULL,
  `IDPAGAMENTO` bigint(20) NOT NULL,
  PRIMARY KEY (`IDLIQUIDACAO`,`IDPAGAMENTO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receita_covid`
--

DROP TABLE IF EXISTS `receita_covid`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receita_covid` (
  `IDRECEITACOVID` int(11) NOT NULL AUTO_INCREMENT,
  `CONTAFINANCEIRA` varchar(1000) DEFAULT NULL,
  `DATAMOVIMENTO` date DEFAULT NULL,
  `ORGAO` varchar(400) DEFAULT NULL,
  `NUMERODOCUMENTO` varchar(1000) DEFAULT NULL,
  `ANODOCUMENTO` int(11) DEFAULT NULL,
  `TIPODOCUMENTO` varchar(1000) DEFAULT NULL,
  `HISTORICO` varchar(1000) DEFAULT NULL,
  `VALOR` decimal(15,2) DEFAULT NULL,
  `NATUREZA` varchar(1000) DEFAULT NULL,
  PRIMARY KEY (`IDRECEITACOVID`)
) ENGINE=InnoDB AUTO_INCREMENT=1312 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receita_geral`
--

DROP TABLE IF EXISTS `receita_geral`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receita_geral` (
  `ANO` int(11) DEFAULT NULL,
  `ORGAO` int(11) DEFAULT NULL,
  `IDENTIDADE` int(11) DEFAULT NULL,
  `ENTIDADE` varchar(400) DEFAULT NULL,
  `CODIGO_RECEITA` varchar(20) DEFAULT NULL,
  `DESCRICAO_RECEITA` varchar(400) DEFAULT NULL,
  `TIPO` varchar(400) DEFAULT NULL,
  `FONTE_RECURSO` varchar(400) DEFAULT NULL,
  `PREVISAO_INICIAL` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_JANEIRO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_FEVEREIRO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_MARÇO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_ABRIL` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_MAIO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_JUNHO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_JULHO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_AGOSTO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_SETEMBRO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_OUTUBRO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_NOVEMBRO` decimal(20,2) DEFAULT NULL,
  `ARRECADADO_DEZEMBRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_JANEIRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_FEVEREIRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_MARÇO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_ABRIL` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_MAIO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_JUNHO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_JULHO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_AGOSTO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_SETEMBRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_OUTUBRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_NOVEMBRO` decimal(20,2) DEFAULT NULL,
  `AJUSTE_RECEITA_DEZEMBRO` decimal(20,2) DEFAULT NULL,
  KEY `receita_geral_ORGAO_IDX` (`ORGAO`) USING BTREE,
  KEY `receita_geral_ANO_IDX` (`ANO`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `receitas`
--

DROP TABLE IF EXISTS `receitas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receitas` (
  `IDRECEITA` bigint(20) NOT NULL AUTO_INCREMENT,
  `IDENTIDADE` bigint(20) DEFAULT NULL,
  `ORGAO` bigint(20) DEFAULT NULL,
  `ENTIDADE` varchar(200) DEFAULT NULL,
  `ANORECEITA` int(11) DEFAULT NULL,
  `DESCRICAO_RECEITA` varchar(400) DEFAULT NULL,
  `FONTE_RECURSO` varchar(400) DEFAULT NULL,
  `ORCADOINICIAL` decimal(42,2) DEFAULT NULL,
  `RECEITAREALIZADA` decimal(53,2) DEFAULT NULL,
  `RECEITAAREALIZAR` decimal(54,2) DEFAULT NULL,
  PRIMARY KEY (`IDRECEITA`),
  KEY `receitas_ANORECEITA_IDX` (`ANORECEITA`) USING BTREE,
  KEY `receitas_ORGAO_IDX` (`ORGAO`) USING BTREE,
  KEY `receitas_IDENTIDADE_IDX` (`IDENTIDADE`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=2048 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Temporary view structure for view `servidor_pagamento`
--

DROP TABLE IF EXISTS `servidor_pagamento`;
/*!50001 DROP VIEW IF EXISTS `servidor_pagamento`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `servidor_pagamento` AS SELECT 
 1 AS `IDEMPENHO`,
 1 AS `CPFCNPJCREDOR`,
 1 AS `CPFCNPJCREDOR_`,
 1 AS `IDPAGAMENTO`,
 1 AS `ANOPAGAMENTO`,
 1 AS `ENTIDADE`,
 1 AS `DESCRICAONATUREZAPAGAMENTO`,
 1 AS `ANOLIQUIDACAO`,
 1 AS `NUMEROLIQUIDACAO`,
 1 AS `DATAPAGAMENTO`,
 1 AS `MESPAGAMENTO`,
 1 AS `STATUS`,
 1 AS `RAZAOSOCIAL`,
 1 AS `HISTORICO`,
 1 AS `VALORPAGAMENTO`*/;
SET character_set_client = @saved_cs_client;

--
-- Temporary view structure for view `tipo_contrato`
--

DROP TABLE IF EXISTS `tipo_contrato`;
/*!50001 DROP VIEW IF EXISTS `tipo_contrato`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `tipo_contrato` AS SELECT 
 1 AS `TIPOCONTRATO`*/;
SET character_set_client = @saved_cs_client;

--
-- Dumping routines for database 'transparenciaDB'
--

--
-- Final view structure for view `cargos`
--

/*!50001 DROP VIEW IF EXISTS `cargos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `cargos` AS select distinct `contratos`.`CARGOSERVIDOR` AS `CARGOSERVIDOR` from `contratos` where `contratos`.`CARGOSERVIDOR` is not null order by 1 */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `diarias`
--

/*!50001 DROP VIEW IF EXISTS `diarias`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`adriano.santos`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `diarias` AS select `p`.`IDEMPENHO` AS `IDEMPENHO`,`p`.`CPFCNPJCREDOR` AS `CPFCNPJCREDOR`,`p`.`CPFCNPJCREDOR_` AS `CPFCNPJCREDOR_`,`p`.`IDPAGAMENTO` AS `IDPAGAMENTO`,`p`.`ANOPAGAMENTO` AS `ANOPAGAMENTO`,`p`.`ENTIDADE` AS `ENTIDADE`,`p`.`ANOLIQUIDACAO` AS `ANOLIQUIDACAO`,`p`.`NUMEROLIQUIDACAO` AS `NUMEROLIQUIDACAO`,`p`.`DATAPAGAMENTO` AS `DATAPAGAMENTO`,month(`p`.`DATAPAGAMENTO`) AS `MESPAGAMENTO`,`p`.`STATUS` AS `STATUS`,`p`.`RAZAOSOCIAL` AS `RAZAOSOCIAL`,`p`.`HISTORICO` AS `HISTORICO`,`p`.`VALORPAGAMENTO` AS `VALORPAGAMENTO` from `empenho_pagamento` `p` where `p`.`DESCRICAONATUREZAPAGAMENTO` = 'DIARIAS' and `p`.`CPFCNPJCREDOR_` is not null order by '','' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empenho_liquidacao`
--

/*!50001 DROP VIEW IF EXISTS `empenho_liquidacao`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`adriano.santos`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `empenho_liquidacao` AS select `ec`.`IDEMPENHO` AS `IDEMPENHO`,`l`.`ORGAO` AS `ORGAO`,`l`.`ENTIDADE` AS `ENTIDADE`,`l`.`NUMEROEMPENHO` AS `NUMEROEMPENHO`,`l`.`ANOEMPENHO` AS `ANOEMPENHO`,`l`.`IDLIQUIDACAO` AS `IDLIQUIDACAO`,`l`.`NUMEROLIQUIDACAO` AS `NUMEROLIQUIDACAO`,`l`.`ANOLIQUIDACAO` AS `ANOLIQUIDACAO`,`l`.`DATAEMISSAO` AS `DATAEMISSAO`,`l`.`STATUS` AS `STATUS`,`l`.`NUMEROEMISSOES` AS `NUMEROEMISSOES`,`l`.`PREVISAOPAGAMENTO` AS `PREVISAOPAGAMENTO`,`l`.`DATAEMPENHO` AS `DATAEMPENHO`,`l`.`HISTORICO` AS `HISTORICO`,`l`.`TIPOEMPENHO` AS `TIPOEMPENHO`,`l`.`CODIGOCREDOR` AS `CODIGOCREDOR`,`l`.`RAZAOSOCIAL` AS `RAZAOSOCIAL`,`l`.`EXERCICIO` AS `EXERCICIO`,`l`.`UNIDADE` AS `UNIDADE`,`l`.`REDUZIDOPROGRAMATICA` AS `REDUZIDOPROGRAMATICA`,`l`.`FUNCIONALPROGRAMATICA` AS `FUNCIONALPROGRAMATICA`,`l`.`DESPESAORCAMENTARIA` AS `DESPESAORCAMENTARIA`,`l`.`FONTERECURSO` AS `FONTERECURSO`,`l`.`VALORDALIQUIDACAO` AS `VALORDALIQUIDACAO`,`l`.`ANULADOLIQUIDACAO` AS `ANULADOLIQUIDACAO`,`l`.`VALOREMPENHO` AS `VALOREMPENHO`,`l`.`TOTALALIQUIDAR` AS `TOTALALIQUIDAR`,`l`.`PAGODALIQUIDACAO` AS `PAGODALIQUIDACAO`,`l`.`TOTALAPAGAR` AS `TOTALAPAGAR`,`l`.`DESCRITIVOLIQUIDACAO` AS `DESCRITIVOLIQUIDACAO`,`l`.`TIPODOCUMENTO` AS `TIPODOCUMENTO`,`l`.`DOCUMENTOCOMPROBATORIO` AS `DOCUMENTOCOMPROBATORIO`,`l`.`ANODOCUMENTO` AS `ANODOCUMENTO`,`l`.`MESDOCUMENTO` AS `MESDOCUMENTO`,`l`.`DATADOCUMENTO` AS `DATADOCUMENTO`,`l`.`EVENTOCONTABIL` AS `EVENTOCONTABIL` from ((`liquidacao_empenho` `le` join `liquidacao` `l` on(`le`.`IDLIQUIDACAO` = `l`.`IDLIQUIDACAO`)) join `empenho_consolidado` `ec` on(`ec`.`IDEMPENHO` = `le`.`IDEMPENHO`)) order by '','' */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empenho_pagamento`
--

/*!50001 DROP VIEW IF EXISTS `empenho_pagamento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `empenho_pagamento` AS select 1 AS `IDEMPENHO`,1 AS `CPFCNPJCREDOR`,1 AS `CPFCNPJCREDOR_`,1 AS `IDPAGAMENTO`,1 AS `NUMEROPAGAMENTO`,1 AS `ANOPAGAMENTO`,1 AS `ENTIDADE`,1 AS `ANOLIQUIDACAO`,1 AS `NUMEROLIQUIDACAO`,1 AS `DATAEMISSAO`,1 AS `DATABORDERO`,1 AS `DATAPAGAMENTO`,1 AS `DATABAIXA`,1 AS `STATUS`,1 AS `CODIGOCREDOR`,1 AS `RAZAOSOCIAL`,1 AS `CODIGOBANCO`,1 AS `CODIGOAGENCIA`,1 AS `CONTABANCARIA`,1 AS `CONTAFINANCEIRA`,1 AS `DESCRICAOPAGAMENTO`,1 AS `HISTORICO`,1 AS `CODIGONATUREZAPAGAMENTO`,1 AS `DESCRICAONATUREZAPAGAMENTO`,1 AS `NUMEROEMISSOES`,1 AS `VALORPAGAMENTO`,1 AS `TOTALCONSIGNACOES`,1 AS `TOTALDESCONTO`,1 AS `FORMAPAGAMENTO`,1 AS `TIPOOPERACAOBANCARIA`,1 AS `DOCUMENTOPAGAMENTO`,1 AS `EVENTOCONTABIL` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empenho_pagamento_covid`
--

/*!50001 DROP VIEW IF EXISTS `empenho_pagamento_covid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `empenho_pagamento_covid` AS select 1 AS `IDEMPENHO`,1 AS `CPFCNPJCREDOR`,1 AS `CPFCNPJCREDOR_`,1 AS `IDPAGAMENTO`,1 AS `NUMEROPAGAMENTO`,1 AS `ANOPAGAMENTO`,1 AS `ENTIDADE`,1 AS `ANOLIQUIDACAO`,1 AS `NUMEROLIQUIDACAO`,1 AS `DATAEMISSAO`,1 AS `DATABORDERO`,1 AS `DATAPAGAMENTO`,1 AS `DATABAIXA`,1 AS `STATUS`,1 AS `CODIGOCREDOR`,1 AS `RAZAOSOCIAL`,1 AS `CODIGOBANCO`,1 AS `CODIGOAGENCIA`,1 AS `CONTABANCARIA`,1 AS `CONTAFINANCEIRA`,1 AS `DESCRICAOPAGAMENTO`,1 AS `CODIGONATUREZAPAGAMENTO`,1 AS `DESCRICAONATUREZAPAGAMENTO`,1 AS `NUMEROEMISSOES`,1 AS `VALORPAGAMENTO`,1 AS `TOTALCONSIGNACOES`,1 AS `TOTALDESCONTO`,1 AS `FORMAPAGAMENTO`,1 AS `TIPOOPERACAOBANCARIA`,1 AS `DOCUMENTOPAGAMENTO`,1 AS `EVENTOCONTABIL` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empenhos`
--

/*!50001 DROP VIEW IF EXISTS `empenhos`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `empenhos` AS select 1 AS `IDENTIDADE`,1 AS `ORGAO`,1 AS `ENTIDADE`,1 AS `IDEMPENHO`,1 AS `NUMEROEMPENHO`,1 AS `ANOEMPENHO`,1 AS `DATAEMPENHO`,1 AS `TIPOEMPENHO`,1 AS `DATAPROGRAMACAO`,1 AS `NUMEROEMISSOES`,1 AS `STATUS`,1 AS `MOTIVOEMPENHO`,1 AS `NUMEROCONTRATO`,1 AS `PEDIDOEMPENHO`,1 AS `DATAPEDIDO`,1 AS `MODALIDADELICITACAO`,1 AS `NUMEROLICITACAO`,1 AS `HISTORICO`,1 AS `CODIGOCREDOR`,1 AS `RAZAOSOCIAL`,1 AS `CPFCNPJCREDOR`,1 AS `CLASSECREDOR`,1 AS `BANCO`,1 AS `AGENCIA`,1 AS `CONTA`,1 AS `UNIDADE`,1 AS `REDUZIDOFUNCIONAL`,1 AS `FUNCIONALPROGRAMATICA`,1 AS `DESPESAORCAMENTARIA`,1 AS `FONTERECURSO`,1 AS `DETALHAMENTOFONTE`,1 AS `VALOREMPENHADO`,1 AS `NATUREZARECURSO`,1 AS `NUMEROCONVENIO`,1 AS `ANOCONVENIO`,1 AS `NUMEROPROCESSO`,1 AS `ANOPROCESSO`,1 AS `EVENTOCONTABIL`,1 AS `TOTALLIQUIDADO`,1 AS `TOTALPAGO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `empenhos_covid`
--

/*!50001 DROP VIEW IF EXISTS `empenhos_covid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `empenhos_covid` AS select 1 AS `IDENTIDADE`,1 AS `ORGAO`,1 AS `ENTIDADE`,1 AS `IDEMPENHO`,1 AS `NUMEROEMPENHO`,1 AS `ANOEMPENHO`,1 AS `DATAEMPENHO`,1 AS `TIPOEMPENHO`,1 AS `DATAPROGRAMACAO`,1 AS `NUMEROEMISSOES`,1 AS `STATUS`,1 AS `MOTIVOEMPENHO`,1 AS `NUMEROCONTRATO`,1 AS `PEDIDOEMPENHO`,1 AS `DATAPEDIDO`,1 AS `MODALIDADELICITACAO`,1 AS `NUMEROLICITACAO`,1 AS `HISTORICO`,1 AS `CODIGOCREDOR`,1 AS `RAZAOSOCIAL`,1 AS `CPFCNPJCREDOR`,1 AS `CLASSECREDOR`,1 AS `BANCO`,1 AS `AGENCIA`,1 AS `CONTA`,1 AS `UNIDADE`,1 AS `REDUZIDOFUNCIONAL`,1 AS `FUNCIONALPROGRAMATICA`,1 AS `DESPESAORCAMENTARIA`,1 AS `FONTERECURSO`,1 AS `DETALHAMENTOFONTE`,1 AS `VALOREMPENHADO`,1 AS `NATUREZARECURSO`,1 AS `NUMEROCONVENIO`,1 AS `ANOCONVENIO`,1 AS `NUMEROPROCESSO`,1 AS `ANOPROCESSO`,1 AS `EVENTOCONTABIL`,1 AS `TOTALLIQUIDADO`,1 AS `TOTALPAGO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `entidade_despesas`
--

/*!50001 DROP VIEW IF EXISTS `entidade_despesas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `entidade_despesas` AS select 1 AS `IDENTIDADE`,1 AS `ORGAO`,1 AS `ENTIDADE`,1 AS `ANOEMPENHO`,1 AS `TOTALEMPENHADO`,1 AS `TOTALLIQUIDADO`,1 AS `TOTALPAGO`,1 AS `TOTALDESPESAEXTRA` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `entidade_despesas_covid`
--

/*!50001 DROP VIEW IF EXISTS `entidade_despesas_covid`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `entidade_despesas_covid` AS select 1 AS `IDENTIDADE`,1 AS `ORGAO`,1 AS `ENTIDADE`,1 AS `ANOEMPENHO`,1 AS `TOTALEMPENHADO`,1 AS `TOTALLIQUIDADO`,1 AS `TOTALPAGO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `entidade_receitas`
--

/*!50001 DROP VIEW IF EXISTS `entidade_receitas`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `entidade_receitas` AS select 1 AS `IDENTIDADE`,1 AS `ORGAO`,1 AS `ENTIDADE`,1 AS `ANORECEITA`,1 AS `ORCADOINICIAL`,1 AS `RECEITAREALIZADA`,1 AS `RECEITAAREALIZAR` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `fornecedor`
--

/*!50001 DROP VIEW IF EXISTS `fornecedor`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `fornecedor` AS select 1 AS `CPFCNPJCREDOR`,1 AS `RAZAOSOCIAL`,1 AS `ANOEMPENHO`,1 AS `QUANTITADEEMPENHOS`,1 AS `TOTALEMPENHADO`,1 AS `TOTALLIQUIDADO`,1 AS `TOTALPAGO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `servidor_pagamento`
--

/*!50001 DROP VIEW IF EXISTS `servidor_pagamento`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `servidor_pagamento` AS select 1 AS `IDEMPENHO`,1 AS `CPFCNPJCREDOR`,1 AS `CPFCNPJCREDOR_`,1 AS `IDPAGAMENTO`,1 AS `ANOPAGAMENTO`,1 AS `ENTIDADE`,1 AS `DESCRICAONATUREZAPAGAMENTO`,1 AS `ANOLIQUIDACAO`,1 AS `NUMEROLIQUIDACAO`,1 AS `DATAPAGAMENTO`,1 AS `MESPAGAMENTO`,1 AS `STATUS`,1 AS `RAZAOSOCIAL`,1 AS `HISTORICO`,1 AS `VALORPAGAMENTO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;

--
-- Final view structure for view `tipo_contrato`
--

/*!50001 DROP VIEW IF EXISTS `tipo_contrato`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`%` SQL SECURITY DEFINER */
/*!50001 VIEW `tipo_contrato` AS select 1 AS `TIPOCONTRATO` */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-12 12:49:22
