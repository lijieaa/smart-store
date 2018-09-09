package ${packageName}.${moduleName}.controller;

import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import javax.validation.Valid;
import java.util.List;
import java.util.Map;
import com.jpm.common.entity.JqGridEntity;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
import org.springframework.security.access.prepost.PreAuthorize;
import com.jpm.common.anno.advice.NoRslt;
import ${packageName}.${moduleName}.entity.${ClassName}Entity;
import ${packageName}.${moduleName}.service.${ClassName}Service;


/**
 * ${functionName}Controller
 * @author ${functionAuthor}
 * @version ${functionVersion}
 */
@Api(value = "${functionName}", description = "${functionName}")
@RestController
@RequestMapping("api/${moduleName}/${class_name}")
public class ${ClassName}RestController {

    @Autowired
    ${ClassName}Service ${className}Service;

    @ApiOperation("根据id获取${functionNameSimple}")
    @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET,value = "{id}")
    public ${ClassName}Entity get(@PathVariable(value="id") String id){
        ${ClassName}Entity entiy = ${className}Service.find(id);
        return entiy;
    }

    @ApiOperation("普通分页")
    @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET,value = "page")
    public PageInfo page(@RequestParam Integer page
            ,@RequestParam Integer rows
            ,@RequestParam(required = false) Map data){
        PageInfo pageInfo = ${className}Service.findPage(page,rows,data);
        return pageInfo;
    }


    /**
     * jggrid表格分页
     * @param data
     * @return
     */
    @ApiOperation("jggrid表格分页")
    @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET,value = "jggrid")
    public JqGridEntity<${ClassName}Entity> jqGrid(@RequestParam Map data){
    PageInfo pageInfo = ${className}Service.findJgGridPage(data);
    JqGridEntity<${ClassName}Entity> gridEntity=new JqGridEntity<${ClassName}Entity>(pageInfo.getPageNum(),pageInfo.getPages(),pageInfo.getTotal(),pageInfo.getList());
        return gridEntity;
        }

        @ApiOperation("查询所有${functionNameSimple}")
        @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET,value = "list")
    public List<${ClassName}Entity> list(@RequestParam(required = false) Map data){
    List<${ClassName}Entity> list = ${className}Service.findAll(data);
        return list;
    }
                @ApiOperation("创建${functionNameSimple}")
                @PreAuthorize("hasAuthority('${class_name}:add')")
        @RequestMapping(method = RequestMethod.POST)
        public int save(@RequestBody @Valid @ApiParam(name="${functionNameSimple}",value="传入json格式",required=true) ${ClassName}Entity entity){

            return ${className}Service.add(entity);
        }
                @ApiOperation("修改${functionNameSimple}")
                @PreAuthorize("hasAuthority('${class_name}:edit')")
        @RequestMapping(method = RequestMethod.PUT)
        public int update(@RequestBody @Valid @ApiParam(name="${functionNameSimple}",value="传入json格式",required=true) ${ClassName}Entity entity){

        return ${className}Service.update(entity);
        }
                @ApiOperation("删除${functionNameSimple}")
                @PreAuthorize("hasAuthority('${class_name}:delete')")
        @RequestMapping(method = RequestMethod.DELETE,value = "{id}")
        public int delete(@PathVariable(value="id") @ApiParam(name="多个id用,分隔",value="id字符串",required=true)String[] ids){

        return ${className}Service.remove(ids);
        }



                <#list table.cols as c>
                    <#if c.isPk?? && c.name != "id" && c.isPk=="1">
                        @ApiOperation("根据${functionNameSimple}${c.comments}查询")
                        @PreAuthorize("hasAuthority('${class_name}:view')")
                        @NoRslt
                        @RequestMapping(method = RequestMethod.GET, value = "${c.javaFieldId}")
                        public boolean get${c.javaFieldId?cap_first}(@RequestParam ${c.javaType} ${c.javaFieldId},@RequestParam(required = false)
            String id) {
                            return (${className}Service.findBy${c.javaFieldId?cap_first}(${c.javaFieldId},id)!=null)?false:true;
                        }
                    </#if>
                </#list>
        }