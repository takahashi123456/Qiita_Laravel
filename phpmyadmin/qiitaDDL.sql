
-- -----------------------------------------------------
-- Schema mysql_test_db
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mysql_test_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mysql_test_db` DEFAULT CHARACTER SET utf8 ;
USE `mysql_test_db` ;

-- -----------------------------------------------------
-- Table `mysql_test_db`.`enterprises`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_test_db`.`enterprises` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `is_enable` VARCHAR(45) NULL,
  `update_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mysql_test_db`.`admins`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_test_db`.`admins` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `login_id` VARCHAR(45) NULL,
  `password` VARCHAR(256) NULL,
  `updated_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL,
  `is_enable` VARCHAR(45) NULL,
  `enterprise_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Admin_enterprise_idx` (`enterprise_id` ASC) ,
  UNIQUE INDEX `login_id_UNIQUE` (`login_id` ASC) ,
  CONSTRAINT `fk_Admin_enterprise`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `mysql_test_db`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mysql_test_db`.`users`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_test_db`.`users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `login_id` VARCHAR(45) NULL,
  `password` VARCHAR(256) NULL,
  `updated_at` TIMESTAMP NULL,
  `created_at` TIMESTAMP NULL,
  `enterprise_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_id_UNIQUE` (`login_id` ASC) ,
  INDEX `fk_user_enterprise1_idx` (`enterprise_id` ASC) ,
  CONSTRAINT `fk_user_enterprise1`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `mysql_test_db`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mysql_test_db`.`categories`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_test_db`.`categories` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `enterprise_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_group_enterprise1_idx` (`enterprise_id` ASC) ,
  CONSTRAINT `fk_group_enterprise1`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `mysql_test_db`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mysql_test_db`.`todos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mysql_test_db`.`todos` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(100) NULL,
  `content` VARCHAR(1000) NULL,
  `user_id` INT NOT NULL,
  `enterprise_id` INT NOT NULL,
  `created_at` TIMESTAMP NULL,
  `updated_at` TIMESTAMP NULL,
  `group_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_todo_user1_idx` (`user_id` ASC) ,
  INDEX `fk_todo_enterprise1_idx` (`enterprise_id` ASC) ,
  INDEX `fk_todo_group1_idx` (`group_id` ASC) ,
  CONSTRAINT `fk_todo_user1`
    FOREIGN KEY (`user_id`)
    REFERENCES `mysql_test_db`.`users` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_todo_enterprise1`
    FOREIGN KEY (`enterprise_id`)
    REFERENCES `mysql_test_db`.`enterprises` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_todo_group1`
    FOREIGN KEY (`group_id`)
    REFERENCES `mysql_test_db`.`categories` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
