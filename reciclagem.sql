DROP DATABASE IF EXISTS `reciclagem`;
CREATE DATABASE `reciclagem`;
USE `reciclagem`;

--
-- Banco de dados: `reciclagem`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `cliente`
--

CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `telefone` int(20) NOT NULL,
  `contribuinte` int(30) NOT NULL,
  `data_nascimento` datetime NOT NULL,
  `email` varchar(100) NOT NULL,
  `pais` varchar(50) NOT NULL,
  `cidade` varchar(50) NOT NULL,
  `morada` varchar(100) NOT NULL,
  `codigo_postal` varchar(8) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `materia_prima`
--

CREATE TABLE `materia_prima` (
  `id_materia_prima` int(11) NOT NULL,
  `quantidade_recebida` int(255) NOT NULL,
  `fatura_cliente` decimal(19,2) NOT NULL,
  `data` date NOT NULL,
  `cliente_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `newsletter`
--

CREATE TABLE `newsletter` (
  `id_newsletter` int(11) NOT NULL,
  `data` date NOT NULL,
  `produto_fk` int(11) NOT NULL,
  `cliente_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE `produto` (
  `id_produto` int(11) NOT NULL,
  `nome` varchar(50) NOT NULL,
  `preco` decimal(19,2) NOT NULL,
  `website` varchar(255) NOT NULL,
  `tamanho` int(11) NOT NULL,
  `data` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `stock`
--

CREATE TABLE `stock` (
  `id_stock` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  `localizacao` varchar(50) NOT NULL,
  `produto_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendas`
--

CREATE TABLE `vendas` (
  `id_vendas` int(11) NOT NULL,
  `cliente_fk` int(11) NOT NULL,
  `produto_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Estrutura da tabela `venda_valor`
--

CREATE TABLE `venda_valor` (
  `id_venda_valor` int(11) NOT NULL,
  `quantidade_vendida` int(11) NOT NULL,
  `valor_pagar` decimal(19,2) NOT NULL,
  `vendas_fk` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Índices para tabelas despejadas
--

--
-- Índices para tabela `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`id_cliente`);

--
-- Índices para tabela `materia_prima`
--
ALTER TABLE `materia_prima`
  ADD PRIMARY KEY (`id_materia_prima`),
  ADD KEY `materia_prima_fk` (`cliente_fk`),
  ADD KEY `cliente_fk` (`cliente_fk`);

--
-- Índices para tabela `newsletter`
--
ALTER TABLE `newsletter`
  ADD PRIMARY KEY (`id_newsletter`),
  ADD KEY `produto_fk` (`produto_fk`),
  ADD KEY `cliente_fk` (`cliente_fk`);

--
-- Índices para tabela `produto`
--
ALTER TABLE `produto`
  ADD PRIMARY KEY (`id_produto`);

--
-- Índices para tabela `stock`
--
ALTER TABLE `stock`
  ADD PRIMARY KEY (`id_stock`),
  ADD KEY `produto_fk` (`produto_fk`) USING BTREE;

--
-- Índices para tabela `vendas`
--
ALTER TABLE `vendas`
  ADD PRIMARY KEY (`id_vendas`),
  ADD KEY `cliente_fk` (`cliente_fk`),
  ADD KEY `produto_fk` (`produto_fk`);

--
-- Índices para tabela `venda_valor`
--
ALTER TABLE `venda_valor`
  ADD PRIMARY KEY (`id_venda_valor`),
  ADD KEY `vendas_fk` (`vendas_fk`);

--
-- AUTO_INCREMENT de tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `cliente`
--
ALTER TABLE `cliente`
  MODIFY `id_cliente` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `materia_prima`
--
ALTER TABLE `materia_prima`
  MODIFY `id_materia_prima` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `newsletter`
--
ALTER TABLE `newsletter`
  MODIFY `id_newsletter` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `produto`
--
ALTER TABLE `produto`
  MODIFY `id_produto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `stock`
--
ALTER TABLE `stock`
  MODIFY `id_stock` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `vendas`
--
ALTER TABLE `vendas`
  MODIFY `id_vendas` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `venda_valor`
--
ALTER TABLE `venda_valor`
  MODIFY `id_venda_valor` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `materia_prima`
--
ALTER TABLE `materia_prima`
  ADD CONSTRAINT `materia_prima_fk` FOREIGN KEY (`cliente_fk`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `newsletter`
--
ALTER TABLE `newsletter`
  ADD CONSTRAINT `cliente_fk` FOREIGN KEY (`cliente_fk`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `produto_fk` FOREIGN KEY (`cliente_fk`) REFERENCES `produto` (`id_produto`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `stock`
--
ALTER TABLE `stock`
  ADD CONSTRAINT `id_produto` FOREIGN KEY (`produto_fk`) REFERENCES `produto` (`id_produto`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `vendas`
--
ALTER TABLE `vendas`
  ADD CONSTRAINT `cliente` FOREIGN KEY (`cliente_fk`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE,
  ADD CONSTRAINT `produto` FOREIGN KEY (`produto_fk`) REFERENCES `produto` (`id_produto`) ON UPDATE CASCADE;

--
-- Limitadores para a tabela `venda_valor`
--
ALTER TABLE `venda_valor`
  ADD CONSTRAINT `vendas` FOREIGN KEY (`vendas_fk`) REFERENCES `vendas` (`id_vendas`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
