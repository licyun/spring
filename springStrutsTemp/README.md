## spring 整合struts2
### struts.xml的class属性不再指定具体的实体类，而是spring中的bean的id.
### struts不再创建实例，而是由spring对应ID的bean负责注入实例。
###导入插件包：struts2-spring-plugin-2.2.1.jar
###web.xml下导入spring监听
```xml
	<listener>
		<listener-class>org.springframework.web.context.ContextLoaderListener
		</listener-class>
	</listener>
```
##struts.xml
```xml
	<!-- 定义处理用户请求的Action，该Action的class属性不是实际处理类
		, 而是Spring容器中的Bean实例-->
	<action name="loginPro" class="loginAction">
		<!-- 为两个逻辑视图配置视图页面 -->
		<result name="error">/WEB-INF/content/error.jsp</result>
		<result name="success">/WEB-INF/content/welcome.jsp</result>
	</action>
```

###applicationContext.xml
```xml
	<!-- 让Spring管理的Action实例 -->
	<bean id="loginAction" class="org.crazyit.app.action.LoginAction"
		scope="prototype">
		<!-- 依赖注入业务逻辑组件 -->
		<property name="ms" ref="myService"/>
	</bean>
``
