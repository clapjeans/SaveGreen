package kopo.poly.controller;


import com.amazonaws.services.codecommit.model.UserInfo;
import kopo.poly.dto.MailDTO;
import kopo.poly.dto.UserInfoDTO;
import kopo.poly.service.IMailService;
import kopo.poly.service.IUserService;
import kopo.poly.util.CmmUtil;
import kopo.poly.util.EncryptUtil;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;


import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

@Slf4j
@Controller
public class UserController {

    //사용자 서비스 활용
    @Resource(name = "UserService")
    private IUserService userService;

    //메일서비스 활용
    @Resource(name = "MailService")
    private IMailService mailService;


    //패스워드 찾기 들어가기
    @RequestMapping(value = "findPwPage")
    public String findPwPage() throws Exception {

        log.info(this.getClass().getName() + ".findPwPage start");

        log.info(this.getClass().getName() + ".findPwPage end");

        return "/login/findPw";
    }


    //로그인 페이지들어가기
    @RequestMapping(value = "loginPage")
    public String loginPage() throws Exception {

        log.info(this.getClass().getName() + ".loginPage start!");

        log.info(this.getClass().getName() + ".loginPage end!");

        return "/login/login";
    }

    //회원등록 ㅠㅔ이지
    @RequestMapping(value = "register")
    public String register() throws Exception {

        log.info(this.getClass().getName() + ".register start!");

        log.info(this.getClass().getName() + ".register end!");

        return "/login/creatUser";
    }

    //회원로그아웃하기
    @RequestMapping(value = "logout")
    public String logout(HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".logout start");


        // session 비움
        session.invalidate();

        // 결과 메세지 전달하기
        model.addAttribute("msg", "로그아웃 성공");
        model.addAttribute("url", "/home");

        log.info(this.getClass().getName() + ".logout end");

        return "/redirect";
    }



    //사용자 생성 
    @RequestMapping(value = "insertUser", method = RequestMethod.POST)
    public String insertUser(HttpServletRequest request, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".insertUser start");

        String msg = "";

        try {

            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email"))); //회원이메일
            String user_name = CmmUtil.nvl(request.getParameter("user_name")); //회원이름
            // 비밀번호 해시 알고리즘 암호화
            String user_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw"))); //회원비밀번호

            log.info("user_email : " + user_email);
            log.info("user_name : " + user_name);
            log.info("user_pw : " + user_pw);

            //유저 정보를 담기위함
            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_email(user_email);
            pDTO.setUser_name(user_name);
            pDTO.setUser_pw(user_pw);


            userService.insertUser(pDTO);

            msg = "회원가입하셨습니다.";

        } catch (Exception e) {
            // 저장 실패 시
            msg = "서버 오류입니다.";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", "/loginPage");

        log.info(this.getClass().getName() + ".insertUser end");

        return "/redirect";
    }

    // email 존재한지 확인하기
    @RequestMapping(value = "getUserExistForAJAX")
    @ResponseBody
    public Map<String, String> getUserExistForAJAX(HttpServletRequest request) throws Exception {

        log.info(this.getClass().getName() + ".getUserExistForAJAX start");

        Map<String, String> rMap = new HashMap<>();

        try {
            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));
            log.info("user_email : " + user_email);

            rMap = userService.getUserExistForAJAX(user_email);

        } catch (Exception e) {
            rMap.put("res", "exception");
            log.info(e.toString());
            e.printStackTrace();
        }

        log.info(this.getClass().getName() + ".getUserExistForAJAX end");

        return rMap;
    }

    //사용자 로그인
    @RequestMapping(value = "/login")
    public String login(HttpServletRequest request, ModelMap model, HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".login start");

        String msg = "";
        String url = "";

        try {

            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));
            // 비밀번호 해시 알고리즘 암호화
            String user_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw")));

            log.info("user_email : " + user_email);
            log.info("user_pw : " + user_pw);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_email(user_email);
            pDTO.setUser_pw(user_pw);


            UserInfoDTO rDTO = userService.getUser(pDTO);
            log.info("rDTO :" + rDTO);
            log.info("user_name"+rDTO.getUser_name());

            if (rDTO.getUser_name()==null) {
                msg = "아이디와 비밀번호를 다시 확인해주세요";
                url = "/loginPage";
            } else {
                String res_user_email = EncryptUtil.decAES128CBC(rDTO.getUser_email());
                String res_user_name = rDTO.getUser_name();

                msg = "환영합니다. " + res_user_name + "님";
                url = "/home";

                //로그인시 이메일 이름저장
                session.setAttribute("SS_USER_EMAIL", res_user_email);
                session.setAttribute("SS_USER_NAME", res_user_name);

                if (res_user_email.equals("admin@email.com")) {
                    session.setAttribute("SS_USER_TYPE", "ADMIN");
                    log.info("ADMIN LOGIN");
                }
            }

        } catch (Exception e) {
            msg = "서버 오류입니다. 다시 시도해주세요.";
            url = "/loginPage";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".login end");

        return "/redirect";

    }

    //비밀번호변경전 로그인하기
    @RequestMapping(value = "updatePwPage")
    public String updatePwPage(HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".updatePwPage start");

        String user_email = CmmUtil.nvl((String) session.getAttribute("SS_USER_EMAIL"));
        log.info("user_email : " + user_email);

        if (user_email.equals("")) {
            model.addAttribute("msg", "로그인이 필요합니다.");
            model.addAttribute("url", "/loginPage");
            return "/redirect";
        }

        log.info(this.getClass().getName() + ".updatePwPage end");

        return "/login/changPw";
    }

    // 사용자 패스워드 바꾸기
    @RequestMapping(value = "updateUserPw")
    public String updateUserPw(HttpServletRequest request, HttpSession session, ModelMap model) throws Exception {

        log.info(this.getClass().getName() + ".updateUserPw start");

        String msg = "";
        String url = "";

        try {

            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_USER_EMAIL")));
            String user_name = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME"));
            // 비밀번호 해시 알고리즘 암호화
            String user_pw = EncryptUtil.encHashSHA256(CmmUtil.nvl(request.getParameter("user_pw")));

            log.info("user_email : " + user_email);
            log.info("user_name : " + user_name);
            log.info("user_pw : " + user_pw);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_email(user_email);
            pDTO.setUser_name(user_name);
            pDTO.setUser_pw(user_pw);

            int res = userService.updateUserPw(pDTO);

            if (res == 1) {
                msg = "성공적으로 비밀번호를 변경했습니다. 다시 로그인 해주세요";
                url = "/home";
                //로그인시 이메일 이름저장
                session.setAttribute("SS_USER_EMAIL", "");
                session.setAttribute("SS_USER_NAME","");
            } else {
                msg = "비밀번호 저장에 실패했습니다.";
                url = "/updatePwPage";
            }

        } catch (Exception e) {
            // 저장 실패 시
            msg = "서버 오류입니다.";
            url = "/updatePwPage";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".updateUserPw end");

        return "/redirect";
    }

    // 새비밀번호 전송
    @PostMapping(value = "findPw")
    public String findPw(HttpServletRequest request, ModelMap model,HttpSession session) throws Exception {

        log.info(this.getClass().getName() + ".findPw start!");

        String msg = "";
        String url = "";

        try {

            String newPW = String.valueOf((int) (Math.random() * 1000000));

            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl(request.getParameter("user_email")));
            String user_name = CmmUtil.nvl(request.getParameter("user_name"));
            // 비밀번호 해시 알고리즘 암호화
            String user_pw = EncryptUtil.encHashSHA256(newPW);

            log.info("user_email : " + user_email);
            log.info("user_name : " + user_name);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_email(user_email);
            pDTO.setUser_name(user_name);
            pDTO.setUser_pw(user_pw);


            int res = userService.updateUserPw(pDTO);

            if (res == 1) {

                MailDTO mDTO = new MailDTO();
                mDTO.setToMail(EncryptUtil.decAES128CBC(user_email));
                mDTO.setTitle(" 새비밀번호 전송!!!");
                mDTO.setContents("changePassword " + newPW);

                int mailRes = mailService.doSendMail(mDTO);

                if (mailRes == 1) {
                    msg = "새 비밀번호를 이메일로 발송했습니다. 로그인 후 변경해주세요.";
                } else {
                    msg = "변경된 비밀번호 발송에 실패했습니다. gusrb8925@naver.com 으로 문의해주세요.";
                }
                url = "/loginPage";

            } else if (res == 0) {
                msg = "정보를 다시 확인해주세요.";
                url = "/findPwPage";
            }

        } catch (Exception e) {
            msg = "서버 오류입니다.";
            url = "/findPwPage";
            log.info(e.toString());
            e.printStackTrace();
        }


        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".findPw end!");

        return "/redirect";
    }


    //사용자 삭제
    @RequestMapping(value = "deleteUser")
    public String deleteUser(HttpSession session, ModelMap model) {

        log.info(this.getClass().getName() + ".deleteUser start!");

        String msg = "";
        String url = "";

        try {

            // 이메일 AES-128-CBC 암호화
            String user_email = EncryptUtil.encAES128CBC(CmmUtil.nvl((String) session.getAttribute("SS_USER_EMAIL")));
            String user_name = CmmUtil.nvl((String) session.getAttribute("SS_USER_NAME"));

            log.info("user_email : " + user_email);
            log.info("user_name : " + user_name);

            UserInfoDTO pDTO = new UserInfoDTO();
            pDTO.setUser_email(user_email);
            pDTO.setUser_name(user_name);


            int res = userService.deleteUser(pDTO);

            log.info("res : "+ res);

            if (res == 1) {
                msg = "성공적으로 계정이 삭제 되었습니다.";
                url = "/home";
                // session 비움
                session.invalidate();
            } else {
                msg = "회원탈퇴에 실패했습니다.";
                url = "/home";
            }

        } catch (Exception e) {
            // 유저 정보 삭제 실패 시
            msg = "서버 오류입니다.";
            url = "/home";
            log.info(e.toString());
            e.printStackTrace();
        }

        model.addAttribute("msg", msg);
        model.addAttribute("url", url);

        log.info(this.getClass().getName() + ".deleteUser end!");

        return "/redirect";
    }



}
