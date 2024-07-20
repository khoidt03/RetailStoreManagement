/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package utils;
 
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.security.SecureRandom;
import java.util.Properties; 
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

/**
 *
 * @author ADMIN
 */
public class SendEmail {
    public void SendEmail(HttpServletRequest request, String email) throws ServletException, IOException{
        request.setCharacterEncoding("UTF-8");
        HttpSession mySession = request.getSession();
        SecureRandom random = new SecureRandom();
        int otpvalue = 100000 + random.nextInt(900000); 
        String to = email;// change accordingly
        // Get the session object
        Properties props = new Properties();
        props.put("mail.smtp.host", "smtp.gmail.com");
        props.put("mail.smtp.socketFactory.port", "465");
        props.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.port", "465");
        Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication("bestinall283@gmail.com", "padzriukpgvtbjdk");// Put your email 
            }
        }); 
        try {
            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(email));// change accordingly
            message.addRecipient(Message.RecipientType.TO, new InternetAddress(to));
            message.setSubject("Request password reset");
            String text = "Your OTP code is: " + otpvalue + ". Please enter this code to reset password!";
            message.setText(text);
            // send message
            Transport.send(message);
            System.out.println("message sent successfully");
        } catch (MessagingException e) {
            throw new RuntimeException(e);
        }
        mySession.setAttribute("otp",otpvalue);  
        mySession.setMaxInactiveInterval(60);
    }
}
