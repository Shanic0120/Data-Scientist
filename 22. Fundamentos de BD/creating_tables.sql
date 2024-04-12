CREATE TABLE `market`.`product` (
  `product_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `sell_price` INT NOT NULL CHECK (sell_price >= 0),
  `category` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`product_id`));

CREATE TABLE `market`.`supplier` (
  `nit_supplier` INT NOT NULL CHECK (nit > 0),
  `name` VARCHAR(60) NOT NULL,
  `company` VARCHAR(60) NULL,
  `address` VARCHAR(60) NOT NULL,
  `phone` INT NOT NULL CHECK (phone > 0),
  PRIMARY KEY (`nit`),
  UNIQUE INDEX `address_UNIQUE` (`address` ASC) VISIBLE);

ALTER TABLE `market`.`supplier` 
ADD COLUMN `email` VARCHAR(45) NOT NULL AFTER `phone`,
CHANGE COLUMN `address` `address` VARCHAR(60) NULL ,
ADD UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
DROP INDEX `address_UNIQUE` ;



CREATE TABLE `market`.`product_supplier` (
  `stock` INT NOT NULL,
  `price` INT NOT NULL,
  `nit_supplier` INT NOT NULL,
  `id_product` INT NOT NULL,
  PRIMARY KEY (`id_product`, `nit_supplier`),
  INDEX `nit_supplier_idx` (`nit_supplier` ASC) VISIBLE,
  CONSTRAINT `nit_supplier`
    FOREIGN KEY (`nit_supplier`)
    REFERENCES `market`.`supplier` (`nit_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_product`
    FOREIGN KEY (`id_product`)
    REFERENCES `market`.`product` (`product_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `market`.`client` (
  `id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NULL,
  `phone` INT NOT NULL,
  `email` VARCHAR(60) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE);

CREATE TABLE `market`.`employee` (
  `employee_id` INT NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `hire_date` DATE NOT NULL,
  `salary` INT NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`employee_id`));


CREATE TABLE `market`.`bill` (
  `bill_id` INT NOT NULL AUTO_INCREMENT,
  `buy_date` TIMESTAMP NOT NULL,
  `tip` INT NOT NULL DEFAULT 0,
  `client_id` INT NOT NULL,
  `employee_id` INT NOT NULL,
  PRIMARY KEY (`bill_id`),
  INDEX `bill_client_idx` (`client_id` ASC) VISIBLE,
  INDEX `bill_employee_idx` (`employee_id` ASC) VISIBLE,
  CONSTRAINT `bill_client`
    FOREIGN KEY (`client_id`)
    REFERENCES `market`.`client` (`id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `bill_employee`
    FOREIGN KEY (`employee_id`)
    REFERENCES `market`.`employee` (`employee_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE);

CREATE TABLE `market`.`purchase` (
  `bill_id` INT NOT NULL,
  `nit_supplier` INT NOT NULL,
  `product_id` INT NOT NULL,
  `amount` INT NOT NULL DEFAULT 1,
  `discount` INT NULL DEFAULT 0,
  PRIMARY KEY (`bill_id`, `nit_supplier`, `product_id`),
  INDEX `purchase_supplier_idx` (`nit_supplier` ASC) VISIBLE,
  CONSTRAINT `purchase_bill`
    FOREIGN KEY (`bill_id`)
    REFERENCES `market`.`bill` (`bill_id`)
    ON DELETE NO ACTION
    ON UPDATE CASCADE,
  CONSTRAINT `purchase_supplier`
    FOREIGN KEY (`nit_supplier`)
    REFERENCES `market`.`product_supplier` (`nit_supplier`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);