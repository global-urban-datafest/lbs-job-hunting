package co.working.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Parameter;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "t_resumeDetail")
public class ResumeDetail implements Serializable{
	@Id
	@GenericGenerator(name = "pkGenerator", strategy = "foreign", parameters = { @Parameter(name = "property", value = "resume") })
	@GeneratedValue(generator = "pkGenerator")
	private int id;// 自增长位

	@Column(name = "realname")
	private String realname;// 真实姓名

	@Column(name = "sex")
	private Integer sex;// 性别

	@Column(name = "birthday")
	private Date birthday;// 生日

	@Column(name = "workyear")
	private Integer workyear;// 工作年限

	@Column(name = "documenttype")
	private Integer documenttype;// 证件类型

	@Column(name = "documentcode")
	private String documentcode;// 证件号

	@Column(name = "livingaddress")
	private String livingaddress;// 居住地

	@Column(name = "email")
	private String email;// email

	@Column(name = "qq")
	private String qq;

	@Column(name = "wechat")
	private String wechat;

	@Column(name = "mobile")
	private String mobile;// 手机

	@Column(name = "companytel")
	private String companytel;// 公司电话

	@Column(name = "hometel")
	private String hometel;// 家庭电话

	@Column(name = "salary")
	private Integer salary;// 当前年薪

	@Column(name = "jobstatus")
	private Integer jobstatus;// 当前工作状态

	@Column(name = "hometown")
	private String hometown;// 家庭地址

	@Column(name = "marriagestatus")
	private Integer marriagestatus;// 婚姻状态

	@Column(name = "height")
	private Double height;// 身高

	@Column(name = "politicstatus")
	private Integer politicstatus;// 政治状态

	@Column(name = "photo")
	private String photo;// 简历头像

	@Column(name = "zip")
	private String zip;// 邮编

	@Column(name = "worktype")
	private Integer worktype;// 工作类型

	@Column(name = "workspace")
	private String workspace;// 工作地点

	@Column(name = "positiontype")
	private Integer positiontype;// 期望职业角色

	@Column(name = "exceptsalary")
	private String exceptsalary;// 期望薪水

	@Column(name = "selfIntrodution")
	private String selfIntrodution;// 自我介绍

	@Column(name = "onboardingdate")
	private String onboardingdate;// 就职日期
	
	// --------------------------------
	@Lob
	@Column(name="skillDetail")
	private String skills;// 熟悉技能
	@Lob
	@Column(name="companyDetail")
	private String companys;// 工作经历
	@Lob
	@Column(name="awardDetail")
	private String awards;// 奖惩经历
	@Lob
	@Column(name="experienceDetail")
	private String experiences;// 项目经历

	@OneToOne
	private Resume resume;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public Integer getSex() {
		return sex;
	}

	public void setSex(Integer sex) {
		this.sex = sex;
	}

	public Date getBirthday() {
		return birthday;
	}

	public void setBirthday(Date birthday) {
		this.birthday = birthday;
	}

	public Integer getWorkyear() {
		return workyear;
	}

	public void setWorkyear(Integer workyear) {
		this.workyear = workyear;
	}

	public Integer getDocumenttype() {
		return documenttype;
	}

	public void setDocumenttype(Integer documenttype) {
		this.documenttype = documenttype;
	}

	public String getDocumentcode() {
		return documentcode;
	}

	public void setDocumentcode(String documentcode) {
		this.documentcode = documentcode;
	}

	public String getLivingaddress() {
		return livingaddress;
	}

	public void setLivingaddress(String livingaddress) {
		this.livingaddress = livingaddress;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getCompanytel() {
		return companytel;
	}

	public void setCompanytel(String companytel) {
		this.companytel = companytel;
	}

	public String getHometel() {
		return hometel;
	}

	public void setHometel(String hometel) {
		this.hometel = hometel;
	}

	public Integer getSalary() {
		return salary;
	}

	public void setSalary(Integer salary) {
		this.salary = salary;
	}

	public Integer getJobstatus() {
		return jobstatus;
	}

	public void setJobstatus(Integer jobstatus) {
		this.jobstatus = jobstatus;
	}

	public String getHometown() {
		return hometown;
	}

	public void setHometown(String hometown) {
		this.hometown = hometown;
	}

	public Integer getMarriagestatus() {
		return marriagestatus;
	}

	public void setMarriagestatus(Integer marriagestatus) {
		this.marriagestatus = marriagestatus;
	}

	public Double getHeight() {
		return height;
	}

	public void setHeight(Double height) {
		this.height = height;
	}

	public Integer getPoliticstatus() {
		return politicstatus;
	}

	public void setPoliticstatus(Integer politicstatus) {
		this.politicstatus = politicstatus;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getZip() {
		return zip;
	}

	public void setZip(String zip) {
		this.zip = zip;
	}

	public Integer getWorktype() {
		return worktype;
	}

	public void setWorktype(Integer worktype) {
		this.worktype = worktype;
	}

	public String getWorkspace() {
		return workspace;
	}

	public void setWorkspace(String workspace) {
		this.workspace = workspace;
	}

	public Integer getPositiontype() {
		return positiontype;
	}

	public void setPositiontype(Integer positiontype) {
		this.positiontype = positiontype;
	}

	public String getExceptsalary() {
		return exceptsalary;
	}

	public void setExceptsalary(String exceptsalary) {
		this.exceptsalary = exceptsalary;
	}

	public String getSelfIntrodution() {
		return selfIntrodution;
	}

	public void setSelfIntrodution(String selfIntrodution) {
		this.selfIntrodution = selfIntrodution;
	}

	public String getOnboardingdate() {
		return onboardingdate;
	}

	public void setOnboardingdate(String onboardingdate) {
		this.onboardingdate = onboardingdate;
	}

	public String getQq() {
		return qq;
	}

	public void setQq(String qq) {
		this.qq = qq;
	}

	public String getWechat() {
		return wechat;
	}

	public void setWechat(String wechat) {
		this.wechat = wechat;
	}

	public Resume getResume() {
		return resume;
	}

	public void setResume(Resume resume) {
		this.resume = resume;
	}

	public String getSkills() {
		return skills;
	}

	public void setSkills(String skills) {
		this.skills = skills;
	}

	public String getCompanys() {
		return companys;
	}

	public void setCompanys(String companys) {
		this.companys = companys;
	}

	public String getAwards() {
		return awards;
	}

	public void setAwards(String awards) {
		this.awards = awards;
	}

	public String getExperiences() {
		return experiences;
	}

	public void setExperiences(String experiences) {
		this.experiences = experiences;
	}



}
