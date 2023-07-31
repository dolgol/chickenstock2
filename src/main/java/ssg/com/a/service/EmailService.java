package ssg.com.a.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailException;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;


@Service
public class EmailService {

    private final JavaMailSender mailSender;

    @Autowired
    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    public void sendVerificationEmail(String email, String verificationCode) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(email);
        message.setFrom("mailtestcjh@gmail.com");
        message.setSubject("[ChickenStock] 비밀번호 찾기 인증번호를 확인해주세요.");
        message.setText("안녕하세요! ChickenStock 입니다. \n\n 아래의 인증번호를 정확히 입력해주세요. \n\n 인증번호 : " + verificationCode);

        try {
           mailSender.send(message);
            System.out.println("이메일 발송 성공 - 주소: " + email + ", 인증번호 : " + verificationCode);
        } catch (MailException e) {
            System.out.println("이메일 발송 실패 - 주소: " + email + ", 인증번호 : " + verificationCode);
            e.printStackTrace();
        }
    }
}
