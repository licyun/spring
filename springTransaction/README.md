##使用spring 的tx命名空间配置事务增强处理
###bean.xml中使用<tx:advice 配置事务
####<tx:method 匹配事务增强处理的方法
```xml
	<!-- 配置事务增强处理,指定事务管理器 -->
	<tx:advice id="txAdvice" 
		transaction-manager="transactionManager">
		<!-- 用于配置详细的事务语义 -->
		<tx:attributes>
			<!-- 所有以'get'开头的方法是read-only的 -->
			<tx:method name="get*" read-only="true"/>
			<!-- 其他方法使用默认的事务设置 -->
			<tx:method name="*"/>
		</tx:attributes>
	</tx:advice>
```
###bean.xml中的<aop:config 确保由txAdvice切面定义事务增强处理能在适合的点被织入
####匹配org.crazyit.app.dao.impl包中所有以Impl结尾的类所包含的方法，把该切入点定义为myPorintcut，然后用一个advisor把这个切入点与txAdvice绑定在一起，表示当myPointCut执行时，txAdvice定义的增强处理将被织入
```xml
	<aop:config>
		<!-- 配置一个切入点，匹配org.crazyit.app.dao.impl包下
			所有以Impl结尾的类里、所有方法的执行 -->
		<aop:pointcut id="myPointcut"
			expression="execution(* org.crazyit.app.dao.impl.*Impl.*(..))"/>
			<!-- 指定在txAdvice切入点应用txAdvice事务增强处理 -->
		<aop:advisor advice-ref="txAdvice" 
			pointcut-ref="myPointcut"/>
	</aop:config>
```
###由于是从容器中获取NewsDao Bean,而spring aop匹配到该bean的文件目录符合规则，因此会为该Bean事务自动织入事务增强处理方式，所以newsDao bean下的所有方法都具有事务性。
```java
	//获取事务代理Bean
	NewsDao dao = (NewsDao)ctx
		.getBean("newsDao" , NewsDao.class);
	//执行插入操作
	dao.insert("crazy java" , "light java ee");
```
