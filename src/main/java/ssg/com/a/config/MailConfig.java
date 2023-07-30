package ssg.com.a.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

   @Bean
    public JavaMailSender mailSender() {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        mailSender.setHost("smtp.gmail.com"); // SMTP 서버 호스트명
        mailSender.setPort(587); // SMTP 서버 포트 (일반적으로 587을 사용)
        mailSender.setUsername("mailtestcjh@gmail.com"); // 이메일 계정
        mailSender.setPassword("xohvhfpztqxdzaqo"); // 이메일 계정 비밀번호

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "false"); // 디버그 모드 (필요에 따라 true/false 설정)

        return mailSender;
    }
}
