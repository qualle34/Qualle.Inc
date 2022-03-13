-- MySQL Script generated by MySQL Workbench
-- Sun Mar 13 21:46:39 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema qualleinc
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `qualleinc` ;

-- -----------------------------------------------------
-- Schema qualleinc
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `qualleinc` DEFAULT CHARACTER SET utf8 ;
USE `qualleinc` ;

-- -----------------------------------------------------
-- Table `qualleinc`.`metadata`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`metadata` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`metadata` (
  `id` BIGINT NOT NULL,
  `created_at` VARCHAR(45) NULL,
  `created_by` VARCHAR(45) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`image`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`image` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`image` (
  `id` BIGINT NOT NULL,
  `name` VARCHAR(45) NULL,
  `link` VARCHAR(45) NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_image_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_image_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`user` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `lastname` VARCHAR(45) NULL,
  `phone` VARCHAR(15) NULL,
  `email` VARCHAR(45) NULL,
  `birtdate` DATE NULL,
  `image_id` BIGINT NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  `role_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_user_image1_idx` (`image_id` ASC) VISIBLE,
  INDEX `fk_user_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `qualleinc`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`credentials`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`credentials` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`credentials` (
  `user_id` BIGINT NOT NULL,
  `login` VARCHAR(45) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`user_id`),
  CONSTRAINT `creds_user_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`category`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`category` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`category` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`developer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`developer` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`developer` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `contacts` VARCHAR(45) NULL,
  `address` VARCHAR(45) NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_developer_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_developer_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`genre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`genre` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`genre` (
  `id` BIGINT NOT NULL,
  `value` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`product`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`product` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`product` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `category_id` BIGINT NOT NULL,
  `developer_id` BIGINT NOT NULL,
  `type_id` BIGINT NOT NULL,
  `genre_id` BIGINT NOT NULL,
  `image_id` BIGINT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  `price` DECIMAL(13,2) NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `game_category_fk_idx` (`category_id` ASC) VISIBLE,
  INDEX `game_developer_fk_idx` (`developer_id` ASC) VISIBLE,
  INDEX `fk_product_genre1_idx` (`genre_id` ASC) VISIBLE,
  INDEX `fk_product_image1_idx` (`image_id` ASC) VISIBLE,
  INDEX `fk_product_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `game_category_fk`
    FOREIGN KEY (`category_id`)
    REFERENCES `qualleinc`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `game_developer_fk`
    FOREIGN KEY (`developer_id`)
    REFERENCES `qualleinc`.`developer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_genre1`
    FOREIGN KEY (`genre_id`)
    REFERENCES `qualleinc`.`genre` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_image1`
    FOREIGN KEY (`image_id`)
    REFERENCES `qualleinc`.`image` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`cart` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`cart` (
  `game_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`game_id`, `user_id`),
  INDEX `cg_game_fk_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_product_cart_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `cg_game_fk`
    FOREIGN KEY (`game_id`)
    REFERENCES `qualleinc`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_cart_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`card` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`card` (
  `id` BIGINT NOT NULL,
  `number` VARCHAR(45) NULL,
  `date` VARCHAR(45) NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_card_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_card_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`purchases`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`purchases` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`purchases` (
  `user_id` BIGINT NOT NULL,
  `game_id` BIGINT NOT NULL,
  `card_id` BIGINT NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`user_id`, `game_id`),
  INDEX `ug_game_fk_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_purchases_card1_idx` (`card_id` ASC) VISIBLE,
  INDEX `fk_purchases_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `ug_user_fk`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `ug_game_fk`
    FOREIGN KEY (`game_id`)
    REFERENCES `qualleinc`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchases_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `qualleinc`.`card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_purchases_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`feedback` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`feedback` (
  `id` BIGINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NOT NULL,
  `file` VARCHAR(255) NOT NULL,
  `user_id` BIGINT NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`, `user_id`),
  INDEX `fk_feedback_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_feedback_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_feedback_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_feedback_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`cart`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`cart` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`cart` (
  `game_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
  PRIMARY KEY (`game_id`, `user_id`),
  INDEX `cg_game_fk_idx` (`game_id` ASC) VISIBLE,
  INDEX `fk_product_cart_user1_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `cg_game_fk`
    FOREIGN KEY (`game_id`)
    REFERENCES `qualleinc`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_cart_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`review` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`review` (
  `id` BIGINT NOT NULL,
  `text` VARCHAR(45) NULL,
  `score` INT NOT NULL,
  `user_id` BIGINT NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_review_user1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_review_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_review_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_review_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`product_review`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`product_review` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`product_review` (
  `product_id` BIGINT NOT NULL,
  `review_id` BIGINT NOT NULL,
  INDEX `fk_product_review_product1_idx` (`product_id` ASC) VISIBLE,
  INDEX `fk_product_review_review1_idx` (`review_id` ASC) VISIBLE,
  PRIMARY KEY (`product_id`, `review_id`),
  CONSTRAINT `fk_product_review_product1`
    FOREIGN KEY (`product_id`)
    REFERENCES `qualleinc`.`product` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_product_review_review1`
    FOREIGN KEY (`review_id`)
    REFERENCES `qualleinc`.`review` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`user_card`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`user_card` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`user_card` (
  `card_id` BIGINT NOT NULL,
  `user_id` BIGINT NOT NULL,
  INDEX `fk_user_card_card1_idx` (`card_id` ASC) VISIBLE,
  INDEX `fk_user_card_user1_idx` (`user_id` ASC) VISIBLE,
  PRIMARY KEY (`card_id`, `user_id`),
  CONSTRAINT `fk_user_card_card1`
    FOREIGN KEY (`card_id`)
    REFERENCES `qualleinc`.`card` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_card_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `qualleinc`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `qualleinc`.`vacancy`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `qualleinc`.`vacancy` ;

CREATE TABLE IF NOT EXISTS `qualleinc`.`vacancy` (
  `id` BIGINT NOT NULL,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NOT NULL,
  `metadata_id` BIGINT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_vacancy_metadata1_idx` (`metadata_id` ASC) VISIBLE,
  CONSTRAINT `fk_vacancy_metadata1`
    FOREIGN KEY (`metadata_id`)
    REFERENCES `qualleinc`.`metadata` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
