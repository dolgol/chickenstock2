package ssg.com.a.dto;

public class MessageDto {
    String role;
    Object content;

    public MessageDto(String role, Object content) {
        this.role = role;
        this.content = content;
    }
    
    
}
