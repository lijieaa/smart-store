package ${packageName}.${moduleName}.dao;

import com.jpm.common.dao.CrudDao;
import org.apache.ibatis.annotations.Param;
import ${packageName}.${moduleName}.entity.${ClassName}Entity;

/**
 * ${functionName}DAO接口
 * @author ${functionAuthor}
 * @version ${functionVersion}
 */
public interface ${ClassName}Dao extends CrudDao<${ClassName}Entity,String> {
<#list table.cols as c>
 <#if c.isPk?? && c.name != "id" && c.isPk=="1">
        public ${ClassName}Entity select${c.javaFieldId?cap_first}(@Param("${c.javaFieldId}") ${c.javaType} ${c.javaFieldId},@Param("id") String id);
 </#if>
</#list>
}
