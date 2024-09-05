package kr.bit.entity;

import java.sql.Date;

import lombok.Data;

@Data
public class Member {
	 private int meidx;
	 private String memID;
	 private String memPwd;
	 private String memName;
	 private String memPhone;
	 private String memAddr;
	 private double latitude;
	 private String longitude;	
	 private Date date;
}