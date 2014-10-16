SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `flags` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `flags` ;

-- -----------------------------------------------------
-- Table `flags`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(255) NOT NULL,
  `username` VARCHAR(45) NOT NULL,
  `password_hash` VARCHAR(255) NOT NULL,
  `create_ip` VARCHAR(15) NOT NULL,
  `create_date` TIMESTAMP NOT NULL,
  `last_ip` VARCHAR(15) NULL,
  `last_date` TIMESTAMP NULL,
  `failed_attempts` INT NULL,
  `last_failed_ip` VARCHAR(15) NULL,
  `last_failed_date` TIMESTAMP NULL,
  `verify_code` VARCHAR(255) NOT NULL,
  `verified` TINYINT(1) NOT NULL,
  `public_profile` TINYINT(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`password_reset_request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`password_reset_request` (
  `user_id` INT NOT NULL,
  `code` VARCHAR(255) NOT NULL,
  `date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`, `code`, `date`),
  CONSTRAINT `password_reset_request-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `date_designed` DATE NULL,
  `reference_link` VARCHAR(500) NULL,
  `description` VARCHAR(2000) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_vote`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_vote` (
  `user_id` INT NOT NULL,
  `flag_id_winner` INT NOT NULL,
  `flag_id_loser` INT NOT NULL,
  `vote_date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`, `flag_id_winner`, `flag_id_loser`),
  INDEX `flag_vote-winner_idx` (`flag_id_winner` ASC),
  INDEX `flag_vote-loser_idx` (`flag_id_loser` ASC),
  CONSTRAINT `flag_vote-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_vote-winner`
    FOREIGN KEY (`flag_id_winner`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_vote-loser`
    FOREIGN KEY (`flag_id_loser`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`shape_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`shape_count` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_shape_count`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_shape_count` (
  `user_id` INT NOT NULL,
  `flag_id` INT NOT NULL,
  `shape_count` INT NOT NULL,
  `date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`, `flag_id`, `shape_count`),
  INDEX `flag_shape_count-flag_idx` (`flag_id` ASC),
  INDEX `flag_shape_count-shape_count_idx` (`shape_count` ASC),
  CONSTRAINT `flag_shape_count-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_shape_count-flag`
    FOREIGN KEY (`flag_id`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_shape_count-shape_count`
    FOREIGN KEY (`shape_count`)
    REFERENCES `flags`.`shape_count` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`color` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `hex` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC),
  UNIQUE INDEX `hex_UNIQUE` (`hex` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_color`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_color` (
  `user_id` INT NOT NULL,
  `flag_id` INT NOT NULL,
  `color_id` INT NOT NULL,
  `date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`flag_id`, `user_id`, `color_id`),
  INDEX `flag_color-user_idx` (`user_id` ASC),
  INDEX `flag_color-color_idx` (`color_id` ASC),
  CONSTRAINT `flag_color-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_color-flag`
    FOREIGN KEY (`flag_id`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_color-color`
    FOREIGN KEY (`color_id`)
    REFERENCES `flags`.`color` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`intricacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`intricacy` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_intricacy`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_intricacy` (
  `user_id` INT NOT NULL,
  `flag_id` INT NOT NULL,
  `intricacy_id` INT NOT NULL,
  `date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`, `intricacy_id`, `flag_id`),
  INDEX `flag_intricacy-flag_idx` (`flag_id` ASC),
  INDEX `flag_intricacy-intricacy_idx` (`intricacy_id` ASC),
  CONSTRAINT `flag_intricacy-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_intricacy-flag`
    FOREIGN KEY (`flag_id`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_intricacy-intricacy`
    FOREIGN KEY (`intricacy_id`)
    REFERENCES `flags`.`intricacy` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`characteristic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`characteristic` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_UNIQUE` (`name` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_characteristic`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_characteristic` (
  `user_id` INT NOT NULL,
  `flag_id` INT NOT NULL,
  `characteristic_id` INT NOT NULL,
  `date` TIMESTAMP NOT NULL,
  PRIMARY KEY (`user_id`, `flag_id`, `characteristic_id`),
  INDEX `flag_characteristic-flag_idx` (`flag_id` ASC),
  INDEX `flag_characteristic-characteristic_idx` (`characteristic_id` ASC),
  CONSTRAINT `flag_characteristic-user`
    FOREIGN KEY (`user_id`)
    REFERENCES `flags`.`user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_characteristic-flag`
    FOREIGN KEY (`flag_id`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_characteristic-characteristic`
    FOREIGN KEY (`characteristic_id`)
    REFERENCES `flags`.`characteristic` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`category` (
  `id` INT NOT NULL,
  `name` VARCHAR(200) NOT NULL,
  `description` VARCHAR(2000) NULL,
  `reference_link` VARCHAR(500) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `flags`.`flag_category`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `flags`.`flag_category` (
  `flag_id` INT NOT NULL,
  `category_id` INT NOT NULL,
  PRIMARY KEY (`flag_id`, `category_id`),
  INDEX `flag_category-category_idx` (`category_id` ASC),
  CONSTRAINT `flag_category-flag`
    FOREIGN KEY (`flag_id`)
    REFERENCES `flags`.`flag` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `flag_category-category`
    FOREIGN KEY (`category_id`)
    REFERENCES `flags`.`category` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
