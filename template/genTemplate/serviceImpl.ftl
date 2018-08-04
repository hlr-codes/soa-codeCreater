package ${paramMap.packageName}.api;

import java.util.List;
import java.util.Map;
import javax.validation.ConstraintViolationException;
import javax.validation.Validator;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageInfo;
import com.google.common.collect.Lists;
import com.minstone.common.constant.PublicConstant;
import com.minstone.common.exception.CommonException;
import com.minstone.common.utils.IdGen;
import ${paramMap.packageName}.model.${table.modelName};
import ${paramMap.packageName}.service.${table.modelName}Service;
import ${paramMap.packageName}.service.I${table.modelName}Api;

/**
 * ${table.comment}事务层
 * 
 * @copyright 广州明动软件股份有限公司 Copyright (c) ${.now?string("yyyy")}  
 * @since ${.now?string("yyyy-MM-dd")} 
 * @author ${paramMap.author}
 * @version 1.0
 * 
 */
@Service("${paramMap.lowerCaseModelName}Api")
public class ${table.modelName}ApiImpl implements I${table.modelName}Api <#noparse>{</#noparse>

	private Logger LOGGER = LoggerFactory.getLogger(${table.modelName}ApiImpl.class);
	
	@Autowired
	private ${table.modelName}Service entityService;

	@Autowired
	private Validator validator;
	
	@Override
	public ${table.modelName} get(${table.modelName} entity) {
		try {
			entity.entityValidator(entity, validator, "${paramMap.pkLowerCaseName}");
			return entityService.get(entity);
		}catch (ConstraintViolationException cvEx) {
			LOGGER.error("参数校验失败,异常信息：", cvEx);
		}catch(Exception e) {
			LOGGER.error("报错-位置：[${table.modelName}ApiImpl->get]", e);
		}
		return null;
	}

	@Override
	public boolean saveOrUpdate(${table.modelName} entity) throws CommonException {
		boolean rtn = false;

		if(entity.getIsNewRecord()) {
			if(StringUtils.isNoneBlank(entity.get${paramMap.pkName}())){
				if(get(entity) != null) {
					throw new CommonException("保存失败，数据库${paramMap.tableName}（"+entity.get${paramMap.pkName}()+"）已存在!");
				}
			}else{
				entity.set${paramMap.pkName}(IdGen.uuid());
			}
			entityService.insert(entity);
		}else{
			entityService.update(entity);
		}
		rtn = true;	
		return rtn;
	}

	@Override
	public List<${table.modelName}> findAllList() {
		try {
			List<${table.modelName}> dbList = entityService.findAllList();
			return dbList;
		}catch(Exception e) {
			LOGGER.error("报错-位置：[${table.modelName}ApiImpl->findAllList]", e);
		}
		return Lists.newArrayList();
	}

	@Override
	public PageInfo<${table.modelName}> findPage(PageInfo<${table.modelName}> page,
			${table.modelName} entity) {
		try {
			return entityService.findPage(page, entity);
		}catch (ConstraintViolationException cvEx) {
			LOGGER.error("参数校验失败,异常信息：", cvEx);
		}catch(Exception e) {
			LOGGER.error("报错-位置：[${table.modelName}ApiImpl->findPage]", e);
		}
		return null;
	}

	@Override
	public boolean delete(${table.modelName} entity) throws CommonException {
		boolean rtn = false;
		entity.entityValidator(entity, validator, "${paramMap.pkLowerCaseName}");
		if(entityService.delete(entity) > 0) {
			rtn = true;
		}
		return rtn;
	}

	@Override
	public boolean deleteAll(${table.modelName} entity) throws CommonException {
		boolean rtn = false;
		entity.entityValidator(entity, validator, "${paramMap.pkLowerCaseName}");
		String[] arrayString = entity.get${paramMap.pkName}().split(",");
		if(entityService.deleteAll(arrayString)>0) {
			rtn = true;
		}
		return rtn;
	}

	@Override
	public boolean insert(${table.modelName} entity) throws CommonException {
		entity.entityValidator(entity, validator, "${paramMap.pkLowerCaseName}");
		entity.setIsNewRecord(true);
		entity.setDelFlag(0);
		if(get(entity) != null) {
			throw new CommonException("保存失败，数据库（"+entity.get${paramMap.pkName}()+"）已存在!");
		}
		return entityService.insert(entity)>0;
	}

	@Override
	public boolean update(${table.modelName} entity)throws CommonException  {
		entity.entityValidator(entity, validator, "${paramMap.pkLowerCaseName}");
		entity.setIsNewRecord(false);
		return entityService.update(entity)>0;
	}

	@Override
	public List<${table.modelName}> findList(${table.modelName} entity) {
		try {
			return entityService.findList(entity);
		}catch (ConstraintViolationException cvEx) {
			LOGGER.error("参数校验失败,异常信息：", cvEx);
		}catch(Exception e) {
			LOGGER.error("报错-位置：[${table.modelName}ApiImpl->findList]", e);
		}
		return Lists.newArrayList();
	}
	
	@Override
	public List<${table.modelName}> findAllList(${table.modelName} entity) {
		try{
			List<${table.modelName}> areaList = entityService.findAllList(entity);
			if(null != entity) {
				if(StringUtils.isNotBlank(entity.getApplicationCode())){
					//需要做应用系统过滤
					List<${table.modelName}> tempList = Lists.newArrayList();
					for(${table.modelName} a : areaList) {
						//获取指定应用系统和公共系统的区域数据
						if(PublicConstant.APPLICATION_CODE.equals(a.getApplicationCode())
								|| entity.getApplicationCode().equals(a.getApplicationCode())) {
							tempList.add(a);
						}
					}
					return tempList;
				}
			}
			return areaList;
		}catch (ConstraintViolationException cvEx) {
			LOGGER.error("参数校验失败,异常信息：", cvEx);
		}catch(Exception e) {
			LOGGER.error("报错-位置：[${table.modelName}ApiImpl->findAllList]", e);
		}
		return Lists.newArrayList();
	}
	@Override
	public int updateSome(Map<String,Object> condition) throws CommonException  {
		return entityService.updateSome(condition);
	}
<#noparse>}</#noparse>