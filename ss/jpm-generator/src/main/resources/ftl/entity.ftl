package ${packageName}.${moduleName}.entity;

<#list table.importList as i>
import ${i};
</#list>
import com.jpm.common.entity.DataEntity;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
/**
 * ${functionName}Entity
 * @author ${functionAuthor}
 * @version ${functionVersion}
 */
@ApiModel(value="${functionName}",description="${functionName}")
public class ${ClassName}Entity extends DataEntity<${ClassName}Entity,String> {

	private static final long serialVersionUID = 1L;
<#-- 生成字段属性 -->
<#list table.cols as c>
<#-- 如果不是基类属性 -->
    <#if c.isNotBaseField>
		<#if c.comments??>@ApiModelProperty(value="${c.comments}",name="${c.simpleJavaField}") </#if>
	private ${c.simpleJavaType} ${c.simpleJavaField};        <#if c.comments??>// ${c.comments}</#if>
    </#if>
</#list>
<#-- 构造方法 -->
	public ${ClassName}Entity() {
		super();
	}

	public ${ClassName}Entity(String id){
		super(id);
	}

<#-- 生成get和set方法 -->
<#list table.cols as c>
<#-- 如果不是基类属性 -->
    <#if c.isNotBaseField>
        <#list c.simpleAnnotationList as a>
		@${a}
        </#list>
	public ${c.simpleJavaType} get${c.simpleJavaField?cap_first}() {
		return ${c.simpleJavaField};
	}

	public void set${c.simpleJavaField?cap_first}(${c.simpleJavaType} ${c.simpleJavaField}) {
		this.${c.simpleJavaField} = ${c.simpleJavaField};
	}
	</#if>
</#list>
}