/*
 Navicat Premium Dump SQL

 Source Server         : MySQL-8.0.20
 Source Server Type    : MySQL
 Source Server Version : 80042 (8.0.42)
 Source Host           : localhost:3307
 Source Schema         : aquar-aipex

 Target Server Type    : MySQL
 Target Server Version : 80042 (8.0.42)
 File Encoding         : 65001

 Date: 17/12/2025 17:21:27
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for api_billing_record
-- ----------------------------
DROP TABLE IF EXISTS `api_billing_record`;
CREATE TABLE `api_billing_record` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) DEFAULT NULL,
  `api_id` int DEFAULT NULL,
  `dynamic_api_id` int DEFAULT NULL,
  `billing_model` int DEFAULT NULL,
  `quantity` int DEFAULT NULL,
  `unit_price` decimal(10,2) DEFAULT NULL,
  `total_amount` decimal(10,2) DEFAULT NULL,
  `called_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_app_id` (`app_id`),
  KEY `idx_api_id` (`api_id`),
  KEY `idx_dynameic_id` (`dynamic_api_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of api_billing_record
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for api_key
-- ----------------------------
DROP TABLE IF EXISTS `api_key`;
CREATE TABLE `api_key` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `key_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'apikey',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci COMMENT '描述',
  `app_id` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '应用id',
  `status` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT 'AVTIVE' COMMENT '状态：AVTIVE\\DISABLE',
  `create_at` varchar(30) DEFAULT NULL COMMENT '创建时间',
  `last_used_at` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL COMMENT '最近一次调用时间',
  `expire_at` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci DEFAULT NULL,
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE KEY `keyname` (`key_name`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of api_key
-- ----------------------------
BEGIN;
INSERT INTO `api_key` (`id`, `name`, `key_name`, `description`, `app_id`, `status`, `create_at`, `last_used_at`, `expire_at`) VALUES (17, '20251217', 'kf_api_E1Hp1lx5YsdemdDMD1Ej22YeEm887Vd9', '', 'baas_3lCJhAzWQ77Bo2xf', 'ACTIVE', '2025-12-17 17:17:22', NULL, '2027-11-19 00:00:00');
COMMIT;

-- ----------------------------
-- Table structure for api_market
-- ----------------------------
DROP TABLE IF EXISTS `api_market`;
CREATE TABLE `api_market` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider_id` int DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `description` varchar(1000) NOT NULL,
  `category` varchar(255) DEFAULT NULL,
  `url` varchar(1000) NOT NULL,
  `method` int NOT NULL,
  `protocol` int NOT NULL,
  `auth_type` varchar(255) DEFAULT NULL,
  `auth_config` varchar(2000) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `body_type` int DEFAULT NULL,
  `body_template` varchar(1000) DEFAULT NULL,
  `headers` varchar(1000) DEFAULT NULL,
  `data_path` varchar(255) DEFAULT NULL,
  `data_type` int DEFAULT NULL,
  `data_row` varchar(1000) DEFAULT NULL,
  `var_row` varchar(1000) DEFAULT NULL,
  `status` int DEFAULT '0',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `is_billing` int DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of api_market
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for api_pricing
-- ----------------------------
DROP TABLE IF EXISTS `api_pricing`;
CREATE TABLE `api_pricing` (
  `id` int NOT NULL AUTO_INCREMENT,
  `market_id` int NOT NULL,
  `pricing_model` int DEFAULT '0',
  `unit_price` decimal(10,2) DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=62 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of api_pricing
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for app_info
-- ----------------------------
DROP TABLE IF EXISTS `app_info`;
CREATE TABLE `app_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `app_name` varchar(128) NOT NULL,
  `icon_url` text,
  `need_auth` tinyint(1) DEFAULT '1',
  `auth_table` text,
  `enable_permission` tinyint(1) DEFAULT '0',
  `enable_web_console` tinyint(1) DEFAULT '0',
  `status` varchar(32) DEFAULT 'active',
  `description` text,
  `config_json` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `owner` bigint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `app_id` (`app_id`),
  KEY `idx_app_info_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1477 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_info
-- ----------------------------
BEGIN;
INSERT INTO `app_info` (`id`, `app_id`, `app_name`, `icon_url`, `need_auth`, `auth_table`, `enable_permission`, `enable_web_console`, `status`, `description`, `config_json`, `created_at`, `updated_at`, `owner`) VALUES (1476, 'baas_3lCJhAzWQ77Bo2xf', '4545', NULL, 0, NULL, 0, 0, 'active', NULL, '{}', '2025-12-17 17:11:56', '2025-12-17 17:11:56', 105);
COMMIT;

-- ----------------------------
-- Table structure for app_requirement_sql
-- ----------------------------
DROP TABLE IF EXISTS `app_requirement_sql`;
CREATE TABLE `app_requirement_sql` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `requirement_id` varchar(64) NOT NULL,
  `content` longtext,
  `back_content` text,
  `dsl_content` longtext,
  `version` int DEFAULT '1',
  `status` varchar(32) DEFAULT 'draft',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_app_id_and_status` (`app_id`,`status`),
  KEY `idx_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=1511 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_requirement_sql
-- ----------------------------
BEGIN;
INSERT INTO `app_requirement_sql` (`id`, `app_id`, `requirement_id`, `content`, `back_content`, `dsl_content`, `version`, `status`, `created_at`, `updated_at`) VALUES (1510, 'baas_3lCJhAzWQ77Bo2xf', '0', 'CREATE TABLE IF NOT EXISTS `baas_3lCJhAzWQ77Bo2xf`.`static_resources` (\n`resource_id` INT NOT NULL  AUTO_INCREMENT  COMMENT \'主键\',\n`resource_type` VARCHAR(512) COMMENT \'resource_type\',\n`resource_name` VARCHAR(512) COMMENT \'resource_name\',\n`resource_path` VARCHAR(512) COMMENT \'resource_path\',\n`related_table_name` VARCHAR(512) COMMENT \'related_table_name\',\n`relate_table_column_name` VARCHAR(512) COMMENT \'relate_table_column_name\',\n`related_table_key` VARCHAR(512) COMMENT \'related_table_key\',\nPRIMARY KEY (`resource_id`)\n) COMMENT=\'资源表\';\n\nCREATE TABLE IF NOT EXISTS `baas_3lCJhAzWQ77Bo2xf`.`login` (\n`login_id` INT NOT NULL  AUTO_INCREMENT  COMMENT \'主键\',\n`relevance_id` VARCHAR(512) COMMENT \'relevance_id\',\n`relevance_table` VARCHAR(512) COMMENT \'relevance_table\',\n`wx_open_id` VARCHAR(512) COMMENT \'wx_open_id\',\n`phone_number` VARCHAR(512) COMMENT \'phone_number\',\n`user_name` VARCHAR(512) COMMENT \'user_name\',\n`password` VARCHAR(512) COMMENT \'password\',\nPRIMARY KEY (`login_id`)\n) COMMENT=\'登录表\';\n\nCREATE TABLE IF NOT EXISTS `baas_3lCJhAzWQ77Bo2xf`.`kf_system_config` (\n`id` INT NOT NULL  AUTO_INCREMENT  COMMENT \'主键\',\n`name` VARCHAR(512) COMMENT \'name\',\n`chinese_name` VARCHAR(512) COMMENT \'chinese_name\',\n`description` VARCHAR(512) COMMENT \'description\',\n`content` VARCHAR(512) COMMENT \'content\',\n`remark` VARCHAR(512) COMMENT \'remark\',\n`type` VARCHAR(512) COMMENT \'type\',\nPRIMARY KEY (`id`)\n) COMMENT=\'系统配置表\';\n', NULL, '{}', 1, 'draft', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
COMMIT;

-- ----------------------------
-- Table structure for app_sql_execution_log
-- ----------------------------
DROP TABLE IF EXISTS `app_sql_execution_log`;
CREATE TABLE `app_sql_execution_log` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `requirement_id` varchar(64) NOT NULL,
  `sql_content` text NOT NULL,
  `executed_by` varchar(64) DEFAULT NULL,
  `executed_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `success` tinyint(1) DEFAULT '1',
  `error_message` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_sql_execution_log
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for app_table_column_info
-- ----------------------------
DROP TABLE IF EXISTS `app_table_column_info`;
CREATE TABLE `app_table_column_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `requirement_id` varchar(64) NOT NULL,
  `table_id` bigint NOT NULL,
  `column_name` varchar(128) NOT NULL,
  `column_type` varchar(64) NOT NULL,
  `dsl_type` varchar(64) DEFAULT NULL,
  `is_primary` tinyint(1) DEFAULT '0',
  `is_nullable` tinyint(1) DEFAULT '1',
  `is_show` tinyint(1) DEFAULT '0',
  `default_value` text,
  `column_comment` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_app_id_and_requirement_id` (`app_id`,`requirement_id`),
  KEY `idx_table_id` (`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=95086 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_table_column_info
-- ----------------------------
BEGIN;
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95065, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'resource_id', 'INT', 'int', 1, 0, 0, NULL, '主键', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95066, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'resource_type', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'resource_type', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95067, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'resource_name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'resource_name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95068, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'resource_path', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'resource_path', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95069, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'related_table_name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'related_table_name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95070, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'relate_table_column_name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'relate_table_column_name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95071, 'baas_3lCJhAzWQ77Bo2xf', '0', 15193, 'related_table_key', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'related_table_key', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95072, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'login_id', 'INT', 'int', 1, 0, 0, NULL, '主键', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95073, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'relevance_id', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'relevance_id', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95074, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'relevance_table', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'relevance_table', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95075, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'wx_open_id', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'wx_open_id', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95076, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'phone_number', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'phone_number', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95077, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'user_name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'user_name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95078, 'baas_3lCJhAzWQ77Bo2xf', '0', 15194, 'password', 'VARCHAR(512)', 'password', 0, 1, 0, NULL, 'password', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95079, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'id', 'INT', 'int', 1, 0, 0, NULL, '主键', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95080, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95081, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'chinese_name', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'chinese_name', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95082, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'description', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'description', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95083, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'content', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'content', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95084, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'remark', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'remark', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_column_info` (`id`, `app_id`, `requirement_id`, `table_id`, `column_name`, `column_type`, `dsl_type`, `is_primary`, `is_nullable`, `is_show`, `default_value`, `column_comment`, `created_at`, `updated_at`) VALUES (95085, 'baas_3lCJhAzWQ77Bo2xf', '0', 15195, 'type', 'VARCHAR(512)', 'keyword', 0, 1, 0, NULL, 'type', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
COMMIT;

-- ----------------------------
-- Table structure for app_table_info
-- ----------------------------
DROP TABLE IF EXISTS `app_table_info`;
CREATE TABLE `app_table_info` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `requirement_id` varchar(64) NOT NULL,
  `table_name` varchar(128) NOT NULL,
  `physical_table_name` varchar(128) NOT NULL,
  `description` text,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_app_id_and_requirement_id` (`app_id`,`requirement_id`)
) ENGINE=InnoDB AUTO_INCREMENT=15196 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_table_info
-- ----------------------------
BEGIN;
INSERT INTO `app_table_info` (`id`, `app_id`, `requirement_id`, `table_name`, `physical_table_name`, `description`, `created_at`, `updated_at`) VALUES (15193, 'baas_3lCJhAzWQ77Bo2xf', '0', 'static_resources', 'static_resources', '资源表', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_info` (`id`, `app_id`, `requirement_id`, `table_name`, `physical_table_name`, `description`, `created_at`, `updated_at`) VALUES (15194, 'baas_3lCJhAzWQ77Bo2xf', '0', 'login', 'login', '登录表', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
INSERT INTO `app_table_info` (`id`, `app_id`, `requirement_id`, `table_name`, `physical_table_name`, `description`, `created_at`, `updated_at`) VALUES (15195, 'baas_3lCJhAzWQ77Bo2xf', '0', 'kf_system_config', 'kf_system_config', '系统配置表', '2025-12-17 17:11:56', '2025-12-17 17:11:56');
COMMIT;

-- ----------------------------
-- Table structure for app_table_relation
-- ----------------------------
DROP TABLE IF EXISTS `app_table_relation`;
CREATE TABLE `app_table_relation` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app_id` varchar(64) NOT NULL,
  `requirement_id` varchar(64) NOT NULL,
  `primary_table_id` bigint NOT NULL,
  `primary_table_column_id` bigint NOT NULL,
  `table_id` bigint NOT NULL,
  `table_column_id` bigint NOT NULL,
  `relation_type` varchar(32) DEFAULT 'ONE_TO_MANY',
  `on_delete` varchar(32) DEFAULT 'NO ACTION',
  `on_update` varchar(32) DEFAULT 'NO ACTION',
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_api_id` (`app_id`,`table_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10486 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of app_table_relation
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for delay_task_app_info
-- ----------------------------
DROP TABLE IF EXISTS `delay_task_app_info`;
CREATE TABLE `delay_task_app_info` (
  `id` bigint NOT NULL,
  `app_id` varchar(64) NOT NULL COMMENT '延迟任务对应的数据表',
  `task_id` int NOT NULL COMMENT '对应库中的延迟任务',
  `task_status` varchar(32) NOT NULL COMMENT '任务状态',
  `service_name` varchar(255) DEFAULT NULL COMMENT '执行的服务名称',
  KEY `delay_task_app_info_service_name_index` (`service_name`),
  KEY `idx_app_id` (`app_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='延迟任务对应的database信息';

-- ----------------------------
-- Records of delay_task_app_info
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for dynamic_api_setting
-- ----------------------------
DROP TABLE IF EXISTS `dynamic_api_setting`;
CREATE TABLE `dynamic_api_setting` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_id` varchar(255) NOT NULL,
  `key_name` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `url` varchar(255) DEFAULT NULL,
  `token` varchar(255) DEFAULT NULL,
  `method` varchar(255) DEFAULT NULL,
  `body_type` varchar(255) DEFAULT NULL,
  `body_template` text,
  `header` text,
  `protocol` varchar(255) DEFAULT NULL,
  `data_path` varchar(255) DEFAULT '',
  `data_type` varchar(255) DEFAULT '',
  `show` tinyint DEFAULT '0',
  `data_raw` text,
  `var_raw` text,
  `market_id` int DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_app_id` (`app_id`)
) ENGINE=InnoDB AUTO_INCREMENT=33745 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of dynamic_api_setting
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for user_balance
-- ----------------------------
DROP TABLE IF EXISTS `user_balance`;
CREATE TABLE `user_balance` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `balance` decimal(12,2) DEFAULT '0.00',
  `frozen_balance` decimal(12,2) DEFAULT '0.00',
  `status` int DEFAULT NULL,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `idx_user_id` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of user_balance
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `last_login_time` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `created_at` datetime DEFAULT CURRENT_TIMESTAMP,
  `nick_name` varchar(255) DEFAULT NULL,
  `avator` varchar(255) DEFAULT NULL,
  `codeflying_user_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_codeflying_user_id` (`codeflying_user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=106 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO `users` (`id`, `email`, `phone`, `password`, `last_login_time`, `created_at`, `nick_name`, `avator`, `codeflying_user_id`) VALUES (105, 'myslayers@163.com', NULL, '$2a$10$MdxNjaSk4E5jyEMu2gCiwuwOOLOSOxaOFURPkwQAPNyLqbzVgwDtW', '2025-12-17 17:09:03', '2025-12-17 17:09:03', NULL, NULL, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
