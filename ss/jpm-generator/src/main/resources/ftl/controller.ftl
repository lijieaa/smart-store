package ${packageName}.${moduleName}.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.access.prepost.PreAuthorize;

/**
 * ${functionName}Controller
 * @author ${functionAuthor}
 * @version ${functionVersion}
 */
@Controller
@RequestMapping("${moduleName}/${class_name}")
public class ${ClassName}Controller {

    @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET, value = "list")
    public String list() {
        return "${moduleName}/${class_name}_list";
    }

    @PreAuthorize("hasAuthority('${class_name}:add')")
    @RequestMapping(method = RequestMethod.GET, value = "add_form")
    public String add() {
        return "${moduleName}/${class_name}_form";
    }

    @PreAuthorize("hasAuthority('${class_name}:edit')")
    @RequestMapping(method = RequestMethod.GET, value = "edit_form")
    public String edit() {
        return "${moduleName}/${class_name}_form";
    }

    @PreAuthorize("hasAuthority('${class_name}:view')")
    @RequestMapping(method = RequestMethod.GET, value = "detail")
    public String detail() {
        return "${moduleName}/${class_name}_detail";
    }
}
