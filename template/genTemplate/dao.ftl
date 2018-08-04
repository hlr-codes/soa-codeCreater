package ${paramMap.packageName}.dao;

import com.minstone.common.persistence.CrudDao;
import com.minstone.common.persistence.annotation.MyBatisDao;
import ${paramMap.packageName}.model.${table.modelName};
import java.util.Map;

/**
 * ${table.comment}持久层
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */
@MyBatisDao
public interface ${table.modelName}Dao extends CrudDao<${table.modelName}> <#noparse>{</#noparse>
    /**
     * 根据条件批量更新
     * @author ${paramMap.author}
     * @date ${.now?string("yyyy-MM-dd")} 
     */
	int updateSome(Map<String,Object> condition);
<#noparse>}</#noparse>