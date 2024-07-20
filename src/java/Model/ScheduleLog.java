/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author sinan
 */
public class ScheduleLog {
    private int staffID;
    private WorkSession WorkSessionID;
    private WeekOfYear dateId;
    private int dayOfWeek;
   

    public ScheduleLog(int staffID, WorkSession WorkSessionID, WeekOfYear dateId, int dayOfWeek) {
        this.staffID = staffID;
        this.WorkSessionID = WorkSessionID;
        this.dateId = dateId;
        this.dayOfWeek = dayOfWeek;
    }
    
    
    public int getStaffID() {
        return staffID;
    }

    public void setStaffID(int staffID) {
        this.staffID = staffID;
    }

    public WorkSession getWorkSessionID() {
        return WorkSessionID;
    }

    public void setWorkSessionID(WorkSession WorkSessionID) {
        this.WorkSessionID = WorkSessionID;
    }

    public WeekOfYear getDateId() {
        return dateId;
    }

    public void setDateId(WeekOfYear dateId) {
        this.dateId = dateId;
    }

    public int getDayOfWeek() {
        return dayOfWeek;
    }

    public void setDayOfWeek(int dayOfWeek) {
        this.dayOfWeek = dayOfWeek;
    }
    
    
    
}
