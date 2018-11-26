/*
Navicat MySQL Data Transfer

Source Server         : 120.24.242.243-stxy
Source Server Version : 50536
Source Host           : 120.24.242.243:3306
Source Database       : new_wuliancard

Target Server Type    : MYSQL
Target Server Version : 50536
File Encoding         : 65001

Date: 2018-11-26 08:57:59
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for cms_file
-- ----------------------------
DROP TABLE IF EXISTS `cms_file`;
CREATE TABLE `cms_file` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `type` int(11) DEFAULT NULL COMMENT '文件类型',
  `url` varchar(200) DEFAULT NULL COMMENT 'URL地址',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=147 DEFAULT CHARSET=utf8 COMMENT='文件上传';

-- ----------------------------
-- Table structure for m_agency_client_detail
-- ----------------------------
DROP TABLE IF EXISTS `m_agency_client_detail`;
CREATE TABLE `m_agency_client_detail` (
  `client_id` int(11) unsigned zerofill NOT NULL COMMENT '代理客户主键',
  `agency_level` char(1) NOT NULL COMMENT '代理级别 1 一级代理 2 二级代理 3 三级代理',
  `parent_client_id` int(11) unsigned zerofill NOT NULL COMMENT '我的上级代理 , 一级代理的为业务员id  ',
  `total_income` float(12,2) NOT NULL DEFAULT '0.00' COMMENT '代理收入总额',
  `surplus_income` float(12,2) NOT NULL DEFAULT '0.00' COMMENT '剩余未体现金额',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代理客户详情表';

-- ----------------------------
-- Table structure for m_ageny_commission
-- ----------------------------
DROP TABLE IF EXISTS `m_ageny_commission`;
CREATE TABLE `m_ageny_commission` (
  `commission_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 ',
  `create_client_id` int(11) NOT NULL COMMENT '创建者id <创建者客户id>',
  `package_id` int(11) NOT NULL COMMENT '流量包id',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `commission_rate` int(100) NOT NULL DEFAULT '0' COMMENT ' 提成比例 , 0 表示没有提成',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`commission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理提成表';

-- ----------------------------
-- Table structure for m_ageny_extract
-- ----------------------------
DROP TABLE IF EXISTS `m_ageny_extract`;
CREATE TABLE `m_ageny_extract` (
  `extract_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 提取记录id ',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `extract_money` int(11) NOT NULL COMMENT '提取金额',
  `extract_status` char(1) NOT NULL DEFAULT '0' COMMENT '0 审批中  0 提取完成',
  `extract_time` datetime DEFAULT NULL COMMENT '结算时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`extract_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理收益提取表';

-- ----------------------------
-- Table structure for m_ageny_income
-- ----------------------------
DROP TABLE IF EXISTS `m_ageny_income`;
CREATE TABLE `m_ageny_income` (
  `income_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 收益id ',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `income_money` int(11) NOT NULL COMMENT '收益金额',
  `user_id` int(11) NOT NULL COMMENT '收益来源',
  `income_status` char(1) NOT NULL DEFAULT '0' COMMENT '0 未核算至月收益表 1 已核算',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`income_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理收益表';

-- ----------------------------
-- Table structure for m_ageny_month_income
-- ----------------------------
DROP TABLE IF EXISTS `m_ageny_month_income`;
CREATE TABLE `m_ageny_month_income` (
  `month_income_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 收益id ',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `income_month` date DEFAULT NULL COMMENT '收益月份',
  `income_money` int(11) NOT NULL COMMENT '收益金额',
  `clear_money` int(11) NOT NULL COMMENT '结算金额',
  `user_id` char(1) NOT NULL DEFAULT '0' COMMENT '收益状态 1 已结算 0 未结算',
  `clear_time` datetime DEFAULT NULL COMMENT '结算时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`month_income_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='代理月收益表';

-- ----------------------------
-- Table structure for m_client
-- ----------------------------
DROP TABLE IF EXISTS `m_client`;
CREATE TABLE `m_client` (
  `client_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键',
  `login_name` varchar(32) NOT NULL COMMENT '客户登录名',
  `login_pwd` varchar(60) NOT NULL COMMENT '登录密码 加密',
  `client_name` varchar(40) DEFAULT NULL COMMENT '客户名称(公司名称或者办理员)',
  `client_mobile` varchar(13) DEFAULT NULL COMMENT '联系电话',
  `create_user_id` int(11) NOT NULL COMMENT '卡户用户id 关联用户 管理员和运营人员',
  `client_type` varchar(2) NOT NULL COMMENT '客户类型 0 企业客户 1 代理商',
  `client_email` varchar(50) NOT NULL COMMENT '客户邮箱 ,用于通知客户欠款 , 或者提款 , 月收益信息等',
  `client_status` char(1) NOT NULL COMMENT '客户状态 : 0 审批中 1 正常(审批通过) 2 停用',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业客户-代理商表';

-- ----------------------------
-- Table structure for m_client_card_relation
-- ----------------------------
DROP TABLE IF EXISTS `m_client_card_relation`;
CREATE TABLE `m_client_card_relation` (
  `relation_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键关系',
  `client_id` int(11) NOT NULL COMMENT '代理客户 or 企业客户id',
  `card_id` int(11) NOT NULL COMMENT '卡id',
  `own_client_id` int(11) NOT NULL COMMENT '卡所属客户id',
  `type` char(1) NOT NULL COMMENT ' 0 自有  1 代理',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`relation_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物联网卡与客户绑定关系表';

-- ----------------------------
-- Table structure for m_company_client_aspect
-- ----------------------------
DROP TABLE IF EXISTS `m_company_client_aspect`;
CREATE TABLE `m_company_client_aspect` (
  `aspect_id` int(11) unsigned zerofill NOT NULL COMMENT '主键id',
  `clientid` int(11) NOT NULL COMMENT '企业客户id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`aspect_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业客户接口配置表';

-- ----------------------------
-- Table structure for m_company_client_detail
-- ----------------------------
DROP TABLE IF EXISTS `m_company_client_detail`;
CREATE TABLE `m_company_client_detail` (
  `client_id` int(11) unsigned zerofill NOT NULL COMMENT '企业客户主键',
  `business_photo_url` varchar(100) NOT NULL COMMENT '营业执照 照片url',
  `mobile` varchar(13) NOT NULL COMMENT '联系电话  可以是手机 也可以是座机',
  `credit` float(8,2) NOT NULL DEFAULT '0.00' COMMENT '信用度 余额最大负数',
  `balance` float(10,2) NOT NULL DEFAULT '0.00' COMMENT '客户余额, 后付费用户 可以为负数',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`client_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='企业客户详情表';

-- ----------------------------
-- Table structure for m_company_client_pay
-- ----------------------------
DROP TABLE IF EXISTS `m_company_client_pay`;
CREATE TABLE `m_company_client_pay` (
  `pay_id` int(11) unsigned zerofill NOT NULL COMMENT '充值记录id',
  `clientid` int(11) NOT NULL COMMENT '企业客户id',
  `total_pay` float(12,2) NOT NULL DEFAULT '0.00' COMMENT '充值金额',
  `pay_stat` char(1) NOT NULL DEFAULT '0' COMMENT '0 充值中 2 充值完成 已加入到可用金额中',
  `pay_time` datetime DEFAULT NULL COMMENT '充值时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`pay_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='代理客户详情表';

-- ----------------------------
-- Table structure for m_flow_daily_cost
-- ----------------------------
DROP TABLE IF EXISTS `m_flow_daily_cost`;
CREATE TABLE `m_flow_daily_cost` (
  `daily_cost_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 日消耗id ',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `client_iccid` int(11) NOT NULL COMMENT '客户端iccid',
  `flow_daily_cost` int(11) NOT NULL COMMENT '日消耗流量 单位 M',
  `cost_dat` datetime DEFAULT NULL COMMENT '消耗日期',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`daily_cost_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流量日消耗表';

-- ----------------------------
-- Table structure for m_flow_month_cost
-- ----------------------------
DROP TABLE IF EXISTS `m_flow_month_cost`;
CREATE TABLE `m_flow_month_cost` (
  `month_cost_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 日消耗id ',
  `client_id` int(11) NOT NULL COMMENT '代理id',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `client_iccid` int(11) NOT NULL COMMENT '客户端iccid',
  `flow_daily_cost` int(11) NOT NULL COMMENT '日消耗流量 单位 M',
  `cost_dat` datetime DEFAULT NULL COMMENT '消耗月份',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`month_cost_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='流量月消耗表';

-- ----------------------------
-- Table structure for m_gate_way
-- ----------------------------
DROP TABLE IF EXISTS `m_gate_way`;
CREATE TABLE `m_gate_way` (
  `gate_way_id` int(11) unsigned zerofill NOT NULL COMMENT '渠道id',
  `province_id` int(11) NOT NULL COMMENT '省份id',
  `gate_way_type` char(1) DEFAULT NULL COMMENT '类型 0 便利店 1移动营业点 2 联通营业点 3 电信营业点',
  `gate_way_mobile` varchar(13) NOT NULL COMMENT '联系电话',
  `gate_way_name` varchar(100) NOT NULL COMMENT '渠道名称',
  `linkman_name` varchar(10) NOT NULL COMMENT '联系人',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`gate_way_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='渠道表';

-- ----------------------------
-- Table structure for m_iotcard
-- ----------------------------
DROP TABLE IF EXISTS `m_iotcard`;
CREATE TABLE `m_iotcard` (
  `card_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键 卡id',
  `card_code` varchar(50) NOT NULL COMMENT '网卡短号',
  `iccid` varchar(50) NOT NULL COMMENT '真实卡号',
  `clien_iccid` varchar(32) NOT NULL COMMENT '客户端展示的iccid',
  `imsi` varchar(20) NOT NULL COMMENT 'imsi 号',
  `supplier_id` int(11) NOT NULL COMMENT '供应商id',
  `flow_pool_id` int(11) NOT NULL DEFAULT '0' COMMENT ' 0 表示没有加入流量池',
  `sale_state` int(1) NOT NULL DEFAULT '1' COMMENT '出售状态: 1:待售 2:已售出',
  `package_id` int(11) NOT NULL COMMENT '流量包id',
  `card_type` char(1) NOT NULL DEFAULT '0' COMMENT '0 消费卡 1 机械卡',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`card_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='物联网卡表';

-- ----------------------------
-- Table structure for m_iotcard_recover
-- ----------------------------
DROP TABLE IF EXISTS `m_iotcard_recover`;
CREATE TABLE `m_iotcard_recover` (
  `recover_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `iccid` int(11) unsigned NOT NULL COMMENT '卡id',
  `user_id` int(11) unsigned NOT NULL COMMENT '用户id',
  `card_state` int(1) NOT NULL DEFAULT '1' COMMENT '物联网卡状态: 1:停机 2:开机',
  `receive_state` int(1) DEFAULT NULL COMMENT '响应码',
  `receive_desc` varchar(100) DEFAULT NULL COMMENT '响应状态描述',
  `transationid` varchar(50) NOT NULL COMMENT '平台生成订单号',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`recover_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='物联网卡停复机记录表';

-- ----------------------------
-- Table structure for m_iotcard_renew
-- ----------------------------
DROP TABLE IF EXISTS `m_iotcard_renew`;
CREATE TABLE `m_iotcard_renew` (
  `renew_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) unsigned DEFAULT NULL COMMENT '用户id',
  `card_id` int(11) unsigned DEFAULT NULL COMMENT '卡id',
  `orderNum` varchar(32) DEFAULT NULL COMMENT '支付订单号 m_wxpay_log',
  `trade_state` int(1) NOT NULL DEFAULT '1' COMMENT '支付状态: 1:待支付 2:成功 3:失败',
  `renew_state` int(1) NOT NULL DEFAULT '0' COMMENT '续费状态: 0:未处理 1:续费中 2:已续费 3:续费失败 6:待续费',
  `renew_month` int(1) NOT NULL DEFAULT '1' COMMENT '续费月数',
  `bonus_state` int(1) NOT NULL DEFAULT '1' COMMENT '代理结算收益状态 1:未算提成 2:已算提成 ',
  `buy_price` int(10) NOT NULL DEFAULT '0' COMMENT '购买价格 单位:分',
  `openid` varchar(50) DEFAULT NULL COMMENT '微信中用户唯一标示',
  `create_time` datetime NOT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`renew_id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COMMENT='物联网卡续费记录表';

-- ----------------------------
-- Table structure for m_mobile_area
-- ----------------------------
DROP TABLE IF EXISTS `m_mobile_area`;
CREATE TABLE `m_mobile_area` (
  `pref` varchar(7) NOT NULL DEFAULT '0' COMMENT '号码前缀',
  `provi_id` decimal(3,0) NOT NULL COMMENT '省份id',
  PRIMARY KEY (`pref`),
  UNIQUE KEY `pref` (`pref`,`provi_id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='号段省份表';

-- ----------------------------
-- Table structure for m_package
-- ----------------------------
DROP TABLE IF EXISTS `m_package`;
CREATE TABLE `m_package` (
  `package_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键',
  `package_name` varchar(40) NOT NULL COMMENT '包名',
  `type` char(1) NOT NULL DEFAULT '0' COMMENT '类型   0 :月包 1: 季包 2: 半年包 3:年包 4:三年包 5 : 五年包',
  `flow_size` int(6) NOT NULL DEFAULT '0' COMMENT '流量包大小 单位 : M',
  `carrier_operator` char(1) NOT NULL DEFAULT '1' COMMENT '运营商  1 : 移动 2 :联通 3:电信',
  `sell_price` decimal(8,2) NOT NULL COMMENT '销售价格',
  `access_price` decimal(8,2) NOT NULL COMMENT '进货价格',
  `package_status` char(1) NOT NULL DEFAULT '0' COMMENT ' 0 下架 1 上架',
  `supplier_id` int(11) unsigned zerofill NOT NULL COMMENT '供应商id',
  PRIMARY KEY (`package_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='流量包表';

-- ----------------------------
-- Table structure for m_province
-- ----------------------------
DROP TABLE IF EXISTS `m_province`;
CREATE TABLE `m_province` (
  `provi_id` int(11) NOT NULL COMMENT '省份id',
  `provi_name` varchar(30) NOT NULL COMMENT '省份名称',
  PRIMARY KEY (`provi_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='省份信息表';

-- ----------------------------
-- Table structure for m_segment
-- ----------------------------
DROP TABLE IF EXISTS `m_segment`;
CREATE TABLE `m_segment` (
  `segment_id` bigint(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `operator` tinyint(1) NOT NULL COMMENT '1:移动 2联通 3:电信 ',
  `pref` varchar(5) NOT NULL COMMENT '手机号前三位',
  PRIMARY KEY (`segment_id`),
  UNIQUE KEY `pref` (`pref`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8 COMMENT='号段运营商对应表';

-- ----------------------------
-- Table structure for m_supplier
-- ----------------------------
DROP TABLE IF EXISTS `m_supplier`;
CREATE TABLE `m_supplier` (
  `supplier_id` int(11) unsigned zerofill NOT NULL AUTO_INCREMENT COMMENT '主键',
  `supplier_name` varchar(40) NOT NULL COMMENT '供应商名称',
  `user_name` varchar(40) NOT NULL,
  `api_key` varchar(32) NOT NULL COMMENT 'key',
  `server_ip` varchar(200) NOT NULL COMMENT '服务器ip',
  `intf_name` varchar(60) NOT NULL COMMENT '接口名字',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`supplier_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='供应商表';

-- ----------------------------
-- Table structure for m_user
-- ----------------------------
DROP TABLE IF EXISTS `m_user`;
CREATE TABLE `m_user` (
  `user_id` int(11) unsigned zerofill NOT NULL COMMENT '用户id',
  `mobile` int(13) NOT NULL COMMENT '手机号码',
  `open_id` varchar(32) DEFAULT NULL COMMENT '微信openid 唯一标识',
  `clien_iccid` varchar(32) NOT NULL COMMENT '客户端展示的iccid',
  `package_id` int(11) NOT NULL COMMENT '包id',
  `validity` datetime NOT NULL COMMENT '使用有效',
  `status` char(1) NOT NULL DEFAULT '0' COMMENT '状态 0 : 正常 1:欠费 9 :黑名单',
  `card_id` int(11) unsigned zerofill NOT NULL COMMENT '卡id',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='个人用户表';

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '上级部门ID，一级部门为0',
  `name` varchar(50) DEFAULT NULL COMMENT '部门名称',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `del_flag` tinyint(4) DEFAULT '0' COMMENT '是否删除  -1：已删除  0：正常',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 COMMENT='部门管理';

-- ----------------------------
-- Table structure for sys_dict
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `id` bigint(64) NOT NULL AUTO_INCREMENT COMMENT '编号',
  `name` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '标签名',
  `value` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '数据值',
  `type` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '类型',
  `description` varchar(100) COLLATE utf8_bin DEFAULT NULL COMMENT '描述',
  `sort` decimal(10,0) DEFAULT NULL COMMENT '排序（升序）',
  `parent_id` bigint(64) DEFAULT '0' COMMENT '父级编号',
  `create_by` int(64) DEFAULT NULL COMMENT '创建者',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` bigint(64) DEFAULT NULL COMMENT '更新者',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remarks` varchar(255) COLLATE utf8_bin DEFAULT NULL COMMENT '备注信息',
  `del_flag` char(1) COLLATE utf8_bin DEFAULT '0' COMMENT '删除标记',
  PRIMARY KEY (`id`),
  KEY `sys_dict_value` (`value`),
  KEY `sys_dict_label` (`name`),
  KEY `sys_dict_del_flag` (`del_flag`)
) ENGINE=InnoDB AUTO_INCREMENT=122 DEFAULT CHARSET=utf8 COLLATE=utf8_bin COMMENT='字典表';

-- ----------------------------
-- Table structure for sys_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `operation` varchar(50) DEFAULT NULL COMMENT '用户操作',
  `time` int(11) DEFAULT NULL COMMENT '响应时间',
  `method` varchar(200) DEFAULT NULL COMMENT '请求方法',
  `params` varchar(5000) DEFAULT NULL COMMENT '请求参数',
  `ip` varchar(64) DEFAULT NULL COMMENT 'IP地址',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=89 DEFAULT CHARSET=utf8 COMMENT='系统日志';

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `menu_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `parent_id` bigint(20) DEFAULT NULL COMMENT '父菜单ID，一级菜单为0',
  `name` varchar(50) DEFAULT NULL COMMENT '菜单名称',
  `url` varchar(200) DEFAULT NULL COMMENT '菜单URL',
  `perms` varchar(500) DEFAULT NULL COMMENT '授权(多个用逗号分隔，如：user:list,user:create)',
  `type` int(11) DEFAULT NULL COMMENT '类型   0：目录   1：菜单   2：按钮',
  `icon` varchar(50) DEFAULT NULL COMMENT '菜单图标',
  `order_num` int(11) DEFAULT NULL COMMENT '排序',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `component` varchar(20) DEFAULT NULL,
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `redirect` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`menu_id`)
) ENGINE=InnoDB AUTO_INCREMENT=91 DEFAULT CHARSET=utf8 COMMENT='菜单管理';

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `role_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_name` varchar(100) DEFAULT NULL COMMENT '角色名称',
  `role_sign` varchar(100) DEFAULT NULL COMMENT '角色标识',
  `remark` varchar(100) DEFAULT NULL COMMENT '备注',
  `user_id_create` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  `menu_id` bigint(20) DEFAULT NULL COMMENT '菜单ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3225 DEFAULT CHARSET=utf8 COMMENT='角色与菜单对应关系';

-- ----------------------------
-- Table structure for sys_task
-- ----------------------------
DROP TABLE IF EXISTS `sys_task`;
CREATE TABLE `sys_task` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `cron_expression` varchar(255) DEFAULT NULL COMMENT 'cron表达式',
  `method_name` varchar(255) DEFAULT NULL COMMENT '任务调用的方法名',
  `is_concurrent` varchar(255) DEFAULT NULL COMMENT '任务是否有状态',
  `description` varchar(255) DEFAULT NULL COMMENT '任务描述',
  `update_by` varchar(64) DEFAULT NULL COMMENT '更新者',
  `bean_class` varchar(255) DEFAULT NULL COMMENT '任务执行时调用哪个类的方法 包名+类名',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `job_status` varchar(255) DEFAULT NULL COMMENT '任务状态',
  `job_group` varchar(255) DEFAULT NULL COMMENT '任务分组',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `create_by` varchar(64) DEFAULT NULL COMMENT '创建者',
  `spring_bean` varchar(255) DEFAULT NULL COMMENT 'Spring bean',
  `job_name` varchar(255) DEFAULT NULL COMMENT '任务名',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(50) DEFAULT NULL COMMENT '用户名',
  `name` varchar(100) DEFAULT NULL,
  `password` varchar(50) DEFAULT NULL COMMENT '密码',
  `dept_id` bigint(20) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL COMMENT '邮箱',
  `mobile` varchar(100) DEFAULT NULL COMMENT '手机号',
  `status` tinyint(255) DEFAULT NULL COMMENT '状态 0:禁用，1:正常',
  `user_id_create` bigint(255) DEFAULT NULL COMMENT '创建用户id',
  `gmt_create` datetime DEFAULT NULL COMMENT '创建时间',
  `gmt_modified` datetime DEFAULT NULL COMMENT '修改时间',
  `sex` bigint(32) DEFAULT NULL COMMENT '性别',
  `birth` datetime DEFAULT NULL COMMENT '出身日期',
  `pic_id` bigint(32) DEFAULT NULL,
  `live_address` varchar(500) DEFAULT NULL COMMENT '现居住地',
  `hobby` varchar(255) DEFAULT NULL COMMENT '爱好',
  `province` varchar(255) DEFAULT NULL COMMENT '省份',
  `city` varchar(255) DEFAULT NULL COMMENT '所在城市',
  `district` varchar(255) DEFAULT NULL COMMENT '所在地区',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_plus
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_plus`;
CREATE TABLE `sys_user_plus` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `payment` double DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) DEFAULT NULL COMMENT '用户ID',
  `role_id` bigint(20) DEFAULT NULL COMMENT '角色ID',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=166 DEFAULT CHARSET=utf8 COMMENT='用户与角色对应关系';

-- ----------------------------
-- Table structure for sys_user_token
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_token`;
CREATE TABLE `sys_user_token` (
  `user_id` bigint(20) NOT NULL,
  `token` varchar(100) NOT NULL COMMENT 'token',
  `expire_time` datetime DEFAULT NULL COMMENT '过期时间',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `token` (`token`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统用户Token';
