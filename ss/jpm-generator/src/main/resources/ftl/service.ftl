package ${packageName}.${moduleName}.service;

import java.util.List;
import java.util.Map;
import com.github.pagehelper.PageInfo;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import com.jpm.common.service.CrudService;
import ${packageName}.${moduleName}.entity.${ClassName}Entity;
import ${packageName}.${moduleName}.dao.${ClassName}Dao;

/**
 * ${functionName}Service
 * @author ${functionAuthor}
 * @version ${functionVersion}
 */
@Service
@Transactional(readOnly = true)
public class ${ClassName}Service extends CrudService<${ClassName}Dao, ${ClassName}Entity,String> {

    @Autowired
    ${ClassName}Dao ${className}Dao;

	@Override
    public ${ClassName}Entity find(String id) {
        return super.find(id);
    }

    @Override
    public ${ClassName}Entity find(${ClassName}Entity entity) {
        return super.find(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int add(${ClassName}Entity entity) {
        return super.add(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int update(${ClassName}Entity entity) {
        return super.update(entity);
    }

    @Transactional(readOnly = false)
    @Override
    public int remove(String[] ids) {
        return super.remove(ids);
    }

    @Override
    public PageInfo findPage(Integer page,Integer rows,Map data) {
        return super.findPage(page,rows,data);
    }

    @Override
    public PageInfo findJgGridPage(Map data) {
        return super.findJgGridPage(data);
    }

    @Override
    public List<${ClassName}Entity> findAll(Map data) {
        return super.findAll(data);
    }

    <#list table.cols as c>
        <#if c.isPk?? && c.name != "id" && c.isPk=="1">
        public ${ClassName}Entity findBy${c.javaFieldId?cap_first}(${c.javaType} ${c.javaFieldId}, String id){
            return ${className}Dao.select${c.javaFieldId?cap_first}(${c.javaFieldId}, id);
        }
        </#if>
    </#list>
}