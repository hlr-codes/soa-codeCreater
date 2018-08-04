package com.minstone.platform.configuration;

import javax.sql.DataSource;

import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.SqlSessionFactoryBean;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.ClassPathResource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.core.io.support.ResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.transaction.PlatformTransactionManager;
import org.springframework.transaction.annotation.EnableTransactionManagement;
import org.springframework.transaction.annotation.TransactionManagementConfigurer;


/**
 * MyBatis配置
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */

@Configuration
// 加上这个注解，使得支持事务
@EnableTransactionManagement
public class MyBatisConfig implements TransactionManagementConfigurer {
	@Autowired
	private DataSource dataSource;

	@Override
	public PlatformTransactionManager annotationDrivenTransactionManager() {
		return new DataSourceTransactionManager(dataSource);
	}

	@Bean(name = "sqlSessionFactory")
	public SqlSessionFactory sqlSessionFactoryBean() {
	    SqlSessionFactoryBean bean = new SqlSessionFactoryBean();
	    bean.setDataSource(dataSource);
	    bean.setTypeAliasesPackage("com.minstone");//每一张表对应的实体类
	    bean.setTypeAliasesSuperType(com.minstone.common.bean.BaseEntity.class);
	    bean.setConfigLocation(new ClassPathResource("mybatis-config.xml"));
	    //添加XML目录
	    ResourcePatternResolver resolver = new PathMatchingResourcePatternResolver();
	    try {
	        bean.setMapperLocations(resolver.getResources("classpath:mappings/modules/**/*.xml"));//每张表对应的xml文件
	        return bean.getObject();
	    } catch (Exception e) {
	        e.printStackTrace();
	        throw new RuntimeException(e);
	    }
	}
	
	@Bean
	public SqlSessionTemplate sqlSessionTemplate(
			SqlSessionFactory sqlSessionFactory) {
		return new SqlSessionTemplate(sqlSessionFactory);
	}
}
