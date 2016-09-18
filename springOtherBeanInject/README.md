##spring 注入其他bean的值
###1.注入其他bean的属性值
```xml
	<!--以下定义了将要被引用的目标bean-->
	<bean id="person" class="org.crazyit.app.service.Person">
		<!-- 为age属性指定值 -->
		<property name="age" value="30"/>
		<property name="son">
			<!-- 使用嵌套Bean定义属性值 -->
			<bean class="org.crazyit.app.service.Son">
				<property name="age" value="11" />
			</bean>
		</property>
	</bean>

	<!-- 将指定Bean实例的属性值定义成指定Bean实例 -->
	<bean id="son1"
	class="org.springframework.beans.factory.config.PropertyPathFactoryBean">
		<!-- 确定目标Bean，表明son1 Bean来自哪个Bean的属性 -->
		<property name="targetBeanName" value="person"/>
		<!-- 确定属性表达式，表明son1 Bean来自目标bean的哪个属性 -->
		<property name="propertyPath" value="son"/>
	</bean>
	
		<!-- 如下定义son2的 Bean，该Bean的age属性不是直接注入
		，而是依赖于其他Bean的属性值 -->
	<bean id="son2" class="org.crazyit.app.service.Son">
		<property name="age">
			<!-- 以下是访问Bean属性的简单方式,这样可以将person Bean的son属性的、
				age属性赋值给son2这个bean的age属性-->
			<bean id="person.son.age" class=
				"org.springframework.beans.factory.config.PropertyPathFactoryBean"/>
		</property>
	</bean>
	
	<!-- 将基本数据类型的属性值定义成Bean实例 -->
	<bean id="theAge2" class=
		"org.springframework.beans.factory.config.PropertyPathFactoryBean">
		<!-- 确定目标Bean，表明theAge2 Bean来自哪个Bean的属性。
			此处采用嵌套Bean定义目标Bean -->
		<property name="targetObject">
			<!-- 目标Bean不是容器中已经存在的Bean, 而是如下的嵌套Bean-->
			<bean class="org.crazyit.app.service.Person">
				<property name="age" value="30"/>
			</bean>
		</property>
		<!-- 确定属性表达式，表明theAge2 Bean来自目标bean的哪个属性 -->
		<property name="propertyPath" value="age"/>
	</bean>
```
###2.注入其他bean的filed值
```xml
	<!-- 将java.sql.Connection的TRANSACTION_SERIALIZABLE
		的值赋给son的age属性-->
	<bean id="son" class="org.crazyit.app.service.Son">
		<property name="age">
			<bean id="java.sql.Connection.TRANSACTION_SERIALIZABLE" 
				class="org.springframework.beans.factory.config.FieldRetrievingFactoryBean"/>
		</property>
	</bean>
	<!-- 将Field 值定义成Bean 实例-->
	<bean id="theAge1" class=
		"org.springframework.beans.factory.config.FieldRetrievingFactoryBean">
		<!-- targetClass指定Field所在的目标类 -->
		<property name="targetClass" value="java.sql.Connection"/>
		<!-- targetField指定Field名 -->
		<property name="targetField" value="TRANSACTION_SERIALIZABLE"/>
	</bean>
	
	<!-- 将Field 值定义成Bean实例 -->
	<bean id="theAge2" class=
		"org.springframework.beans.factory.config.FieldRetrievingFactoryBean">
		<!-- value指定采用哪个类的哪个静态域值 -->
		<property name="staticField" 
			value="java.sql.Connection.TRANSACTION_SERIALIZABLE"/>
	</bean>
```
###3.注入其他bean的返回值
```xml
	<!-- 定义目标Bean，后面将会获取该Bean的方法返回值 -->
	<bean id="valueGnerator" class="org.crazyit.app.util.ValueGenerator"/>
	<!-- 定义名为son1的Bean -->
	<bean id="son1" class="org.crazyit.app.service.Son">
		<property name="age">
			<!-- 获取方法返回值 -->
			<bean class=
				"org.springframework.beans.factory.config.MethodInvokingFactoryBean">
				<!-- targetObject确定目标Bean，指定调用哪个Bean -->
				<property name="targetObject" ref="valueGnerator"/>
				<!-- targetMethod确定目标方法，指定调用目标Bean的哪个方法 -->
				<property name="targetMethod" value="getValue"/>
			</bean>
		</property>
	</bean>
	<!-- 定义名为son2的Bean -->
	<bean id="son2" class="org.crazyit.app.service.Son">
		<property name="age">
			<bean class=
				"org.springframework.beans.factory.config.MethodInvokingFactoryBean">
				<!-- targetClass确定目标类，指定调用哪个类 -->
				<property name="targetClass" value="org.crazyit.app.util.ValueGenerator"/>
				<!-- targetMethod确定目标方法，指定调用目标class的哪个方法。 
					该方法必须是静态方法-->
				<property name="targetMethod" value="getStaticValue"/>
			</bean>
		</property>
	</bean>
	<!--  将静态方法返回值直接定义成Bean -->
	<bean id="sysProps" class=
		"org.springframework.beans.factory.config.MethodInvokingFactoryBean">
		<!-- targetClass确定目标类，确定调用哪个类 -->
		<property name="targetClass" value="java.lang.System"/>
		<!-- targetMethod确定目标方法，确定调用目标class的哪个方法 
			该方法必须是静态方法-->
		<property name="targetMethod" value="getProperties"/>
	</bean>
	<!-- 将实例方法返回值直接定义成Bean -->
	<bean id="javaVersion" class=
		"org.springframework.beans.factory.config.MethodInvokingFactoryBean">
		<!-- targetObject确定目标Bean，确定调用哪个Bean -->
		<property name="targetObject" ref="sysProps"/>
		<!-- targetMethod确定目标方法，确定调用目标Bean的哪个方法 -->
		<property name="targetMethod" value="getProperty"/>
		<!-- 确定调用目标方法的参数 -->
		<property name="arguments">
			<!-- list元素列出调用方法多个参数值 -->
			<list>
				<value>java.version</value>
			</list>
		</property>
	</bean>
```
