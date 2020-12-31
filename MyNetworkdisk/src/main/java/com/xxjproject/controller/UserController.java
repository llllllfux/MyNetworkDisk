package com.xxjproject.controller;

import com.xxjproject.domain.Msg;
import com.xxjproject.domain.User;
import com.xxjproject.service.UserService;
import com.xxjproject.util.FileUtil;
import com.xxjproject.vo.ModifyPasswordCheck;
import com.xxjproject.vo.UserRegisterData;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

/**
 * @author xuxingjun
 * @data 2020/12/12  -  10:59
 */
@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @ResponseBody
    @RequestMapping("/registerCheck.do")
//    public String userRegister(String registerUsername,String registerPassword,String registerEmail){
    //后端采用jsr303校验
    public Msg userRegisterCheck(@Valid UserRegisterData user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            System.out.println("注册失败");
            return Msg.fail();
        } else {
//            userService.userRegister(new User(user.getRegisterUsername(),user.getRegisterPassword(),user.getRegisterEmail()));
            System.out.println("注册成功");
            return Msg.success();
        }
    }

    @RequestMapping("/register.do")
    @ResponseBody
//    public String userRegister(String registerUsername,String registerPassword,String registerEmail){
    public Msg userRegister(@Valid UserRegisterData user, BindingResult bindingResult) {
        if (bindingResult.hasErrors()) {
            System.out.println("注册失败");
            return Msg.fail();
        } else {
            userService.userRegister(new User(user.getRegisterUsername(), user.getRegisterPassword(), user.getRegisterEmail()));
            System.out.println("注册成功");
            return Msg.success();
        }
    }

    @ResponseBody
    @RequestMapping("/login.do")
    public Msg userLogin(String loginAccount, String loginPassword, HttpServletRequest request) {
        User userLoginByUsername = userService.userLoginByUsername(loginAccount);
        if (userLoginByUsername != null && loginPassword.equals(userLoginByUsername.getPassword())) {
//            System.out.println("userLoginByUsername = " + userLoginByUsername.toString());
//            ModelAndView mv = new ModelAndView();
//            mv.setViewName("/hello");
            System.out.println("可以登录！！");
            int role = userLoginByUsername.getRole();
            int totalFileSize = userLoginByUsername.getTotalFileSize();
            String viewTotalFileSize = FileUtil.getViewFileSize(totalFileSize);
            System.out.println("viewTotalFileSize = " + viewTotalFileSize);
            HttpSession session = request.getSession();
            session.setAttribute("username", loginAccount);
            session.setAttribute("role",role);
            session.setAttribute("viewTotalFileSize",viewTotalFileSize);
            return Msg.success().add("username", loginAccount);

        } else {
            System.out.println("不可以登录！！");

            return Msg.fail();
        }
    }


    @ResponseBody
    @RequestMapping("/checkRegisterEmailIsExist.do")
    public Msg checkRegisterEmailIsExist(String emailCheck) {
        System.out.println("email = " + emailCheck);
        User user = userService.userRegisterCheckEmailIsExist(emailCheck);
        if (user != null) {
            return Msg.fail().add("emailIsExist", "此邮箱已经注册");
        } else {
            return Msg.success().add("emailIsNotExist", "邮箱可以使用");
        }
    }

    @ResponseBody
    @RequestMapping("/checkRegisterUsernameIsExist.do")
    public Msg checkRegisterUsernameIsExist(String usernameCheck) {
        System.out.println("usernameCheck = " + usernameCheck);
        User user = userService.userRegisterCheckUsernameIsExist(usernameCheck);
        if (user != null) {
            return Msg.fail().add("usernameIsExist", "此用户已被使用");
        } else {
            return Msg.success().add("usernameIsNotExist", "用户名可以使用");
        }
    }

    @ResponseBody
    @RequestMapping("/checkLoginUsernameIsExist.do")
    public Msg checkLoginUsernameIsExist(String usernameCheck) {
        System.out.println("usernameCheck = " + usernameCheck);
        User user = userService.userRegisterCheckUsernameIsExist(usernameCheck);
        if (user != null) {
            return Msg.success().add("usernameIsExist", "");
        } else {
            return Msg.fail().add("usernameIsNotExist", "此用户未注册");
        }
    }

    @RequestMapping("/quit.do")
    public String quit(HttpServletRequest request) {
        request.getSession().removeAttribute("username");
        return "login";
    }

//    @RequestMapping("/passwordModify.do")
//    public String passwordModify(String username,String oldPassword,String newPassword,String confirmPassword,HttpServletRequest request){
//        System.out.println("密码修改！！");
//        request.getSession().removeAttribute("username");
//        if (newPassword == confirmPassword){
//            String password = userService.getUserByUsername(username).getPassword();
//        }
//        return "login";
//    }

    //    @ResponseBody
    @RequestMapping("/passwordModify.do")
    public String passwordModifyCheck(String username, String newPassword) {
        System.out.println("开始密码修改！！");
        userService.modifyPasswordByUsername(username, newPassword);
        return "login";
    }

    @ResponseBody
    @RequestMapping("/passwordModifyCheck.do")
    public Msg passwordModify(@Valid ModifyPasswordCheck user, BindingResult bindingResult) {
        System.out.println("修改密码检查");

        if (bindingResult.hasErrors()) {
            System.out.println("检查失败");
            return Msg.fail().add("error", "请按规范输入数据！！");
        } else {
            String username = user.getUsername();
            String oldPassword = user.getOldPassword();
            String newPassword = user.getNewPassword();
            String confirmPassword = user.getConfirmPassword();
            if (newPassword.equals(confirmPassword)) {
                if (!newPassword.equals(oldPassword)) {
                    String password = userService.getUserByUsername(username).getPassword();
                    if (password.equals(oldPassword)) {
                        return Msg.success().add("success", "");
                    } else {
                        return Msg.fail().add("error", "账号或密码错误！！");
                    }
                } else {
                    return Msg.fail().add("error", "新密码与原密码不能相同！！");
                }
            } else {
                return Msg.fail().add("error", "两次密码输入不一致！！");
            }
        }
    }

    @ResponseBody
    @RequestMapping("/GetVIP.do")
    public Msg getVIP(String username,String activationCode){
        if ("adminXXJ001".equals(activationCode)){
            userService.grantUserVIPByUsername(username);
            return Msg.success();
        }else{
            return Msg.fail();
        }
    }

    @ResponseBody
    @RequestMapping("/getUserInfo.do")
    public Msg getUserInfo(String username){
        User userByUsername = userService.getUserByUsername(username);
        String viewFileSize = FileUtil.getViewFileSize(userByUsername.getTotalFileSize());
        System.out.println("viewFileSize = " + viewFileSize);
        return Msg.success().add("user",userByUsername).add("viewFileSize",viewFileSize);
    }

}
