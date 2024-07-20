/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author sinan
 */
public class WorkSession {
    private int WorkSessionId;
    private String WorkSessionName;
    private String start_time;
    private String end_time;

    public WorkSession(int WorkSessionId, String WorkSessionName, String start_time, String end_time) {
        this.WorkSessionId = WorkSessionId;
        this.WorkSessionName = WorkSessionName;
        this.start_time = start_time;
        this.end_time = end_time;
    }

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
    }

    public int getWorkSessionId() {
        return WorkSessionId;
    }

    public void setWorkSessionId(int WorkSessionId) {
        this.WorkSessionId = WorkSessionId;
    }

    public String getWorkSessionName() {
        return WorkSessionName;
    }

    public void setWorkSessionName(String WorkSessionName) {
        this.WorkSessionName = WorkSessionName;
    }
    
    
}
