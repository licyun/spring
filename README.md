##spring 设值注入和构造注入
##设值注入简单,通过setter方法使依赖关系更加直观
##构造注入复杂,但在某些需要顺序注入中需要使用构造注入。
###1.设值注入,java中使用seter方法注入,bean.xml中设置name为axe的注入属性
```xml
<bean id="chinese" class="org.crazyit.app.service.impl.Chinese">
	<!-- 将stoneAxe注入给axe属性 -->
	<property name="axe" ref="stoneAxe"/>
</bean>
```
```java
  //设值注入所需的setter方法
	public void setAxe(Axe axe)
	{
		this.axe = axe;
	}
```

###2.构造注入,java代码中使用默认构造器注入,bean.xml中无需指定name 
```xml
<bean id="chinese" class="org.crazyit.app.service.impl.Chinese">
		<!-- 使用构造注入，为chinese实例注入steelAxe实例 -->
		<constructor-arg ref="steelAxe"/>
	</bean>
```
```java
	public Chinese(Axe axe)
	{
		this.axe = axe;
	}
```
