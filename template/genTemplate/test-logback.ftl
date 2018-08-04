<?xml version="1.0" encoding="UTF-8"?>

<!-- 级别从高到低 OFF 、 FATAL 、 ERROR 、 WARN 、 INFO 、 DEBUG 、 TRACE 、 ALL -->
<!-- 日志输出规则 根据当前ROOT 级别，日志输出时，级别高于root默认的级别时 会输出 -->
<!-- 以下 每个配置的 filter 是过滤掉输出文件里面，会出现高级别文件，依然出现低级别的日志信息，通过filter 过滤只记录本级别的日志 -->
<!-- scan 当此属性设置为true时，配置文件如果发生改变，将会被重新加载，默认值为true。 -->
<!-- scanPeriod 设置监测配置文件是否有修改的时间间隔，如果没有给出时间单位，默认单位是毫秒。当scan为true时，此属性生效。默认的时间间隔为1分钟。 -->
<!-- debug 当此属性设置为true时，将打印出logback内部日志信息，实时查看logback运行状态。默认值为false。 -->
<configuration scan="true" scanPeriod="60 seconds" debug="false">

	<!-- 动态日志级别 -->
	<jmxConfigurator />

	<!-- 定义日志文件 输出位置 -->
	<property name="log_dir" value="logs" />
	
	<!-- 定义日志文件名称 -->
	<property name="log_name" value="${paramMap.modelName}" />

	<!-- 日志最大的历史 30天 -->
	<property name="maxHistory" value="30" />

	<!-- ConsoleAppender 控制台输出日志 -->
	<appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
		<encoder>
			<pattern>
				<!-- 设置日志输出格式 -->
				%d<#noparse>{</#noparse>yyyy-MM-dd HH:mm:ss.SSS<#noparse>}</#noparse> %-5level %logger - %msg%n
			</pattern>
		</encoder>
		<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
			<level>DEBUG</level>
		</filter>
	</appender>

	<!-- ERROR级别日志 -->
	<!-- 滚动记录文件，先将日志记录到指定文件，当符合某个条件时，将日志记录到其他文件 RollingFileAppender -->
	<appender name="ERROR"
		class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file><#noparse>${</#noparse>log_dir<#noparse>}</#noparse>/<#noparse>${</#noparse>log_name<#noparse>}</#noparse>-error.log</file>
		<!-- 过滤器，只记录WARN级别的日志 -->
		<!-- 果日志级别等于配置级别，过滤器会根据onMath 和 onMismatch接收或拒绝日志。 -->
		<filter class="ch.qos.logback.classic.filter.LevelFilter">
			<!-- 设置过滤级别 -->
			<level>ERROR</level>
			<!-- 用于配置符合过滤条件的操作 -->
			<onMatch>ACCEPT</onMatch>
			<!-- 用于配置不符合过滤条件的操作 -->
			<onMismatch>DENY</onMismatch>
		</filter>
		<!-- 最常用的滚动策略，它根据时间来制定滚动策略.既负责滚动也负责出发滚动 -->
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!--日志输出位置 可相对、和绝对路径 -->
			<fileNamePattern>
				<#noparse>${</#noparse>log_dir<#noparse>}</#noparse>/<#noparse>${</#noparse>log_name<#noparse>}</#noparse>-error.%d<#noparse>{</#noparse>yyyy-MM-dd<#noparse>}</#noparse>.log
			</fileNamePattern>
			<!-- 可选节点，控制保留的归档文件的最大数量，超出数量就删除旧文件假设设置每个月滚动，且<maxHistory>是6， 则只保存最近6个月的文件，删除之前的旧文件。注意，删除旧文件是，那些为了归档而创建的目录也会被删除 -->
			<maxHistory><#noparse>${</#noparse>maxHistory<#noparse>}</#noparse></maxHistory>
		</rollingPolicy>
		<encoder>
			<pattern>
				<!-- 设置日志输出格式 -->
				%d<#noparse>{</#noparse>yyyy-MM-dd HH:mm:ss.SSS<#noparse>}</#noparse> %-5level %logger - %msg%n
			</pattern>
		</encoder>
	</appender>


	<appender name="SERVICE"
		class="ch.qos.logback.core.rolling.RollingFileAppender">
		<file><#noparse>${</#noparse>log_dir<#noparse>}</#noparse>/<#noparse>${</#noparse>log_name<#noparse>}</#noparse>.log</file>
		<!-- 最常用的滚动策略，它根据时间来制定滚动策略.既负责滚动也负责出发滚动 -->
		<rollingPolicy class="ch.qos.logback.core.rolling.TimeBasedRollingPolicy">
			<!--日志输出位置 可相对、和绝对路径 -->
			<fileNamePattern>
				<#noparse>${</#noparse>log_dir<#noparse>}</#noparse>/<#noparse>${</#noparse>log_name<#noparse>}</#noparse>.%d<#noparse>{</#noparse>yyyy-MM-dd<#noparse>}</#noparse>.log
			</fileNamePattern>
			<!-- 可选节点，控制保留的归档文件的最大数量，超出数量就删除旧文件假设设置每个月滚动，且<maxHistory>是6， 则只保存最近6个月的文件，删除之前的旧文件。注意，删除旧文件是，那些为了归档而创建的目录也会被删除 -->
			<maxHistory><#noparse>${</#noparse>maxHistory<#noparse>}</#noparse></maxHistory>
		</rollingPolicy>
		<filter class="ch.qos.logback.classic.filter.ThresholdFilter">
			<level>DEBUG</level>
		</filter>
		<encoder>
			<pattern>
				<!-- 设置日志输出格式 -->
				%d<#noparse>{</#noparse>yyyy-MM-dd HH:mm:ss.SSS<#noparse>}</#noparse> %-5level %logger - %msg%n
			</pattern>
		</encoder>
	</appender>

	<logger name="java.sql" level="DEBUG" />
	<logger name="org.springframework" level="DEBUG" />
	<logger name="com.minstone" level="DEBUG" />
	<logger name="org.apache.cxf.jaxb" level="ERROR" />

	<!-- root级别 DEBUG -->
	<root>
		<!-- 打印debug级别日志及以上级别日志 -->
		<level value="INFO" />
		<!-- 控制台输出 -->
		<appender-ref ref="CONSOLE" />
		<appender-ref ref="SERVICE" />
		<appender-ref ref="ERROR" />
	</root>
</configuration>