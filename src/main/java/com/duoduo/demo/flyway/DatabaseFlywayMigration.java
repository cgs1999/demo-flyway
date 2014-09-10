package com.duoduo.demo.flyway;

import java.beans.PropertyVetoException;

import javax.sql.DataSource;

import com.googlecode.flyway.core.Flyway;
import com.googlecode.flyway.core.api.FlywayException;
import com.mchange.v2.c3p0.ComboPooledDataSource;

/**
 * database Flyway版本管理服务类
 * @author chengesheng@gmail.com
 * @date 2014-9-10 下午3:21:26
 * @version 1.0.0
 */
public class DatabaseFlywayMigration {

	private DataSource dataSource;

	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	public void migrate() {
		Flyway flyway = new Flyway();
		flyway.setDataSource(dataSource);

		// List<?> history = flyway.history();
		// logger.info("flyway history size : " + history.size());
		// if (history == null || history.size() == 0) {
		// flyway.init();
		// }
		// flyway.setSchemas("win"); // 设置接受flyway进行版本管理的多个数据库
		flyway.setLocations("flyway"); // 设置flyway扫描sql升级脚本、java升级脚本的目录路径或包路径
		flyway.setEncoding("UTF-8"); // 设置sql脚本文件的编码
		flyway.setOutOfOrder(true);
		// flyway.setValidationMode(ValidationMode.ALL); //
		// 设置执行migrate操作之前的validation行为
		// flyway.setValidationErrorMode(ValidationErrorMode.FAIL); //
		// 设置当validation失败时的系统行为
		try {
			flyway.setInitOnMigrate(true);
			flyway.migrate();
		} catch (FlywayException e) {
			flyway.repair();
			e.printStackTrace();
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ComboPooledDataSource dataSource = new ComboPooledDataSource();
		try {
			dataSource.setDriverClass("com.mysql.jdbc.Driver");
			dataSource.setJdbcUrl("jdbc:mysql://127.0.0.1:3306/demo-flyway?useUnicode=true&characterEncoding=utf-8");
			dataSource.setUser("root");
			dataSource.setPassword("");
			dataSource.setIdleConnectionTestPeriod(30);
			dataSource.setInitialPoolSize(10);
			dataSource.setMaxIdleTime(30);
			dataSource.setMaxPoolSize(25);
			dataSource.setMinPoolSize(3);
			dataSource.setMaxStatements(0);
			dataSource.setPreferredTestQuery("select 1");
		} catch (PropertyVetoException e) {
			e.printStackTrace();
		}

		DatabaseFlywayMigration migration = new DatabaseFlywayMigration();
		migration.setDataSource(dataSource);
		migration.migrate();
	}

}