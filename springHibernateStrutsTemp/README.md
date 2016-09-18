##spring hibernate struts 整合
##业务流程如下
###1.输入/regist被struts.xml的action默认拦截器拦截，转发到/regist.jsp.
```xml
	<!-- 让用户直接访问该应用时列出所有视图页面 -->
	<action name="*">
		<result>/WEB-INF/content/{1}.jsp</result>
	</action>
```

###2.regist.jsp中输入姓名和年龄后post提交到registPro的action，拦截后转发到spring中id为registPro的bean.
```xml
	<action name="registPro" 
		class="registPro">
		<!-- 为两个逻辑视图配置视图页面 -->
		<result name="error">/WEB-INF/content/error.jsp</result>
		<result name="success">/WEB-INF/content/welcome.jsp</result>
	</action>
```

###3.spring中id为registPro的bean将业务逻辑组件leeService注入到registerAction中。
```xml
	<!-- 配置resistPro -->
	<bean id="registPro" class=
	"org.crazyit.app.action.RegistAction">
		<!-- 注入registaction需要的业务逻辑组件leeService -->
		<property name="leeService" ref="leeService"/>
	</bean>
```

###4.RegisterAction调用业务逻辑组件的regist方法来处理请求
```java
	if (leeService.regist(person))
	{
		setTip("哈哈，注册成功！");
		return SUCCESS;
	}
```

###5.leeService业务逻辑组件则调用注入了personDao的DAO来实现save()方法
```xml
	<!-- 配置一个业务逻辑组件 -->
	<bean id="leeService" class=
	"org.crazyit.app.service.impl.LeeServiceImpl">
		<!-- 注入持久化访问所需的DAO组件 -->
		<property name="personDao" ref="personDao"/>
	</bean>
	
		//调用DAO组件的方法来实现业务逻辑
		int result = personDao.save(person);
```

###6.配置Hibernate的局部事务管理器，使leeService具有事务性
```xml
	<!-- 配置Hibernate的局部事务管理器，使用HibernateTransactionManager类 -->
	<!-- 该类实现PlatformTransactionManager接口，是针对Hibernate的特定实现-->
	<bean id="transactionManager" 
		class="org.springframework.orm.hibernate3.HibernateTransactionManager">
		<!-- 配置HibernateTransactionManager时需要依注入SessionFactory的引用 -->
		<property name="sessionFactory" ref="sessionFactory"/>
	</bean>
	<!-- 配置事务增强处理,指定事务管理器 -->
	<tx:advice id="txAdvice" transaction-manager="transactionManager">
		<!-- 用于配置详细的事务语义 -->
		<tx:attributes>
			<!-- 所有以'get'开头的方法是read-only的 -->
			<tx:method name="get*" read-only="true"/>
			<!-- 其他方法使用默认的事务设置 -->
			<tx:method name="*"/>
		</tx:attributes>
	</tx:advice>
	<aop:config>
		<!-- 配置一个切入点 -->
		<aop:pointcut id="leePointcut"
			expression="bean(leeService)"/>
		<!-- 指定在leePointcut切入点应用txAdvice事务增强处理 -->
		<aop:advisor advice-ref="txAdvice" 
			pointcut-ref="leePointcut"/>
	</aop:config>
```

###7.DAO组件personDao则注入了hibernate中sessionFactory的getHibernateTemplate()方法将person类转换为数据关系存入到数据库中
```xml
	<bean id="personDao" class=
	"org.crazyit.app.dao.impl.PersonDaoHibernate">
		<!-- 注入持久化操作所需的SessionFactory -->
		<property name="sessionFactory" ref="sessionFactory"/>
	</bean>
	
	public Integer save(Person person)
	{
		return (Integer)getHibernateTemplate()
			.save(person);
	}
```

###8.使用hibernate保存数据成功后RegistAction返回success到registPro的Action，并被struts映射到对应的逻辑视图。
```xml
		<action name="registPro" 
			class="registPro">
			<!-- 为两个逻辑视图配置视图页面 -->
			<result name="error">/WEB-INF/content/error.jsp</result>
			<result name="success">/WEB-INF/content/welcome.jsp</result>
		</action>
```
