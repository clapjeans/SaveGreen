package kopo.poly.persistance.mapper;

import java.util.List;
import java.util.Map;

public interface IUserMapper {
    // 유저 회원가입
    void insertUser(String colNm, Map<String, Object> pMap) throws Exception;

    // 유저 회원가입 여부, 이메일
    Map<String, String> getUserExistForAJAX(String colNm, String user_email) throws Exception;

    // 유저 로그인
    Map<String, String> getUser(String colNm, Map<String, String> pMap) throws Exception;

    // 유저 비밀번호 변경
    int updateUserPw(String colNm, Map<String, Object> pMap) throws Exception;

    // 유저 정보 삭제
    int deleteUser(String colNm, Map<String, Object> pMap) throws Exception;

<<<<<<< HEAD

=======
    int saveUserRate(String colNm, Map<String, Object> pMap) throws Exception;

    List<Map<String, String>> getUserList(String colNm) throws Exception;
>>>>>>> aca8c8a62c55bf03fab80311b9e0d446ec850867


}