import com.atguigu.bean.Department;
import com.atguigu.bean.Employee;
import com.atguigu.dao.DepartmentMapper;
import com.atguigu.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;
    @Test
    public void testCRUD(){
        System.out.println(departmentMapper);
        //插入几个部门,Selective有选择的插入，因为dept_id是自增的字段，所以我们只需要插入dept_name
//        departmentMapper.insertSelective(new Department(null, "开发部"));
//        departmentMapper.insertSelective(new Department(null, "测试部"));
        //插入几个员工，同样Selective有选择的插入
        //employeeMapper.insertSelective(new Employee(null, "jerry", "1", "jerry@189.com", 1));
        //批量插入员工，使用可以做批量操作的sqlSession
//        for(){
////            employeeMapper.insertSelective(new Employee(null, , "1", "jerry@189.com", 1));
////        }
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i=0;i < 1000;i++){
            String uid = UUID.randomUUID().toString().substring(0,5) + i;
            employeeMapper.insertSelective(new Employee(null, uid, "1", uid + "jerry@189.com", 1));
        }
        System.out.println("批量完成");
    }
}
