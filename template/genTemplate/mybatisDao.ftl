<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="${paramMap.packageName}.dao.${table.modelName}Dao">
    <resultMap id="BaseResultMap" type="${table.modelName}">
	<#list table.columnList as column>
		<result property="${column.name}" column="${column.sqlName}" jdbcType="${column.type}"/>
	</#list>    
    </resultMap>

    <sql id="Base_Column_List">
	<#list table.columnList as column>
		${column.sqlName} as ${column.name}<#if column_has_next >,</#if>
	</#list>    
    </sql>

    <insert id="insert" parameterType="${table.modelName}">
        INSERT INTO ${table.tableName}(
	<#list table.columnList as column>
			${column.sqlName}<#if column_has_next >,</#if>
	</#list>
        ) VALUES (
	<#list table.columnList as column>
			<#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse><#if column_has_next >,</#if>
	</#list>
        )
    </insert>

	<update id="update" parameterType="${table.modelName}" >
        UPDATE ${table.tableName} 
        <set>
		<#list table.columnList as column>
	        <if test="${column.name} != null">
				${column.sqlName} = <#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>,
			</if>
		</#list>	
		</set>	        
        WHERE ${paramMap.pk} = <#noparse>#{</#noparse>${paramMap.pkLowerCaseName},jdbcType=VARCHAR<#noparse>}</#noparse>
	</update>
	
	<update id="updateSome" parameterType="Map" >
        UPDATE ${table.tableName} 
        <if test="pre != null">
	        <set>
			<#list table.columnList as column>
		        <if test="pre['${column.name}'] != null">
					${column.sqlName} = <#noparse>#{</#noparse>pre[${column.name}],jdbcType=${column.type}<#noparse>}</#noparse>,
				</if>
			</#list>	
			</set>
		</if>
		<if test="end != null">	 
			<where>
			<#list table.columnList as column>
		        <if test="end['${column.name}'] != null">
					and ${column.sqlName} = <#noparse>#{</#noparse>end[${column.name}],jdbcType=${column.type}<#noparse>}</#noparse>
				</if>
			</#list>
			</where> 
		</if>     
	</update>
	
	<select id="get" resultType="${table.modelName}">
		SELECT
		<include refid="Base_Column_List" />
		FROM ${table.tableName} 
		WHERE ${paramMap.pk} = <#noparse>#{</#noparse>${paramMap.pkLowerCaseName}, jdbcType=VARCHAR<#noparse>}</#noparse>
	</select>
	 
	<select id="findList" resultType="${table.modelName}">
		SELECT
		<include refid="Base_Column_List" />
		FROM ${table.tableName} 
		<where>
		<#list table.columnList as column>
		<#-- 注释代码
        <#if (column.name != 'id') && (column.name != 'code')>
        	<#if (column.type == 'VARCHAR')>
        	and ${column.sqlName} like
        		<if test="dbName == 'oracle'">'%'||<#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>||'%'</if>
				<if test="dbName == 'mssql'">'%'+<#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>+'%'</if>
				<if test="dbName == 'mysql'">CONCAT<#noparse>('%',#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>, '%'<#noparse>)</#noparse></if> 
        	
        	<#else>
        	and ${column.sqlName} = <#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>
        	</#if>
        <#else>
    		and ${column.sqlName} = <#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>
        </#if>
        -->
		    <if test="${column.name} != null">
		 	    and ${column.sqlName} = <#noparse>#{</#noparse>${column.name},jdbcType=${column.type}<#noparse>}</#noparse>
		    </if>	
		</#list>	
		</where>
	</select>
	
	<update id="deleteAll">
		update ${table.tableName} set del_flag = 1
		WHERE ${paramMap.pk} in
		<foreach item="item" index="index" collection="array" open="("
			separator="," close=")"> <#noparse>#{</#noparse>item<#noparse>}</#noparse>
		</foreach>
	</update>
	
	<select id="findAllList" resultType="${table.modelName}">
		SELECT
			<include refid="Base_Column_List"/>
		FROM ${table.tableName} 
	</select>
	
</mapper>
