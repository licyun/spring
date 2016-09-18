##spring DAO组件整合hibernate
###所有的数据库访问都通过DAO组件完成。
###为了使hibernate配合spring。应让hibernate的sessionfactory由bean注入完成而不是自身new产生。
##bean.xml
```xml
	<!-- 定义Hibernate的SessionFactory -->
	<bean id="sessionFactory"
		class="org.springframework.orm.hibernate3.LocalSessionFactoryBean">
		<!-- 依赖注入数据源，注入正是上面定义的dataSource -->
		<property name="dataSource" ref="dataSource"/>
		<!-- mappingResouces属性用来列出全部映射文件 -->
		<property name="mappingResources">
			<list>
				<!-- 以下用来列出Hibernate映射文件 -->
				<value>org/crazyit/app/domain/Person.hbm.xml</value>
			</list>
		</property>
		<!-- 定义Hibernate的SessionFactory的属性 -->
		<property name="hibernateProperties">
			<!-- 配置Hibernate属性 -->
			<value>
			hibernate.dialect=org.hibernate.dialect.MySQLInnoDBDialect
			hibernate.hbm2ddl.auto=update
			hibernate.show_sql=true
			hibernate.format_sql=true;
			</value>
		</property>
	</bean>
	<!-- 定义DAO Bean-->
	<bean id="personDao"
		class="org.crazyit.app.dao.impl.PersonDaoImpl">
		<!-- 注入持久化操作所需的SessionFactory -->
		<property name="sessionFactory" ref="sessionFactory"/>
	</bean>
```
###java类中使用HibernateTemplate对象进行持久化操作
```java
	//初始化HibernateTemplate的方法
	private  HibernateTemplate getHibernateTemplate()
	{
		if (ht == null)
		{
			ht = new HibernateTemplate(sessionFactory);
		}
		return ht;
	}
```

