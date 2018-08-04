package ${paramMap.packageName}.service;



import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.minstone.common.service.CrudService;
import ${paramMap.packageName}.dao.${table.modelName}Dao;
import ${paramMap.packageName}.model.${table.modelName};
import java.util.Map;

/**
 * ${table.comment}事务层
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */
@Service
@Transactional(readOnly = true)
public class ${table.modelName}Service extends CrudService<${table.modelName}Dao,${table.modelName}> <#noparse>{</#noparse>
	/**
     * 根据条件批量更新
     * @author ${paramMap.author}
     * @date ${.now?string("yyyy-MM-dd")} 
     */
    @Transactional(readOnly = false)
	public int updateSome(Map<String,Object> condition){
		return dao.updateSome(condition);
	}
<#noparse>}</#noparse>