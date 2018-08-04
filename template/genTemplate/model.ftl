package ${paramMap.packageName}.model;

<#list table.importClassList as importClass> 
${importClass}
</#list>
import com.minstone.kpi.configure.common.CommonBaseEntity;
/**
 * ${table.comment},对应的数据库表-->${table.tableName}
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */
public class ${table.modelName} extends CommonBaseEntity<${table.modelName}> <#noparse>{</#noparse>

	private static final long serialVersionUID = 1L;

	private String[] codes;//${table.comment}所有编码
	
	<#list table.columnList as column>
	<#if column.name != "id" && column.name != "isValid" && column.name != "createTime"
	   && column.name != "year" && column.name != "creator" && column.name != "createDate"
	   && column.name != "modifier" && column.name != "modifyDate" && column.name != "applicationCode" 
	   && column.name != "delFlag" >
	/** ${column.comment} */
	private ${column.fileType} ${column.name};
	</#if>
	</#list>
	
	<#list table.columnList as column>
	<#if column.name != "id" && column.name != "isValid" && column.name != "createTime"
	   && column.name != "year" && column.name != "creator" && column.name != "createDate"
	   && column.name != "modifier" && column.name != "modifyDate" && column.name != "applicationCode" 
	   && column.name != "delFlag" >
	/**
	 * 获取${column.comment}
	 */
	public ${column.fileType} get${column.name?cap_first}() <#noparse>{</#noparse>
		return ${column.name};
	<#noparse>}</#noparse>
	/**
	 * 设置${column.comment}
	 */
	public void set${column.name?cap_first}(${column.fileType} ${column.name}) <#noparse>{</#noparse>
		this.${column.name} = ${column.name};
	<#noparse>}</#noparse>
	</#if>
	</#list>
	
	public String[] getCodes() {
		return codes;
	}

	public void setCodes(String[] codes) {
		this.codes = codes;
	}
<#noparse>}</#noparse>