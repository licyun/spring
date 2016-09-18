##使用spring 的resource来访问各种资源
####访问网络资源 :UrlResource
####访问类加载路径下的资源 :ClassPathResource
####访问字节数组资源 :ByteArrayResource
```java
UrlResource ur = new UrlResource("file:d:/book.xml");
```

##ApplicationContext实现类的访问策略
####ClassPathXmlApplicationContext ： 对应ClassPathResouce进行资源访问
####FileSystemXmlApplicationContext ： 对应FileSystemResouce进行资源访问
####XmlWebApplicationContext ： 对应ServletContextResouce进行资源访问
```java
	ApplicationContext ctx = new 
		ClassPathXmlApplicationContext("bean.xml");
```

##bean.xml 使用spring注入文件路径
####value值的classpath访问类路径下的资源
####file访问本地文件资源
####http访问网络资源
```xml
	<bean id="test" class="org.crazyit.app.service.TestBean">
		<!-- 注入资源 -->
		<property name="resource"
			value="classpath:book.xml"/>
	</bean>
```
##得到的book.xml文件使用dom4j进行解析
```java
	//创建Dom4j的解析器
	SAXReader reader = new SAXReader();
	Document doc = reader.read(res.getFile());
	//获取根元素
	Element el = doc.getRootElement();
	List l = el.elements();
	//遍历根元素的全部子元素
	for (Iterator it = l.iterator();it.hasNext() ; )
	{
		//每个节点都是<书>节点
		Element book = (Element)it.next();
		List ll = book.elements();
		//遍历<书>节点的全部子节点
		for (Iterator it2 = ll.iterator();it2.hasNext() ; )
		{
			Element eee = (Element)it2.next();
			System.out.println(eee.getText());
		}
	}
```

