
package Model;

public class SystemLog {
    private int id; 
    private User user_id; 
    private String date;
    private String action;
    private UserInfo info;
    public SystemLog(int id, User user_id, String date, String action,UserInfo info) {
        this.id = id;
        this.user_id = user_id;
        this.date = date;
        this.action = action;
        this.info=info;
    }

    public UserInfo getInfo() {
        return info;
    }

    public void setInfo(UserInfo info) {
        this.info = info;
    }
    

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public User getUser_id() {
        return user_id;
    }

    public void setUser_id(User user_id) {
        this.user_id = user_id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }
    
}
