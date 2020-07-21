package com.atguigu.controller;

import com.atguigu.bean.Employee;
import com.atguigu.bean.Msg;
import com.atguigu.dao.EmployeeMapper;
import com.atguigu.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 处理员工的CRUD请求
 *
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    ///checkuser请求处理
    @RequestMapping("/checkuser")
    @ResponseBody
    //@RequestParam明确的向其提出要求，我要访问的是empName
    public Msg checkuser(@RequestParam(value = "empName") String empName){
        //先判断用户名是否是合法的表达式

        String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";

        if(!empName.matches(regx)){
            return Msg.fail().add("va_Msg","用户名应该是2-5位中文或是6-16位英文");
        }

        //数据库用户名重复校验
        boolean b = employeeService.checkUser(empName);

        if (b){
            return Msg.success();
        }else {
            return Msg.fail().add("va_Msg","用户名不可用");
        }
    }

    ///emps请求处理
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithDept(@RequestParam(value="pn",defaultValue="1")Integer pn){
        //这个查询一次性会查出1000条，并不是分页查询
        //引入pageHelper插件
        //调用PageHelper自带的方法，startPage，传入的页码pn，以及页面大小pageSize
        PageHelper.startPage(pn,5);

        //在startPage这个方法之后的查询就是分页查询了
        List<Employee> emp = employeeService.getAll();

        //使用pageInfo 包装查询后的结果
        PageInfo pg = new PageInfo(emp,5);
        return Msg.success().add("PageInfo",pg);
    }

    ///emp请求处理，POST
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmps(@Valid Employee employee, BindingResult bindingResult){

        //校验
        if (bindingResult.hasErrors()){

            //校验失败，返回失败，在模态框中显示校验失败的信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = bindingResult.getFieldErrors();
            for(FieldError fieldError : errors){
                System.out.println("错误字段："+fieldError.getField());
                System.out.println("错误信息："+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }

            return Msg.fail().add("errorFields",map);

        }else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }

    }
    ///emp/{id}请求处理，GET
    //根据id查询员工
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id){

        Employee employee =  employeeService.getEmp(id);
        return Msg.success().add("emp",employee);

    }
    //更新员工
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult bindingResult){
        employeeService.updateEmp(employee);
        return Msg.success();
    }
    //删除员工
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    @ResponseBody
    public Msg delEmp(@PathVariable("ids") String ids){
        //如果包含一个-，那么就是批量删除。否则是单个删除
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            //split以-分割
            String[] str_ids = ids.split("-");
            //组装id的集合
            for (String string : str_ids){
                del_ids.add(Integer.parseInt(string));
            }
                employeeService.deleteBatch(del_ids);
        }else {
            //将ids使用parseInt转为Int类型
            Integer id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);

        }
        return Msg.success();
    }
}
